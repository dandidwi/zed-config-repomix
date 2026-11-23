{ config, pkgs, ... }:

let
  templatesDir = ../templates;
in
{
  home.packages = with pkgs; [
    nodejs
  ];

  xdg.configFile."zed/tasks.json".source = "${templatesDir}/tasks.json";
  xdg.configFile."zed/keymap.json".source = "${templatesDir}/keymap.json";
}