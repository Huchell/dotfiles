#!/usr/bin/bash

function help() {
	echo """
Script to help manage and sync config folders with this repo:
  - apply [...folder]  | applies latest versions from the repository to local config
  - save [...folder]   | saves local config folders to repository
  - list               | lists all saved configs
  - help               | prints this message
"""
}

function apply() {
	local config=$1
	for folder in ${@:2}; do
		echo "applying: '$folder' to '$config/$folder'"
		cp -r "$folder/." -t "$config/$folder"
	done
}

function save() {
	local config=$1
	for folder in ${@:2}; do
		local copy_folder="$config/$folder"
		if [ -d "$copy_folder/.git" ]; then
			echo "$copy_folder is a git repositoy, setting up submodule"
			continue
		fi

		echo "saving: '$copy_folder' to '$folder'"
		cp -r "$copy_folder/." -t "$folder"
	done
}

function list() {
	echo "LIST"
}

config="$HOME/.config"
case $1 in
	"apply" ) apply "$config" ${@:2} ;;
	"save" ) save "$config" ${@:2} ;;
	"list" ) list ;;
	"help" ) help ;;
	* ) echo "Invalid command" >&2 ;;
esac
