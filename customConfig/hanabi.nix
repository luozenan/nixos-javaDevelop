{ pkgs, stdenv, fetchFromGitHub, ... }:
stdenv.mkDerivation rec {
  pname = "gnome-ext-hanabi";
  version = "latest";
  
  src = fetchFromGitHub {
    owner = "jeffshee";
    repo = "gnome-ext-hanabi";
    # 这里使用一个已知可行的修订版本，你也可以换成最新的 commit hash
    rev = "13200e5fed8624f313743588fbe4045d6e298e5f";
    sha256 = "sha256-YzB/BsJSwdWZ48qlzP+Fd7s/ZptDKBuuJFGFjoIsh9w=";
  };
  
  dontBuild = false;
  
  nativeBuildInputs = with pkgs; [
    meson ninja glib nodejs wrapGAppsHook4
    appstream-glib gobject-introspection
  ];
  
  buildInputs = with pkgs; [
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    gjs gtk4
  ];
  
  dontWrapGApps = true;
  
  postPatch = ''
    patchShebangs build-aux/meson-postinstall.sh
  '';
   postInstall = ''
    mv "$out/share/glib-2.0/schemas" "$out/share/gnome-shell/extensions/hanabi-extension@jeffshee.github.io/schemas"
  '';
  postFixup = ''
    wrapGApp "$out/share/gnome-shell/extensions/hanabi-extension@jeffshee.github.io/renderer/renderer.js"
  '';
}
