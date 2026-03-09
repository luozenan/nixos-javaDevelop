{ config, pkgs, pkgs-unstable, ... }:
let
  # 自定义Maven版本
  customMaven = pkgs.maven.overrideAttrs (old: rec {
    version = "3.3.9";  # 指定想要的版本
    # 从Apache官网复制对应版本的下载链接和SHA256哈希
    src = pkgs.fetchurl {
      url = "https://archive.apache.org/dist/maven/maven-3/${version}/binaries/apache-maven-${version}-bin.tar.gz";
      sha256 = "sha256-bj6clJq0aVogT3QDhxeqeyaJsb6Uh1iZrBs/5CgA/4I="; # 替换为实际哈希
    };
  });
in
{

  programs.java.enable = true;
 
  environment.systemPackages = with pkgs; [
    #java
    tomcat9
    tomcat_mysql_jdbc
    customMaven
    #jdk8_headless
    javaPackages.compiler.openjdk8-bootstrap
    #python
    (python3.withPackages (python-pkgs: with python-pkgs; [
      pandas
      requests
      pygobject3
    ]))
    #rust
    #rustup
    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer
    openssl
    pkg-config
    #C
    gcc
    #database
    postgresql
    mariadb
    #mycli
];
services.mysql = {
  enable = true;
  package = pkgs.mariadb;
};
services.postgresql = {
  enable = true;
};
# environment.variables._JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
 
 #environment.variables._JAVA_AWT_WM_NONREPARENTING = "1";
 environment.etc = {
  "jdk8".source = "${pkgs.javaPackages.compiler.openjdk8-bootstrap}"; # 固定指向 nixpkgs 中的 jdk8 包
  "maven".source = "${customMaven}";
  "rust-analyzer".source = "${pkgs.rust-analyzer}";
};
environment.variables = {
    # 默认JDK 8路径（自动匹配nix/store中的openjdk8）
    JAVA_HOME = "${pkgs.javaPackages.compiler.openjdk8-bootstrap}";
    # Maven 3.3.9路径
    MAVEN_HOME = "${customMaven}";
    # 把JDK/Maven的bin目录加入PATH
   M2_REPO = "${config.users.users.luozenan.home}/.m2/repository";
   OPENSSL_DIR = "${pkgs.openssl}";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
    environment.pathsToLink = [ "/home/luozenan/.cargo/bin" ];
    
}

