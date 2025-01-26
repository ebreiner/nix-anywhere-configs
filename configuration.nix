{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  networking.hostId = "XXXXXXXX";
  networking.hostName = "YYYYYYYY";

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-cache.aermel.net:nIgjKq1imiwaDAF0YtMsJ84AYVQPODXaXN4P2f3rI58="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.vim
    pkgs.python3
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBB2NZZtLTwJZS69fyWvXCHcgE0CUv4lLfBN1M61gtza emil@barney"
  ];

  system.stateVersion = "24.05";
}
