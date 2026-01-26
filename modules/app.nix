{ config, pkgs, inputs, ... }:

{

  environment.systemPackages = [
     inputs.apifox-github.packages.${pkgs.stdenv.hostPlatform.system}.apifox
     inputs.electerm-github.packages.${pkgs.stdenv.hostPlatform.system}.electerm
     inputs.finalshell-github.packages.${pkgs.stdenv.hostPlatform.system}.finalshell
 ]++ (with pkgs; [
    #wps
     wpsoffice-cn
     #社交 https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage
     # nix store add-file 
     # wechat
      (pkgs.wechat.overrideAttrs (oldAttrs: {
      src = fetchurl {
          url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
          hash = "sha256-+r5Ebu40GVGG2m2lmCFQ/JkiDsN/u7XEtnLrB98602w=";
        };
    }))
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

