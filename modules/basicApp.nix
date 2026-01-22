{ config, pkgs, ... }:

{
# Install firefox.
  #programs.firefox.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins = {
      lualine.enable = true;
    };
   opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    }; 
  };
  programs.fish.enable = true;
   users.extraUsers.luozenan = {
    shell = pkgs.fish;
  };
  programs.bash = {
  interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm | tr -d '\n') != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
};

  environment.systemPackages = with pkgs; [
    neovim   
    zip
    unzip
    git
    wget
    yazi
    google-chrome
    appimage-run
    fastfetch
    xwayland-satellite
    libnotify
    pciutils
    usbutils
    linux-firmware 
 ];

  # 启用 libvirt 服务，这是使用 virt-manager 的前提
  virtualisation.libvirtd = {
    enable = true;
   # 启用 virtiofsd 支持，这会自动处理 qemu 依赖
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
}

