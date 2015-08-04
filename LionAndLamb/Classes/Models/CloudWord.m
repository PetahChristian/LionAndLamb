//
//  CloudWord.m
//  LionAndLamb
//
//  Created by Peter Jensen on 4/28/15.
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

#import "CloudWord.h"

@import CoreText;

@implementation CloudWord

@synthesize wordText = _wordText;
@synthesize wordColor = _wordColor;
@synthesize wordCount = _wordCount;
@synthesize pointSize = _pointSize;
@synthesize boundsCenter = _boundsCenter;
@synthesize boundsSize = _boundsSize;
@synthesize wordOrientationVertical = _wordOrientationVertical;

#pragma mark - Initialization

- (instancetype)initWithWord:(NSString *)aWord wordCount:(NSNumber *)wordCount
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        _wordText = aWord.length ? aWord : @"???";
        _wordCount = wordCount.integerValue > 0 ? wordCount : @1;

        // Cloud layout will assign point size based on normalized word counts
        // Once the point size is known, cloud layout will determine the word's orientation and geometry
    }
    return self;
}

- (instancetype)init
{
    return [self initWithWord:@"God" wordCount:@7];
}

#pragma mark - Getters and setters

- (NSNumber *)boundsArea
{
    return [NSNumber numberWithFloat:(self.boundsSize.width * self.boundsSize.height)];
}

- (CGRect)frame
{
    return CGRectMake(self.boundsCenter.x - self.boundsSize.width / 2.0,
                      self.boundsCenter.y - self.boundsSize.height / 2.0,
                      self.boundsSize.width,
                      self.boundsSize.height);
}

#pragma mark - Public methods

#ifdef DEBUG
- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p> word = %@; wordCount = %@; pointSize = %.0f; center = (%.0f %.0f); vertical = %@; size = (%.0f %.0f); area = %@",
            self.class,
            self,
            self.wordText,
            self.wordCount,
            self.pointSize,
            self.boundsCenter.x, self.boundsCenter.y,
            self.isWordOrientationVertical ? @"YES" : @"NO",
            self.boundsSize.width, self.boundsSize.height,
            self.boundsArea];
}
#endif

- (void)determineColorForScale:(CGFloat)scale
{
    if (scale >= 0.95) // 5%
    {
        self.wordColor = 0;
    }
    else if (scale >= 0.8) // 15%
    {
        self.wordColor = 1;
    }
    else if (scale >= 0.55) // 25%
    {
        self.wordColor = 2;
    }
    else if (scale >= 0.30) // 25%
    {
        self.wordColor = 3;
    }
    else // 30%
    {
        self.wordColor = 4;
    }
}

static CGFloat containerMargin = 16.0;

- (void)determineRandomWordOrientationInContainerWithSize:(CGSize)containerSize scale:(CGFloat)scale fontName:(NSString *)fontName
{
    // Assign random word orientation (10% chance for vertical)

    [self sizeWordVertical:(arc4random_uniform(10) == 0) scale:scale fontName:fontName];

    // Check word size against container smallest dimension

    BOOL isPortrait = containerSize.height > containerSize.width;

    if (isPortrait && !self.isWordOrientationVertical && self.boundsSize.width >= containerSize.width - containerMargin)
    {
        // Force vertical orientation for horizontal word that's too wide
        [self sizeWordVertical:YES scale:scale fontName:fontName];
    }
    else if (!isPortrait && self.isWordOrientationVertical && self.boundsSize.height >= containerSize.height - containerMargin)
    {
        // Force horizontal orientation for vertical word that's too tall
        [self sizeWordVertical:NO scale:scale fontName:fontName];
    }
}

- (void)determineRandomWordPlacementInContainerWithSize:(CGSize)containerSize scale:(CGFloat)scale
{
    CGPoint randomGaussianPoint = [self randomGaussian];

    // Place bounds upon standard normal distribution to ensure word is placed within the container

    while (fabs(randomGaussianPoint.x) > 5.0 || fabs(randomGaussianPoint.y) > 5.0)
    {
        randomGaussianPoint = [self randomGaussian];
    }

    // Midpoint +/- 50%
    CGFloat xOffset = (containerSize.width / 2.0) + (randomGaussianPoint.x * ((containerSize.width - self.boundsSize.width) * 0.1));
    CGFloat yOffset = (containerSize.height / 2.0) + (randomGaussianPoint.y * ((containerSize.height - self.boundsSize.height) * 0.1));

    // Return an integral point

    self.boundsCenter = CGPointMake([self round:xOffset scale:scale], [self round:yOffset scale:scale]);
}

- (void)determineNewWordPlacementFromSavedCenter:(CGPoint)center xOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset scale:(CGFloat)scale
{
    xOffset += center.x;
    yOffset += center.y;

    // Assign an integral point

    self.boundsCenter = CGPointMake([self round:xOffset scale:scale], [self round:yOffset scale:scale]);
}

- (CGRect)paddedFrame
{
    return CGRectInset(self.frame, self.wordOrientationVertical ? -2.0 : -5.0, self.wordOrientationVertical ? -5.0 : -2.0);
}

#pragma mark - Private methods

/**
 Sizes the word for a given orientation
 
 @param isVertical Whether the word orientation is vertical

 @param scale The scale factor associated with the device's screen

 @param fontName The name of the font that the word will use

 @note Sets self.wordOrientationVertical and self.boundsSize
 */
- (void)sizeWordVertical:(BOOL)isVertical scale:(CGFloat)scale fontName:(NSString *)fontName
{
    self.wordOrientationVertical = isVertical;

    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont fontWithName:fontName size:self.pointSize] };
    NSAttributedString *attributedWord = [[NSAttributedString alloc] initWithString:self.wordText attributes:attributes];
    CGSize attributedWordSize = [attributedWord size];

    // Round up fractional values to integral points

    if (self.isWordOrientationVertical)
    {
        // Vertical orientation.  Width <- sized height.  Height <- sized width
        self.boundsSize = CGSizeMake([self ceil:attributedWordSize.height scale:scale], [self ceil:attributedWordSize.width scale:scale]);
    }
    else
    {
        self.boundsSize = CGSizeMake([self ceil:attributedWordSize.width scale:scale], [self ceil:attributedWordSize.height scale:scale]);
    }
}

/**
 Returns two (pseudo-)random gaussian numbers
 
 @return A random gaussian CGPoint, distributed around { 0, 0 }
 */
- (CGPoint)randomGaussian
{
    CGFloat x1, x2, w;

    do
    {
        // drand48() less random but faster than ((float)arc4random() / UINT_MAX)
        x1 = 2.0 * drand48() - 1.0;
        x2 = 2.0 * drand48() - 1.0;
        w = x1 * x1 + x2 * x2;
    } while (w >= 1.0);

    w = sqrt((-2.0 * log(w)) / w);
    return CGPointMake(x1 * w, x2 * w);
}

/**
 Returns a CGFloat rounded to the nearest integral pixel
 
 @param value A (fractional) coordinate
 
 @return A device-independent coordinate, rounded to the nearest device-dependent pixel
 
 @note Integral coordinates are not necessarily integer coordinates on a retina device
 */
- (CGFloat)round:(CGFloat)value scale:(CGFloat)scale
{
    return round(value * scale) / scale;
}

/**
 Returns a CGFloat rounded up to the next integral pixel

 @param value A (fractional) coordinate

 @return A device-independent coordinate, rounded up to the next device-dependent pixel

 @note Integral coordinates are not necessarily integer coordinates on a retina device
 */
- (CGFloat)ceil:(CGFloat)value scale:(CGFloat)scale
{
    return ceil(value * scale) / scale;
}

@end
