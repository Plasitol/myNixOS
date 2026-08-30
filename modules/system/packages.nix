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
	 tree

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
	 cinny-desktop
	 # inputs.kompas-3d.packages.${pkgs.stdenv.hostPlatform.system}.kompas3d
	 gimp
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
