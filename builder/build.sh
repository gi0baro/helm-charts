#!/usr/bin/env bash

noir -c build.yaml buildgen.sh > _build.sh
bash _build.sh
rm _build.sh
