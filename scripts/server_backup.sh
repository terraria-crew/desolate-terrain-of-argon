#!/usr/bin/env bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $script_dir; repo_root="$(git rev-parse --show-toplevel)"; popd;
timestamp=`date "+%Y.%m.%d.%H.%M.%S"`
worldname=Desolate_Terrain_of_Argon

cd /opt/terraria/data/worlds
7z a -t7z $repo_root/worlds/$timestamp-$worldname.wld.7z $worldname.wld
