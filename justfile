_:
    just --list

[working-directory("nix")]
switch:
    sudo -H ./scripts/switch.sh

alias s := switch

[working-directory("nix")]
update:
    sudo -H ./scripts/update.sh

alias u := update
