{ pkgs ? import <nixpkgs> {}
, haskellPackages ? pkgs.haskellPackages
, withHoogle ? false }:

let haskellOverrides = self: super:
    ( if withHoogle
      then {
        ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
        ghcWithPackages = self.ghc.withPackages;
      } else {}
    ) // {
#      somePackage = self.callHackage "somePackage" "0.version.bump.0" {};
    };
    hp = haskellPackages.override { overrides = haskellOverrides; };
    cabal2nixResult = src: pkgs.runCommand "cabal2nixResult" {
      buildCommand = ''
        cabal2nix file://"${src}" >"$out"
      '';
      buildInputs = [ pkgs.cabal2nix ];

      # Support unicode characters in cabal files
      ${if !pkgs.stdenv.isDarwin then "LOCALE_ARCHIVE" else null} = "${pkgs.glibcLocales}/lib/locale/locale-archive";
      ${if !pkgs.stdenv.isDarwin then "LC_ALL" else null} = "en_US.UTF-8";
    } "";

in pkgs.haskell.lib.overrideCabal (hp.callPackage (cabal2nixResult ./.) {}) (self: {
  src = builtins.filterSource (path: type:
    type != "unknown"
    && baseNameOf path != ".git"
    && baseNameOf path != "result"
    && baseNameOf path != "dist"
    && baseNameOf path != ".stack-work"
  ) self.src;
})
