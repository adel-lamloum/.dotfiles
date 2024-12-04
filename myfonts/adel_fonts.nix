{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "adel_fonts";
  src = /home/adel/.dotfiles/myfonts;  # Absolute path to your font directory

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    find ${src} -type f \( -iname "*.ttf" -o -iname "*.otf" \) -exec cp {} $out/share/fonts/truetype/ \;
  '';
}
