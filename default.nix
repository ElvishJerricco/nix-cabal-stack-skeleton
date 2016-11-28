{ pkgs ? import <nixpkgs> {}
, haskellPackages ? pkgs.haskellPackages}:

let haskellOverrides = self: super: {
#      somePackage = self.callHackage "somePackage" "0.version.bump.0" {};
    };
    hp = haskellPackages.override { overrides = haskellOverrides; };

in pkgs.haskell.lib.overrideCabal (hp.callPackage (import ./cabal.nix) {}) (self: {
  src = builtins.filterSource (path: type:
    type != "unknown"
    && baseNameOf path != ".git"
    && baseNameOf path != "result"
    && baseNameOf path != "dist"
    && baseNameOf path != ".stack-work"
  ) self.src;
})
