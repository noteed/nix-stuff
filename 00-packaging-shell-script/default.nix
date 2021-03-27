let
  pkgs = import <nixpkgs> {};
in {
  hello = pkgs.stdenv.mkDerivation {
    name = "hello";
    src = ./bin;
    installPhase = ''
      mkdir -p $out/bin
      cp hello.sh $out/bin/hello
    '';
  };
}
