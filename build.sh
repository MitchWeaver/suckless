#!/bin/sh -e

# -*-*-*-*-*-*-*-*- SETTINGS -*-*-*-*-*-*-*-*-*-*-*-*-*-*--*
ST_VERSION=e85b6b64660214121164ea97fb098eaa4935f7db     # 12 Feb 2019
DWM_VERSION=cb3f58ad06993f7ef3a7d8f61468012e2b786cab    # 02 Feb 2019
DMENU_VERSION=db6093f6ec1bb884f7540f2512935b5254750b30  # 03 Mar 2019
SURF_VERSION=2355c20e92d6f47100323e3394d565f8e8bf70dc   # 19 Apr 2017
TABBED_VERSION=b5f9ec647aae2d9a1d3bd586eb7523a4e0a329a3 # 10 Mar 2018

export PREFIX=${HOME}/.local
export CFLAGS='-O2 -pipe -s -pedantic -std=c99 -fstack-protector-strong -fexceptions'
export LDFLAGS=-s
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

usage() {
    >&2 echo 'Usage: ./build.sh [dwm] [st] [dmenu] [tabbed] [surf]'
    exit 1
}

clone() {
    cd $1
    [ -d $1 ] || git clone git://git.suckless.org/$1
    cd $1
    git clean -df
    git fetch --all
    git reset --hard $2
    cd "$START_PWD"
}

[ "$1" ] || usage

START_PWD="$PWD"
for name ; do

    case $name in
        dwm)    clone $name $DWM_VERSION ;;
        st)     clone $name $ST_VERSION ;;
        surf)   clone $name $SURF_VERSION ;;
        dmenu)  clone $name $DMENU_VERSION ;;
        tabbed) clone $name $TABBED_VERSION ;;
        *) usage
    esac

    cd $name

    ls patches | while read -r patch ; do
        printf '\n%s\n\n' "===> applying $patch..."
        patch -l -p0 <patches/$patch
    done

    cp -f config/config.h  $name/config.h  2>/dev/null ||:
    cp -f config/config.mk $name/config.mk 2>/dev/null ||:

    cd $name
    make clean >/dev/null
    make -j${NPROC:-1} CC=${CC:-gcc}
    make PREFIX="$PREFIX" install
    cd "$START_PWD"
done
