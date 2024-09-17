.PHONY: update
update:
	home-manager switch --option eval-cache false --flake .#lea

.PHONY: clean
clean:
	nix-collect-garbage -d
