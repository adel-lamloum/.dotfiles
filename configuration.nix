{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos> 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #services.xserver.inputMethod = "ibus";  # Enable ibus input method
  # enable Hyprland


  programs.hyprland.enable = true; 
  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adel = {
    isNormalUser = true;
    home = "/home/adel";
    description = "adel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      zsh
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.adel = { pkgs, ... }: {
    home.packages = with pkgs; [
      zsh-syntax-highlighting
      zsh-autosuggestions
    ];

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "random";
      };
      initExtra = ''
        # Customize your zsh configuration here
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        fastfetch
      '';
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.05";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";

  # Enable zsh globally
  programs.zsh.enable = true;

  # enable zsh
  users.defaultUserShell = pkgs.zsh;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # allow flatpak
  services.flatpak.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    gimp
    emacs
    brave
    git
    vlc
    tauon
    zsh
    obs-studio
    audacity
    fd
    fzf
    gh
    cmatrix
    telegram-desktop
    zathura
    zoom-us
    yt-dlp
    libreoffice-qt6-fresh
    fastfetch  
    fragments  
    htop
    gedit
    swww
    calibre
    unzip
    ripgrep
    krita
    meld
    figlet
    syncthing
    vscode
    xcolor
    feh
    lolcat
    gnome-extension-manager
    gnome.gnome-tweaks
    nodejs_22
    python3
    kdenlive
    krop
    imagemagick
    qutebrowser
    netsurf.browser
    variety
    aria2
    gparted
    handbrake
    neovim
  ];

  #----=[ Fonts ]=----#
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "UbuntuSans" "UbuntuMono" "DroidSansMono" ]; })  

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      cascadia-code
      fira-code-symbols
      font-awesome
      proggyfonts
      scheherazade-new
      scheherazade
      amiri
      ubuntu_font_family
    ];
    fontconfig = {
      defaultFonts = {
        serif = [  "Liberation Serif" "amiri" ];
        sansSerif = [ "UbuntuSans Nerd Font" "Noto Naskh Arabic" ];
        monospace = [ "UbuntuMono Nerd Font" "Noto Naskh Arabic"];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
