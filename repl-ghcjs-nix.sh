#!/usr/bin/env bash

nix-shell --pure --arg haskellPackages "(import <nixpkgs> {}).haskell.packages.ghcjs" --run "ghcjs --interactive"
