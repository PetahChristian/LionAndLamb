//
//  UIColor+CloudSettings.h
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

typedef NS_ENUM(NSInteger, LALSettingsColor) {
    LALSettingsColorBlueGreen,
    LALSettingsColorMagentaBlue,
    LALSettingsColorMustardRed,
    LALSettingsColorGreenBlue,
    LALSettingsColorCoralReef,
    LALSettingsColorSpicyOlive,
    LALSettingsColorMaroonGrey,
    LALSettingsColorBlack,
    LALSettingsColorWhite,
};

@interface UIColor (CloudSettings)
/**
 Returns the count of color choices available to the user
 
 @return The total number of possible color choices
 */
+ (NSInteger)lal_numberOfPreferredColors;
/**
 Returns an array of colors associated with the preferred color choice
 
 @param preferredColor An enum representing the user's preferred color preference
 
 @return An array of colors associated with the specified preferredColor enum
 */
+ (NSArray *)lal_colorsForPreferredColor:(LALSettingsColor)preferredColor;
/**
 Returns the background color associated with the preferred color choice

 @param preferredColor An enum representing the user's preferred color preference

 @return A background color associated with the specified preferredColor enum
 */
+ (UIColor *)lal_backgroundColorForPreferredColor:(LALSettingsColor)preferredColor;
/**
 Returns the sample attributed text with the preferred color choice

 @param preferredColor An enum representing the user's preferred color preference

 @return A sample attributed string with the specified preferredColor
 */
+ (NSAttributedString *)lal_attributedTextWithPreferredColor:(LALSettingsColor)preferredColor contentSizeDelta:(CGFloat)contentSizeDelta;

@end
