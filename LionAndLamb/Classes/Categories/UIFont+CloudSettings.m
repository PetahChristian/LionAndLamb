//
//  UIFont+CloudSettings.m
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

#import "UIFont+CloudSettings.h"

const CGFloat kLALsystemPointSize = 16.0;

@implementation UIFont (CloudSettings)

+ (NSInteger)lal_numberOfPreferredFonts
{
    return 8;
}

+ (NSString *)lal_fontNameForPreferredFont:(LALSettingsFont)preferredFont
{
    switch (preferredFont) {
        case LALSettingsFontAvenir:
            return @"AvenirNext-Regular";
        case LALSettingsFontBaskerville:
            return @"Baskerville";
        case LALSettingsFontGeorgia:
            return @"Georgia";
        case LALSettingsFontIowan:
            return @"IowanOldStyle-Roman";
        case LALSettingsFontMarion:
            return @"Marion-Regular";
        case LALSettingsFontNoteworthy:
            return @"Noteworthy-Light";
        case LALSettingsFontOptima:
            return @"Optima";
        case LALSettingsFontTypewriter:
            return @"AmericanTypeWriter-Condensed";
    }

    return @"AvenirNext-Regular";
}

+ (CGFloat)lal_preferredContentSizeDelta
{
    NSDictionary *pointSizeDeltas = @{
                                      UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: @6.0,
                                      UIContentSizeCategoryAccessibilityExtraExtraLarge: @5.0,
                                      UIContentSizeCategoryAccessibilityExtraLarge: @4.0,
                                      UIContentSizeCategoryAccessibilityLarge: @4.0,
                                      UIContentSizeCategoryAccessibilityMedium: @3.0,
                                      UIContentSizeCategoryExtraExtraExtraLarge: @3.0,
                                      UIContentSizeCategoryExtraExtraLarge: @2.0,
                                      UIContentSizeCategoryExtraLarge: @1.0,
                                      UIContentSizeCategoryLarge: @0.0,
                                      UIContentSizeCategoryMedium: @(-1.0),
                                      UIContentSizeCategorySmall: @(-2.0),
                                      UIContentSizeCategoryExtraSmall: @(-3.0),
                                      };

    NSString *contentSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *delta = pointSizeDeltas[contentSize];

    return delta.doubleValue;
}

@end
