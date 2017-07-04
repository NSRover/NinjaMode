NinjaMode
=========

OS X Yosemite gave us the awesome Dark Mode feature, but it is still a pain to switch between the modes.

This little menubar utility give a quick way to toggle between the modes.

(To quit the app, you need to control-click the icon)

## Installation:
ensure that you have xcode command line tools installed.
```
git clone https://github.com/NSRover/NinjaMode.git
cd NinjaMode

sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
xcodebuild -target "NinjaMode.xcodeproj" -scheme "NinjaMode" -configuration "Debug" CONFIGURATION_BUILD_DIR='TestBuild'
open TestBuild/NinjaMode.app/

```
