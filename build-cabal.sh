#!/usr/bin/env bash

nix-shell --pure --run "cabal configure; cabal build"
