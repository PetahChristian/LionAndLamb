//
//  AppDelegate.m
//  LionAndLamb
//
//  Created by Peter Jensen on 4/24/15.
//  Copyright (c) 2015 Peter Christian Jensen.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "AppDelegate.h"

#import "CloudViewController.h"

#import "UIFont+CloudSettings.h" // For LALSettingsFont enum
#import "UIColor+CloudSettings.h" // For LALSettingsColor enum

@implementation AppDelegate

@synthesize window = _window;

//@synthesize initialViewControllers = _initialViewControllers;

#pragma mark - Getters and setters

#pragma mark - <UIApplicationDelegate>

- (BOOL)               application:(UIApplication *)__unused application
    willFinishLaunchingWithOptions:(NSDictionary *)__unused launchOptions
{
    srand48(time(0));

    // Must set window restorationIdentifier to restore size classes to match saved
    // state

    self.window.restorationIdentifier = @"WindowID";

    [[NSUserDefaults standardUserDefaults] registerDefaults:@{kLALuserSettingsSourceKey : @0, // The Bible
                                                              kLALuserSettingsVersionKey : @1, // KJV
                                                              kLALuserSettingsFontKey : @(LALSettingsFontNoteworthy),
                                                              kLALuserSettingsColorKey : @(LALSettingsColorWhite),
                                                              kLALuserSettingsStopwordsKey : @NO,
                                                              kLALshowHintCloudTapKey : @YES,
                                                              kLALshowHintCloudSwipeKey : @YES,
                                                              kLALshowAnimationCloudTitleKey : @YES,
                                                              }];

//#ifdef DEBUG
//    // Pinch gesture to force exit, for testing state restoration
//    UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc]
//                                            initWithTarget:self action:@selector(_exit)];
//    [self.window addGestureRecognizer:recognizer];
//#endif

    // Ensure interface is loaded before state restoration begins
    [self.window makeKeyAndVisible];
    
    return YES;
}

//#ifdef DEBUG
//- (void) _exit __attribute__ ((noreturn))
//{
//    NSLog(@"Exiting due to debugging gesture to force exit.");
//    exit(0);
//}
//#endif

- (BOOL)application:(UIApplication *)__unused application didFinishLaunchingWithOptions:(NSDictionary *)__unused launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)__unused application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)__unused application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    // Save any modified user defaults to disk

    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)__unused application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)__unused application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)__unused application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)__unused application shouldSaveApplicationState:(NSCoder *)__unused coder
{
    return YES;
}

- (BOOL)application:(UIApplication *)__unused application shouldRestoreApplicationState:(NSCoder *)coder
{
    BOOL restore = YES;

    // Compare the app's version number to the stored version number, to avoid
    // attempting to restore an older version's saved state.

    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    NSString *storedVersion = [coder decodeObjectForKey:UIApplicationStateRestorationBundleVersionKey];
    restore = [version isEqualToString:storedVersion];

    return restore;
}

#pragma mark - Private methods

@end
