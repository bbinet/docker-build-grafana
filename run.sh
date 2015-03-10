#!/bin/bash

go run build.go setup
godep restore
go run build.go build
npm install
npm install -g grunt-cli
go run build.go package
