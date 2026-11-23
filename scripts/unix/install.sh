#!/usr/bin/env bash
set -e

UNINSTALL="false"
if [ "$1" == "--uninstall" ]; then
    UNINSTALL="true"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/../../templates" && pwd)"

# Detect Zed config dir
ZED_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zed"
TASKS_PATH="$ZED_CONFIG_DIR/tasks.json"
KEYMAP_PATH="$ZED_CONFIG_DIR/keymap.json"

# Check for NixOS read-only symlink
if [ -L "$TASKS_PATH" ] || [ -L "$KEYMAP_PATH" ]; then
    REAL_PATH_TASKS=$(readlink -f "$TASKS_PATH" 2>/dev/null || true)
    REAL_PATH_KEYMAP=$(readlink -f "$KEYMAP_PATH" 2>/dev/null || true)
    if [[ "$REAL_PATH_TASKS" == /nix/store/* ]] || [[ "$REAL_PATH_KEYMAP" == /nix/store/* ]]; then
        echo "⚠️ Error: Target file is a read-only symlink in /nix/store/."
        echo "💡 Please use nix/home-manager.nix to manage your Zed configuration instead."
        exit 1
    fi
fi

mkdir -p "$ZED_CONFIG_DIR"

# Export variables for embedded Python script
export UNINSTALL="$UNINSTALL"
export TASKS_PATH="$TASKS_PATH"
export KEYMAP_PATH="$KEYMAP_PATH"
export TEMPLATE_TASKS_PATH="$TEMPLATE_DIR/tasks.json"
export TEMPLATE_KEYMAP_PATH="$TEMPLATE_DIR/keymap.json"

# Python script for robust JSONC merge and atomic write
python3 << 'PYTHON_SCRIPT'
import json
import re
import sys
import os

uninstall = os.environ.get('UNINSTALL') == 'true'
tasks_path = os.environ.get('TASKS_PATH')
keymap_path = os.environ.get('KEYMAP_PATH')
template_tasks_path = os.environ.get('TEMPLATE_TASKS_PATH')
template_keymap_path = os.environ.get('TEMPLATE_KEYMAP_PATH')

def strip_jsonc(text):
    # Remove single-line comments (//) safely without breaking strings
    text = re.sub(r'("(?:[^"\\]|\\.)*")|//.*?(?=\r?\n|$)', r'\1', text)
    # Remove trailing commas before } or ]
    text = re.sub(r',(\s*[}\]])', r'\1', text)
    return text

def load_json(path):
    if not os.path.exists(path):
        return []
    with open(path, 'r', encoding='utf-8') as f:
        text = f.read()
    clean_text = strip_jsonc(text)
    if not clean_text.strip():
        return []
    return json.loads(clean_text)

def save_json(path, data):
    temp_path = path + '.tmp'
    with open(temp_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    # Atomic write
    os.replace(temp_path, path)

# Tasks merge
existing_tasks = load_json(tasks_path)
with open(template_tasks_path, 'r', encoding='utf-8') as f:
    new_tasks = json.loads(strip_jsonc(f.read()))

new_labels = [t.get('label') for t in new_tasks]
merged_tasks = [t for t in existing_tasks if t.get('label') not in new_labels]
if not uninstall:
    merged_tasks.extend(new_tasks)
save_json(tasks_path, merged_tasks)

# Keymaps merge
existing_keymaps = load_json(keymap_path)
with open(template_keymap_path, 'r', encoding='utf-8') as f:
    new_keymaps = json.loads(strip_jsonc(f.read()))

merged_keymaps = []
for item in existing_keymaps:
    if isinstance(item, dict) and 'bindings' in item and 'ctrl-alt-r' in item['bindings']:
        continue
    merged_keymaps.append(item)

if not uninstall:
    merged_keymaps.extend(new_keymaps)
save_json(keymap_path, merged_keymaps)

action = "dihapus" if uninstall else "ditambahkan/diperbarui"
print(f"✅ Konfigurasi Repomix berhasil {action} di Zed!")
PYTHON_SCRIPT