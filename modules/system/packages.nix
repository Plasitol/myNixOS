{
  pkgs,
  inputs,
  unstable,
  ...
}:

{
  environment.systemPackages = with pkgs; [
   # Devtools
   devenv
	 git

	 # CLI
	 eza
	 awww
	 ripgrep
	 fastfetch

   # Slices
	 ripdrag
   xwayland-satellite

   # Security
	 sops
	 age
	 ssh-to-age

	 # Apps
	 qimgv
	 vlc
	 obsidian
	 inputs.kompas-3d.packages.${pkgs.stdenv.hostPlatform.system}.kompas3d
  ];

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    unstable.ubuntu-sans-mono
    unstable.ubuntu-sans
    unstable.googlesans-code
  ];
}
