{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = true;
    history.extended = true;
    shellAliases =
      let
        flakeDir = "/etc/nixos/";
      in
      {
        nixup = "sudo nixos-rebuild switch --flake ${flakeDir}#nixos && sudo rm -rf ~/.cache/tofi-drun";
        nixupd = "nix flake update --flake ${flakeDir}";
        nixupg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}#nixos";
        nixconf = "micro ${flakeDir}modules/system/configuration.nix";
        nixpkgs = "micro ${flakeDir}modules/system/packages.nix";
        nixclean = "sudo nix-collect-garbage -d";
        nixcleangen = "sudo nix-collect-garbage --delete-older-than 14d";
        ls = "eza -ha --icons=auto --sort=name --group-directories-first";
        ll = "eza -lh --icons=auto";
        ff = "fastfetch";
        chw = "nohup sh -c 'awww img ${config.stylix.image} && { pkill ironbar || true; } && ironbar' >/dev/null 2>&1 &";
        clear = "clear && printf $'\\033c'";
        homeclean = "home-manager expire-generations -d";
        nixorphans = "nix store gc && sudo nix store optimize";
        nixwipe = "sudo nix profile wipe-history";
      };

    initContent = ''
      export PATH="$HOME/.cache/npm/global/bin:$PATH"
      export PATH="$HOME/.nix-profile/bin:$PATH"

      export QS_ICON_THEME="Nordzy"

      precmd() { echo; }
    '';
    antidote = {
      enable = true;
      plugins = [
        "zdharma-continuum/fast-syntax-highlighting"
      ];
    };
  };
}
