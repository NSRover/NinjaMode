# !/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# echo $DIR/../../

# xcode-select --switch /Applications/Xcode.app/Contents/Developer
# xcodebuild -target "NinjaMode" -configuration "Debug" CONFIGURATION_BUILD_DIR='TestBuild'
# sleep 10;
open $DIR/../../TestBuild/NinjaMode.app/
