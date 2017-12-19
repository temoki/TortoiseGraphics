#!/bin/sh

# Directories
SELF_DIR=$(cd $(dirname $0);pwd)

# Make book with template
BOOK_DIR=$SELF_DIR/TortoisePlayground.playgroundbook
if [ -e $BOOK_DIR ]; then
  rm -rf $BOOK_DIR
fi
mkdir $BOOK_DIR
cp -rf $SELF_DIR/template/* $BOOK_DIR

# Copy sources
echo "Copy sources..."
FROM_SOURCES_DIR=Tortoise.playground/Sources
TO_SOURCES_DIR=$BOOK_DIR/Contents/Sources
if [ ! -e $TO_SOURCES_DIR ]; then
  rm -f $TO_SOURCES_DIR/*
  mkdir $TO_SOURCES_DIR
fi
cp $FROM_SOURCES_DIR/* $TO_SOURCES_DIR

# Copy Contents.swift
echo "[Page1] Copy Contents.swift"
cp -f $SELF_DIR/Tortoise.playground/Pages/Page1.xcplaygroundpage/Contents.swift $BOOK_DIR/Contents/Chapters/Main.playgroundchapter/Pages/Page1.playgroundpage
echo "[Page2] Copy Contents.swift"
cp -f $SELF_DIR/Tortoise.playground/Pages/Page2.xcplaygroundpage/Contents.swift $BOOK_DIR/Contents/Chapters/Main.playgroundchapter/Pages/Page2.playgroundpage

echo "Done."
