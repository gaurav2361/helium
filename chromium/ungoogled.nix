{
  lib,
  stdenv,
  python3Packages,
  makeWrapper,
  patch,
}:

{
  rev ? "local",
  hash ? null,
}:

stdenv.mkDerivation {
  pname = "helium-patches";

  version = "local";

  src = lib.cleanSource ./..;

  dontBuild = true;

  buildInputs = [
    python3Packages.python
    patch
  ];

  nativeBuildInputs = [
    makeWrapper
  ];

  patchPhase = ''
    sed -i '/chromium-widevine/d' patches/series
  '';

  installPhase = ''
    mkdir $out
    cp -R * $out/
    wrapProgram $out/utils/patches.py --add-flags "apply" --prefix PATH : "${patch}/bin"
  '';
}
