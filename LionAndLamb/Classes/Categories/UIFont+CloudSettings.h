//
//  UIFont+CloudSettings.h
//  LionAndLamb
//
//  Created by Peter Jensen on 5/19/15.
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

typedef NS_ENUM(NSInteger, LALSettingsFont) {
    LALSettingsFontAvenir,
    LALSettingsFontOptima,
    LALSettingsFontNoteworthy,
    LALSettingsFontIowan,
    LALSettingsFontGeorgia,
    LALSettingsFontMarion,
    LALSettingsFontBaskerville,
    LALSettingsFontTypewriter,
};

extern const CGFloat kLALsystemPointSize;

@interface UIFont (CloudSettings)
/**
 Returns the count of font choices available to the user

 @return The total number of possible font choices
 */
+ (NSInteger)lal_numberOfPreferredFonts;
/**
 Returns the font name associated with the preferred font choice

 @param preferredFont An enum representing the user's preferred font preference

 @return A font name associated with the specified preferredFont enum
 */
+ (NSString *)lal_fontNameForPreferredFont:(LALSettingsFont)preferredFont;
/**
 Returns a content (point) size delta based on the user's preferred content size
 
 This is used to adjust the font pointSize for fonts which aren't the system font

 @return A delta point size
 */
+ (CGFloat)lal_preferredContentSizeDelta;

@end
