#!/bin/bash

# install by latest commit hash short or long foramt (e7d832bc6a3a82046ecf0f4f83c5cde28989ee42) at the time of development
forge install smartcontractkit/ccip@b06a3c2eecb9892ec6f76a015624413fffa1a122 --no-commit
# or install the latest version by but it's using the older version 2.9.0 so using the commit hash
forge install smartcontractkit/ccip --no-commit 
forge install smartcontractkit/foundry-chainlink-toolkit --no-commit

# For testing
forge install smartcontractkit/chainlink-local --no-commit