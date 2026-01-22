{ config, pkgs, ... }:

{

#nixpkgs.config.permittedInsecurePackages = [
              #  "openssl-1.1.1w"
            #  ];
environment.systemPackages = with pkgs; [
    openvpn
 ];
 nixpkgs.overlays = [
    (final: prev: {
      openvpn = prev.openvpn.override {
       # openssl = prev.openssl_1_1;
       openssl = prev.openssl_legacy;
      };
    })
  ];
  
services.openvpn.servers = {
   # officeVPN  = {
    #  config = "config /home/luozenan/vpn/tmp.ovpn"; 
     # authUserPass = {
      #   username = "124";
      #	 password = "124";
     # };
      
   # };
    
  };


}

