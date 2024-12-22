{ pkgs ? import <nixpkgs> {} }:

let hp = pkgs.haskellPackages; in
pkgs.mkShell {
    buildInputs = with pkgs; [
        gcc
        hp.ghc
        hp.cabal-install
        hp.stack
        hp.haskell-language-server
        hp.hlint
        hp.ormolu
        hp.hoogle
        pkg-config
        zlib
    ];
}
