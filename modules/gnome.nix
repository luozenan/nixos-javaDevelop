{ config, pkgs, lib, inputs, ... }: {

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];
  services.xserver.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};
  services.gnome.core-apps.enable = false;
  services.gnome.localsearch.enable = false;
  services.gnome.tinysparql.enable = false;
  programs.dconf.enable = true;
  services.gnome.gnome-online-accounts.enable = true;

services.gnome.gnome-remote-desktop.enable = true; # 'true' does not make the unit start automatically at boot
systemd.services.gnome-remote-desktop = { 
  wantedBy = [ "graphical.target" ]; # for starting the unit automatically at boot
};
#services.displayManager = {
 #   autoLogin.enable = true;
  #  autoLogin.user = "luozenan";
   # defaultSession = "gnome";
#};
  # 精简不想要的服务
  services.packagekit.enable = false;


 environment.gnome.excludePackages = with pkgs; [
    # 精简不想安装的包
    gnome-music
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-photos
    gnome-tour
    geary
    totem
    gnome-software
    gnome-user-docs
    baobab
    decibels
    epiphany
    #gnome-text-editor
    #gnome-console
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-system-monitor
    gnome-weather
    loupe
    #nautilus
    #seahorse
    papers
    showtime
    simple-scan
    snapshot
    yelp
  ];


  environment.systemPackages = with pkgs; [
    xorg.xrandr
    desktop-file-utils
    gnome-console
    gnome-text-editor
    nautilus
    gnome-tweaks
    seahorse
    gnome-online-accounts
    gnome-system-monitor
  ] ++ (with gnomeExtensions; [
    kimpanel
    dash-to-dock
    clipboard-history
    extension-list
    docker
    hide-top-bar
    blur-my-shell
    app-menu-is-back
    forge
    gsconnect
    rdp-and-ssh-connect
    logo-menu
    toggle-proxy
    rounded-window-corners-reborn
    desktop-icons-ng-ding
    astra-monitor
  ]);
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";  
  };

}
