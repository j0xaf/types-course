{ compiler ? "ghc864", pkgs ? import <nixpkgs> {} }:

let

  haskellPackages = pkgs.haskell.packages.${compiler};
  drv = haskellPackages.callCabal2nix "types-course" ./. {};

in
  {
    types-course = drv;
    types-course-shell = haskellPackages.shellFor {
      packages = p: [drv];
      withHoogle = true;
      buildInputs = with pkgs; [
        cabal-install
        hlint
        (haskell.lib.justStaticExecutables haskellPackages.ghcid)];
    };
  }
