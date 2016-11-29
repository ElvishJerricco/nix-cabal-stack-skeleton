{ pkgs ? import <nixpkgs> {}
, haskellPackages ? pkgs.haskellPackages }:

let overrideCabal = pkg: pkgs.haskell.lib.overrideCabal pkg ({ buildDepends ? [], ... }: {
      buildDepends = buildDepends ++ [ pkgs.cabal-install ];
    });

in (overrideCabal (import ./default.nix { inherit pkgs haskellPackages; })).env
