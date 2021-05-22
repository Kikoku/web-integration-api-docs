#!/bin/bash

function cleanup {
  echo "Removing the generated index.html.md file"
  rm source/index.html.md
}

trap cleanup EXIT

echo "Deleting old 'build' folder if exists ..."
rm -rf source/build

echo "Generating a index.html.md file for the $1 doc..."
if [ $1 = "external" ]; then 
    cp source/index.html.external.md source/index.html.md
elif [ $1 = "internal" ]; then
    cp source/index.html.internal.md source/index.html.md
else 
	echo "Unknown argument '$1', will do nothing and exit"
	echo "Accepted arguments: external, internal"
fi

echo "Building static html doc to 'build' folder ..."
bundle exec middleman build --clean

echo "Copying result into 'build' folder ..."
cp -r build source/

echo "Serving live doc at http://127.0.0.1:4567 ..."
bundle exec middleman server
