#!/bin/sh

export PACKAGE_NAME=$(jq -r .name info.json)
export PACKAGE_VERSION=$(jq -r .version info.json)
export PACKAGE_FULL_NAME=$PACKAGE_NAME\_$PACKAGE_VERSION
export PACKAGE_FILE="$PACKAGE_FULL_NAME.zip"

echo "Creating Package for $PACKAGE_NAME in version $PACKAGE_VERSION"

export BUILD_DIR=.build
export OUTPUT_DIR=$BUILD_DIR/$PACKAGE_FULL_NAME

export PNG_FILES="$(find ./graphics -iname '*.png' -type f)"

echo 'Copying package files'

rm -rf .build dist
mkdir -p $OUTPUT_DIR

find . \
  -type d \
  \(\
    -iname 'locale' -o \
    -iname 'sounds' \
  \)\
  -exec cp -r --parents \{\} $OUTPUT_DIR \;


find . \
  -type f \
  \(\
    -iname '*.md'  -o \
    -iname '*.txt' -o \
    -iname 'info.json' -o \
    -iname 'thumbnail.png' \
  \)\
  -exec cp --parents \{\} $OUTPUT_DIR \;

find . \
  -iname '*.lua' -type f -not -path \"./.*/*\" \
  -exec cp --parents \{\} $OUTPUT_DIR \;

find ./graphics \
  -iname '*.png' -type f \
  -exec cp --parents \{\} $OUTPUT_DIR \;

ORIGIN=$(pwd)
cd $BUILD_DIR

echo "Creating release file: $PACKAGE_FILE"
zip -rq $PACKAGE_FILE $PACKAGE_FULL_NAME

cd $ORIGIN
mkdir dist/

cp $BUILD_DIR/$PACKAGE_FILE dist

echo "$PACKAGE_FILE ready at dist/$PACKAGE_FILE"
