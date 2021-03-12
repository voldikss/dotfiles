#! /usr/bin/env bash

version=$(json version < package.json)
name=$(json name < package.json)
echo "$name/$version"
git commit -a -m "v$version"
git tag -a "$version" -m "v$version"
npm publish
git push --tags
git push
