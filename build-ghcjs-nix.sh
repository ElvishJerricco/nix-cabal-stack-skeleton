#!/usr/bin/env bash

nix-build --arg haskellPackages "(import <nixpkgs> {}).haskell.packages.ghcjs"
