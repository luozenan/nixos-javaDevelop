{ config, pkgs, inputs, ... }:

{

  environment.systemPackages = [
     inputs.apifox-github.packages.${pkgs.stdenv.hostPlatform.system}.apifox
     inputs.electerm-github.packages.${pkgs.stdenv.hostPlatform.system}.electerm
 ]++ (with pkgs; [
    #wps
     onlyoffice-desktopeditors
     #社交 https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage
     # nix store add-file 
     #wechat-uos
     qq
    #(pkgs.wechat.overrideAttrs (oldAttrs: {
     #   version = "4.1.0.16";
      #  src = fetchurl {
       #   url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
        #  hash = "sha256-Pfl81lNVlMJWyPqFli1Af2q8pRLujcKCjYoILCKDx8U=";
        #};
     #}))
     thunderbird
     # 远程
     parsec-bin
     #sunshine
     #moonlight
     #开发
     jetbrains.idea
     jetbrains.datagrip
     vscode
     zed-editor
     #jetbrains.rust-rover
     #vpn
     #v2raya
     easytier
     dae
     #redis client
     tiny-rdm
     #会议软件
     wemeet
     #壁纸
     #音乐
     lx-music-desktop
    # qqmusic
    # 内存占用查询
    #ps_mem
    # 虚拟机
    gnome-boxes
    #截图
    grim
    satty
    # 录屏
    obs-studio
    # AI
    opencode
    claude-code
  ]);

 environment.etc = {
  "claude".source = "${pkgs.claude-code}"; # 固定指向 nixpkgs 中的 jdk8 包
};
# 远程
services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
};

 #services.v2raya.enable = true;
 services.easytier = {
    enable = true;
    instances."nixos".configFile = "/home/luozenan/easytier.toml";
 };
 services.dae = {
    enable = true;
    configFile = "/home/luozenan/.config/dae/config.dae";
 };

virtualisation.docker = {
  enable = true;
  extraOptions = ''
        --registry-mirror=https://registry.linkease.net:5443
  '';
};

# Optional: Add your user to the "docker" group to run docker without sudo
users.users.luozenan.extraGroups = [ "docker" ];

}

