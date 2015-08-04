//
//  CloudWord.h
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

@import UIKit;
/**
 A cloud word, consisting of text, and word weight
 
 It includes layout information, such as pointSize, and geometry
 */
@interface CloudWord : NSObject
/**
 Returns the word that the cloud will display
 */
@property (nonatomic, copy) NSString *wordText;
/**
 Returns an index for the color of this word
 */
@property (nonatomic, assign) NSUInteger wordColor;
/**
 Returns the unweighted number of occurrences of this word in the source
 */
@property (nonatomic, strong) NSNumber *wordCount;
/**
 Returns the word's size, in points.  Based on the normalized word count of all the
 cloud words
 
 @note The cloud model has no details about the font that the view will use
 */
@property (nonatomic, assign) CGFloat pointSize;
/**
 Returns the word's preferred location in the cloud, centered on the word
 */
@property (nonatomic, assign) CGPoint boundsCenter;
/**
 Returns the oriented word's dimensions
 
 @note A horizontal word would generally be wider than it is tall.  A vertical word
 would generally be taller than it is wide
 */
@property (nonatomic, assign) CGSize boundsSize;
/**
 Returns the computed area of the bounds size

 @note The cloud will sort and layout its words by descending area
 */
@property (nonatomic, strong, readonly) NSNumber *boundsArea;
/**
 Returns the oriented word's computed frame, based on its boundsCenter and boundsSize
 */
@property (nonatomic, assign, readonly) CGRect frame;
/**
 Returns a Boolean value indicating whether the word orientation is vertical
 */
@property (nonatomic, assign, getter=isWordOrientationVertical) BOOL wordOrientationVertical;
/**
 Initializes a newly allocated CloudWord object
 
 @param aWord The word that the cloud will display
 
 @param wordCount The unweighted number of occurrences of this word in the source
 
 @return An initialized CloudWord object
 */
- (instancetype)initWithWord:(NSString *)aWord wordCount:(NSNumber *)wordCount NS_DESIGNATED_INITIALIZER;
- (instancetype)init;
/**
 Assign an indexed color to the word

 @param scale The scale of the word in relation to the most frequent word

 @note Sets self.wordColor
 */
- (void)determineColorForScale:(CGFloat)scale;
/**
 Assign a random word orientation to the word

 @param containerSize The size of the container that the word will be oriented in

 @param scale The scale factor associated with the device's screen

 @param fontName The name of the font that the word will use

 @note Sets self.wordOrientationVertical and self.boundsSize
 */
- (void)determineRandomWordOrientationInContainerWithSize:(CGSize)containerSize scale:(CGFloat)scale fontName:(NSString *)fontName;
/**
 Assign an integral random center point to the word

 @param containerSize The size of the container that the word will be positioned in

 @param scale The scale factor associated with the device's screen

 @note Sets self.boundsCenter
 */
- (void)determineRandomWordPlacementInContainerWithSize:(CGSize)containerSize scale:(CGFloat)scale;
/**
 Assign a new integral center point to the word
 
 @param center The center point to be offset
 
 @param xOffset The x offset to apply to the given center
 
 @param yOffset The y offset to apply to the given center
 
 @param scale The scale factor associated with the device's screen

 @note Sets self.boundsCenter
 */
- (void)determineNewWordPlacementFromSavedCenter:(CGPoint)center xOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset scale:(CGFloat)scale;
/**
 Returns a padded frame to provide whitespace between words, or between a word and the container edge

 @return The padded frame adjusted for leading/trailing space
 */
- (CGRect)paddedFrame;

@end
