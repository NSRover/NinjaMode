#!/bin/bash

 launchctl unload ~/Library/LaunchAgents/com.example.hello.plist;
 rm ~/Library/LaunchAgents/com.example.hello.plist
 # mv ~/Library/LaunchAgents/com.example.hello.plist com.example.hello.plist;
 echo Uninstalled, If the program is still running delete the process or restart/sleep computer.
 osascript -e 'display notification "If running delete process or restart/sleep computer." with title "Launch Agent Successfuly Removed and Stopped"'
