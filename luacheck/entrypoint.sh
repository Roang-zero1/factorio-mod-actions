#!/bin/sh

echo "${LUACHECKRC_URL}"
if [ -z "$LUACHECKRC_URL" ]
then
  ls -la
  if [ ! -f .luacheckrc ]
  then
    echo "ERROR: No .luacheckrc present and no \$LUACHECKRC_URL provided" 1>&2
    exit 1
  fi
else
  curl $LUACHECKRC_URL -o .luacheckrc
fi
luacheck .

