#!/usr/bin/env bash
selected=$(find ~/projects/personal/ ~/projects/supersolid/ ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)

plugin="file:/home/sean/projects/personal/zellij-sessionizer/target/wasm32-wasip1/debug/zellij-sessionizer.wasm"

for file in "$selected"; do
	if [[ $file == *.kdl ]]; then
		zellij pipe --plugin "$plugin" --name set_layout -- "$file"
		break
	fi
done
zellij pipe --plugin "$plugin" --name switch_session -- $selected
