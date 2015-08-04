//
//  UIColor+CloudSettings.m
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

#import "UIColor+CloudSettings.h"

@implementation UIColor (CloudSettings)

+ (NSInteger)lal_numberOfPreferredColors
{
    return 9;
}

+ (NSArray *)lal_colorsForPreferredColor:(LALSettingsColor)preferredColor
{
    switch (preferredColor) {
        case LALSettingsColorBlueGreen:
            return @[
                     [UIColor colorWithHue:216.0/360.0 saturation:1.0 brightness:0.3 alpha:1.0],
                     [UIColor colorWithHue:216.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue:216.0/360.0 saturation:0.8 brightness:1.0 alpha:1.0],
                     [UIColor colorWithHue:184.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue:152.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     ];
        case LALSettingsColorMagentaBlue:
            return @[
                     [UIColor colorWithHue:306.0/360.0 saturation:1.0 brightness:0.3 alpha:1.0],
                     [UIColor colorWithHue:306.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue:306.0/360.0 saturation:0.8 brightness:0.6 alpha:1.0],
                     [UIColor colorWithHue:274.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue:242.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     ];
        case LALSettingsColorMustardRed:
            return @[
                     [UIColor colorWithHue: 36.0/360.0 saturation:1.0 brightness:0.3 alpha:1.0],
                     [UIColor colorWithHue: 36.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue: 36.0/360.0 saturation:0.8 brightness:1.0 alpha:1.0],
                     [UIColor colorWithHue:  4.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue:332.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     ];
        case LALSettingsColorGreenBlue:
            return @[
                     [UIColor colorWithHue:126.0/360.0 saturation:1.0 brightness:0.3 alpha:1.0],
                     [UIColor colorWithHue:126.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0],
                     [UIColor colorWithHue:126.0/360.0 saturation:0.8 brightness:0.6 alpha:1.0], // Brightness 0.6 instead of 1.0
                     [UIColor colorWithHue:190.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0], // Hue + 64 instead of - 32
                     [UIColor colorWithHue:222.0/360.0 saturation:0.9 brightness:0.8 alpha:1.0], // Hue + 96 instead of - 64
                     ];
        case LALSettingsColorCoralReef:
            return @[
                     [UIColor colorWithRed: 51.0/255.0 green: 77.0/255.0 blue: 92.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:226.0/255.0 green:122.0/255.0 blue: 63.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:239.0/255.0 green:201.0/255.0 blue: 76.0/255.0 alpha:1.0],
                     [UIColor colorWithRed: 69.0/255.0 green:178.0/255.0 blue:157.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:223.0/255.0 green: 90.0/255.0 blue: 73.0/255.0 alpha:1.0],
                     ];
        case LALSettingsColorSpicyOlive:
            return @[
                     [UIColor colorWithRed:242.0/255.0 green: 92.0/255.0 blue:  5.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:136.0/255.0 green:166.0/255.0 blue: 27.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:242.0/255.0 green:159.0/255.0 blue:  5.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:217.0/255.0 green: 37.0/255.0 blue: 37.0/255.0 alpha:1.0],
                     [UIColor colorWithRed: 47.0/255.0 green:102.0/255.0 blue:179.0/255.0 alpha:1.0],
                     ];
        case LALSettingsColorMaroonGrey:
            return @[
                     [UIColor colorWithHue:17.0/360.0 saturation:1.0 brightness:0.4 alpha:1.0],
                     [UIColor colorWithHue:17.0/360.0 saturation:0.0 brightness:0.0 alpha:1.0],
                     [UIColor colorWithHue:17.0/360.0 saturation:0.0 brightness:0.3 alpha:1.0],
                     [UIColor colorWithHue:17.0/360.0 saturation:0.3 brightness:0.6 alpha:1.0],
                     [UIColor colorWithHue:17.0/360.0 saturation:1.0 brightness:0.6 alpha:1.0],
                     ];
        case LALSettingsColorBlack:
            return @[[UIColor blackColor]];
        case LALSettingsColorWhite:
            return @[[UIColor whiteColor]];
    }

    return @[[UIColor blackColor]];
}

+ (UIColor *)lal_backgroundColorForPreferredColor:(LALSettingsColor)preferredColor
{
    return preferredColor == LALSettingsColorWhite ? [UIColor blackColor] : [UIColor whiteColor];
}

+ (NSAttributedString *)lal_attributedTextWithPreferredColor:(LALSettingsColor)preferredColor contentSizeDelta:(CGFloat)contentSizeDelta
{
    NSArray *colors = [UIColor lal_colorsForPreferredColor:preferredColor];
    BOOL isMonochrome = colors.count == 1;

    NSString *fontName = [[UIFont systemFontOfSize:16.0] fontName];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont fontWithName:fontName size:20.0 + contentSizeDelta],
                                  NSForegroundColorAttributeName : colors[0]};
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Jesus" attributes:attributes];
    attributes = @{ NSFontAttributeName : [UIFont fontWithName:fontName size:18.0 + contentSizeDelta],
                    NSForegroundColorAttributeName : isMonochrome ? colors[0] : colors[1]};
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" Christ," attributes:attributes]];
    attributes = @{ NSFontAttributeName : [UIFont fontWithName:fontName size:16.0 + contentSizeDelta],
                    NSForegroundColorAttributeName : isMonochrome ? colors[0] : colors[2]};
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" King" attributes:attributes]];
    attributes = @{ NSFontAttributeName : [UIFont fontWithName:fontName size:14.0 + contentSizeDelta],
                    NSForegroundColorAttributeName : isMonochrome ? colors[0] : colors[3]};
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" of" attributes:attributes]];
    attributes = @{ NSFontAttributeName : [UIFont fontWithName:fontName size:12.0 + contentSizeDelta],
                    NSForegroundColorAttributeName : isMonochrome ? colors[0] : colors[4]};
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" kings" attributes:attributes]];

    return attributedText;
}

@end
