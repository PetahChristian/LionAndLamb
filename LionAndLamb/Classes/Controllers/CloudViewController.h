//
//  CloudViewController.h
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

@import UIKit;

/**
 A key to the user's preferred (cloud) source
 
 @note This is the bible, the old or new testament, or a specific bible book
 */
extern NSString * const kLALuserSettingsSourceKey;
/**
 A key to the user's preferred (bible) version
 */
extern NSString * const kLALuserSettingsVersionKey;
/**
 A key to an LALSettingsFont enum of the user's preferred (cloud) font
 */
extern NSString * const kLALuserSettingsFontKey;
/**
 A key to an LALSettingsColor enum of the user's preferred (cloud) color
 */
extern NSString * const kLALuserSettingsColorKey;
/**
 A key to the user's preferred stopwords setting
 
 @note Stopwords never appear in the cloud, but can be toggled for the statistics
 */
extern NSString * const kLALuserSettingsStopwordsKey;
/**
 A key to a BOOL indicating whether the tap gesture hint should be shown
 */
extern NSString * const kLALshowHintCloudTapKey;
/**
 A key to a BOOL indicating whether the swipe gesture hint should be shown
 */
extern NSString * const kLALshowHintCloudSwipeKey;
/**
 A key to a BOOL indicating whether the cloud title animation should be shown
 */
extern NSString * const kLALshowAnimationCloudTitleKey;

@interface CloudViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)layoutCloudWordsAgain:(UITapGestureRecognizer *)sender;
- (IBAction)previousSource:(UISwipeGestureRecognizer *)sender;
- (IBAction)nextSource:(UISwipeGestureRecognizer *)sender;
- (IBAction)showActionSheet:(UIButton *)sender;

@end

