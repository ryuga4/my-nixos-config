# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "me-nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "pl";
    defaultLocale = "pl_PL.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git wget vim gparted emacs gnumake gcc firefox glibc cmake
    #KDE
        # Password manager for KDE
    kdeFrameworks.kwallet
    kdeApplications.kwalletmanager
    kwalletcli

    # Allow automatic unlocking of kwallet if the same password. This seems to
    # work without installing kwallet-pam.
    #kwallet-pam

    # ssh-add prompts a user for a passphrase using KDE. Not sure if it is used
    # by anything? ssh-add just asks passphrase on the console.
    #ksshaskpass

    # Archives (e.g., tar.gz and zip)
    ark

    # GPG manager for KDE
    kgpg
    # This is needed for graphical dialogs used to enter GPG passphrases
    pinentry_qt5

    kdeplasma-addons

    # Screenshots
    kdeApplications.spectacle

    # Bluetooth
    bluedevil

    # Text editor
    kate

    # Torrenting
    ktorrent

    # Connect desktop and phone
    kdeconnect

    # Drop-down terminal
    yakuake

    # Printing and scanning
    kdeApplications.print-manager
    simple-scan

    # Document readers
    okular

    # Browsers
    #firefox
    chromium

    # Email
    #kmail
    thunderbird

    # Office suit
    libreoffice
    scribus

    # Vector graphics
    inkscape

    # Photo/image editor
    gwenview
    gimp
    #gimpPlugins.resynthesizer
    #gimpPlugins.ufraw
    digikam5

    # Media player
    vlc

    # KDE apps
    kdeFrameworks.kconfig
    kdeFrameworks.kconfigwidgets
    konsole
    dolphin
    kdeApplications.dolphin-plugins
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "pl";
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport32Bit = true;
  #services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.me = {
    isNormalUser = true;
    home = "/home/me";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;
}
