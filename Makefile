.PHONY: update
update:
	home-manager switch --flake .#nixian

.PHONY: clean
clean:
	nix-collect-garbage -d
