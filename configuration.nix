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
    "https://nix-cache.aermel.net"
  ];
  nix.settings.trusted-public-keys = [
    "nix-cache.aermel.net-1:TkXGTNH8WeYpjMfwxc/AVovN05xPI4wGzNVvlZTpYGk="
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
