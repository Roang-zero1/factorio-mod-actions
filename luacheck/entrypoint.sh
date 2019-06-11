#!/bin/sh

curl https://raw.githubusercontent.com/Nexela/Factorio-luacheckrc/0.17/.luacheckrc -o .luacheckrc
luacheck .

