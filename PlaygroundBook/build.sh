#!/bin/sh

# Directories
SELF_DIR=$(cd $(dirname $0);pwd)
PARENT_DIR=$(cd $(dirname $0);cd ..;pwd)

# Make book with template
BOOK_DIR=$SELF_DIR/TortoisePlayground.playgroundbook
if [ -e $BOOK_DIR ]; then
  rm -rf $BOOK_DIR
fi
mkdir $BOOK_DIR
cp -rf $SELF_DIR/template/* $BOOK_DIR

# Copy sources
echo "Copy sources..."
FROM_SOURCES_DIR=$PARENT_DIR/Sources
TO_SOURCES_DIR=$BOOK_DIR/Contents/Sources
if [ ! -e $TO_SOURCES_DIR ]; then
  rm -f $TO_SOURCES_DIR/*
  mkdir $TO_SOURCES_DIR
fi
cp $FROM_SOURCES_DIR/* $TO_SOURCES_DIR

# Copy Contents.swift
echo "Copy Contents.swift" 
CONTENTS_SWIFT=$SELF_DIR/Tortoise.playground/Pages/TortoisePlayground.xcplaygroundpage/Contents.swift
cp -f $CONTENTS_SWIFT $BOOK_DIR/Contents/Chapters/Main.playgroundchapter/Pages/TortoisePlayground.playgroundpage

echo "Done."