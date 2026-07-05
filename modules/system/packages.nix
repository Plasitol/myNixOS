{
  pkgs,
  inputs,
  unstable,
  ...
}:

{
  environment.systemPackages = with pkgs; [
   devenv
	 git
	 eza
	 awww
	 xwayland-satellite

	 sops
	 age
	 ssh-to-age
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
