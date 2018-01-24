#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ELLOCASHD=${ELLOCASHD:-$SRCDIR/ellocashd}
ELLOCASHCLI=${ELLOCASHCLI:-$SRCDIR/ellocash-cli}
ELLOCASHTX=${ELLOCASHTX:-$SRCDIR/ellocash-tx}
ELLOCASHQT=${ELLOCASHQT:-$SRCDIR/qt/ellocash-qt}

[ ! -x $ELLOCASHD ] && echo "$ELLOCASHD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
LOCVER=($($ELLOCASHCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for ellocashd if --version-string is not set,
# but has different outcomes for ellocash-qt and ellocash-cli.
echo "[COPYRIGHT]" > footer.h2m
$ELLOCASHD --version | sed -n '1!p' >> footer.h2m

for cmd in $ELLOCASHD $ELLOCASHCLI $ELLOCASHTX $ELLOCASHQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${LOCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${LOCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
