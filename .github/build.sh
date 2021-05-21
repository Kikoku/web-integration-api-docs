#!/bin/sh

## Build external document first
echo "Building the external document"
cd /usr/src/app/source 
mv index.html.external.md index.html.md
bundle exec middleman build --clean

## Getting back to home folder 
## To move the generated files 
## To the external doc build folder
cd $GITHUB_WORKSPACE
mv /usr/src/app/build $EXTERNAL_DOC_BUILD

## Build internal document next
echo "Building the internal document"
cd /usr/src/app/source 
mv index.html.internal.md index.html.md
bundle exec middleman build --clean

## Getting back to home folder 
## To move the generated files 
## To the internal doc build folder
cd $GITHUB_WORKSPACE
mv /usr/src/app/build $INTERNAL_DOC_BUILD

## Zipping the build to tag them as released in github
echo "Zipping the generated docs"
zip -r $ZIP_DOC_BUILD $EXTERNAL_DOC_BUILD $INTERNAL_DOC_BUILD
