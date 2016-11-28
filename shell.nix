{ pkgs ? import <nixpkgs> {}
, ghc ? null }:

let haskellPackages = if ghc == null
      then pkgs.haskellPackages
      else pkgs.haskellPackages.override { overrides = (self: super: { ghc = ghc; }); };

    overrideCabal = pkg: pkgs.haskell.lib.overrideCabal pkg ({ buildDepends ? [], ... }: {
      buildDepends = buildDepends ++ [ pkgs.cabal-install haskellPackages.intero ];
    });

in (overrideCabal (import ./default.nix { inherit pkgs haskellPackages; })).env
