VERSION=4.7

PREFIX = ${HOME}/.local
MANPREFIX = ${PREFIX}/share/man

XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

FREETYPELIBS = -lfontconfig -lXft

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
# OpenBSD / Linux
X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# NetBSD
# X11INC = /usr/X11R7/include
# X11LIB = /usr/X11R7/lib
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
# OpenBSD
# FREETYPEINC = ${X11INC}/freetype2
# Linux
FREETYPEINC = /usr/include/freetype2
# -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

INCS = -I${X11INC} -I${FREETYPEINC} -I${HOME}/.cache/themes
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS} -lm -lXrender

CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
CFLAGS   = -O2 -pipe -fstack-protector-all -std=c99 -pedantic -Wall ${INCS} ${CPPFLAGS}
LDFLAGS  = -s ${LIBS}

CC = cc
