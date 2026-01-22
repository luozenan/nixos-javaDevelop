{ config, pkgs, inputs, ... }:

{

  environment.systemPackages = [
     inputs.apifox-github.packages.${pkgs.stdenv.hostPlatform.system}.apifox
 ]++ (with pkgs; [
    #wps
     wpsoffice-cn
     #社交 https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage
     # nix store add-file 
     wechat
     thunderbird
     # 远程
     parsec-bin
     sunshine
     #moonlight
     #开发
     jetbrains.idea
     jetbrains.datagrip
     #vpn
     v2raya
     easytier
     #redis client
     tiny-rdm
     #会议软件
     wemeet
     jitsi-meet-electron
   
  ]);


services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
  };

 services.v2raya.enable = true;
 services.easytier = {
    enable = true;
    instances."nixos".configFile = "/home/luozenan/easytier.toml";
 };
}

