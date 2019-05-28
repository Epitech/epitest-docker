#!/bin/bash

#Force pull latest fedora:30 image
docker pull fedora:30

WD=$(dirname $0)
[ -z "$WD" ] && exit 1
cd $(dirname $0)

# TODO make clean optional, use existing files

[ -z "$PWD" ] && exit 1

# Default options
DEFAULT_TAG="devel"       # docker tag

# Platform specifications
plat_path_prefix=""
PLAT=$(uname -s)
MSYS_PLAT_PATTERN="MINGW(32|64)_NT.*"
if [[ $PLAT =~ $MSYS_PLAT_PATTERN ]] # MSYS Specification
then
	# MSYS automatically transform POSIX style path to Win32 style path
	# but docker only handle POSIX style path
	#
	# Adding '/' at the begining of the path tells MSYS to not
	# convert to Win32 style path
	#
	# (http://www.mingw.org/wiki/Posix_path_conversion)
	plat_path_prefix="/"
fi

function usage {
	local NAME="$(basename $0)"
	echo "$NAME - epitest-docker build script"
	echo "        Build the epitest-docker image from sources"
	echo ""
	echo "Usage"
	echo "    $NAME [-n] [-t TAG]"
	echo "    $NAME -c"
	echo ""
	echo "    -t TAG           tag to apply to the docker image"
	echo "                     default: $DEFAULT_TAG"
	echo "    -n               pass --no-cache to docker build"
	echo "    -c               only remove temporary files, do not build"
}

function quit {
	echo $1 >&2
	exit 1
}

# Read opts

TAG=$DEFAULT_TAG
BRANCH=$DEFAULT_BRANCH
REPO=$DEFAULT_REPO
DOCKER_OPTS=

while [[ $# -gt 0 ]]; do
	key="$1"

	case $key in
		-h|--help)
		usage
		exit 0
		;;
		-t|--tag)
		TAG=$2
		shift
		;;
		-n)
		DOCKER_OPTS="$DOCKER_OPTS --no-cache"
		;;
		-c)
		echo "Temporary files removed"
		exit 0
		;;
		*)
		echo "Unsupported argument $1"
		exit 1
		;;
	esac

	shift
done

echo "epitest-docker build.sh -t $TAG"

# Build image

echo ">>> Build image epitest-docker:$TAG"
docker build$DOCKER_OPTS -t epitechcontent/epitest-docker:$TAG .

[[ $? -eq 0 ]] || quit "Failed to build docker image"
