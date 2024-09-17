.PHONY: update
update:
	home-manager switch --flake .#lea

.PHONY: clean
clean:
	nix-collect-garbage -d
