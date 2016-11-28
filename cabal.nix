{ mkDerivation, base, scalpel, stdenv }:
mkDerivation {
  pname = "test";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base scalpel ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base ];
  homepage = "https://github.com/githubuser/test#readme";
  description = "Initial project template from stack";
  license = stdenv.lib.licenses.bsd3;
}
