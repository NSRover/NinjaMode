//
//  AppDelegate.m
//  NinjaMode
//
//  Created by Nirbhay Agarwal on 08/10/14.
//  Copyright (c) 2014 NSRover. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (assign, nonatomic) BOOL darkModeOn;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _statusItem.image = [NSImage imageNamed:@"switchIcon.png"];
    [_statusItem.image setTemplate:YES];

    _statusItem.highlightMode = NO;
    _statusItem.toolTip = @"control-click to quit";
    
    [_statusItem setAction:@selector(itemClicked:)];
    [self refreshDarkMode];
}

- (void)refreshDarkMode {
    NSString * value = (__bridge NSString *)(CFPreferencesCopyValue((CFStringRef)@"AppleInterfaceStyle", kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost));
    if ([value isEqualToString:@"Dark"]) {
        self.darkModeOn = YES;
    }
    else {
        self.darkModeOn = NO;
    }
}

- (void)itemClicked:(id)sender {

    NSEvent *event = [NSApp currentEvent];
    if([event modifierFlags] & NSControlKeyMask) {
        [[NSApplication sharedApplication] terminate:self];
        return;
    }
    
    _darkModeOn = !_darkModeOn;
    
    //Change pref
    if (_darkModeOn) {
        [self makeItDark];
    }
    else {
        [self makeItBright];
    }
}

- (void)makeItDark {
    //Set theme and update listeners
    CFPreferencesSetValue((CFStringRef)@"AppleInterfaceStyle", @"Dark", kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    dispatch_async(dispatch_get_main_queue(), ^{
        CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), (CFStringRef)@"AppleInterfaceThemeChangedNotification", NULL, NULL, YES);
    });
    
    //set wallpaper
    [self changeWallpaperWithImagePath:[@"~/Documents/NinjaModes/dark.png" stringByExpandingTildeInPath]];
}

- (void)makeItBright {
    //Set theme and update listeners
    CFPreferencesSetValue((CFStringRef)@"AppleInterfaceStyle", NULL, kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    dispatch_async(dispatch_get_main_queue(), ^{
        CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), (CFStringRef)@"AppleInterfaceThemeChangedNotification", NULL, NULL, YES);
    });
    
    //set wallpaper
    [self changeWallpaperWithImagePath:[@"~/Documents/NinjaModes/bright.png" stringByExpandingTildeInPath]];
}

- (void)changeWallpaperWithImagePath:(NSString *)path {
    
    //If NinjaModes directory does not exist, assume not interested.
    if (![[NSFileManager defaultManager] fileExistsAtPath:[@"~/Documents/NinjaModes" stringByExpandingTildeInPath]]) {
        return;
    }
    
    NSError *error;
    [[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:path]
                                            forScreen:[NSScreen mainScreen]
                                              options:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       nil, NSWorkspaceDesktopImageFillColorKey,
                                                       [NSNumber numberWithBool:NO], NSWorkspaceDesktopImageAllowClippingKey,
                                                       [NSNumber numberWithInteger:NSImageScaleProportionallyUpOrDown], NSWorkspaceDesktopImageScalingKey, nil]
                                                error:&error];
    if (error) {
        [[NSApplication sharedApplication] presentError: error
                                         modalForWindow: self.window
                                               delegate: nil
                                     didPresentSelector: nil
                                            contextInfo: NULL];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    //Attempt to restore things back the way we found them
    [self makeItBright];
}

@end
