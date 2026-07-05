{ pkgs, lib, ... }:

{
  programs.micro = {
    enable = true;
    settings = {
      softwrap = true;
      tabsize = 2;
      tabstospaces = true;

      autoclose = true;
      autoindent = true;
      autosave = 0;
      savecursor = true;
      saveundo = true;

      ruler = true;
      statusline = true;
      mouse = true;
      scrollspeed = 3;

      backup = true;
      rmtrailingws = true;
    };
  };
}
