//
//  CloudLayoutOperation.h
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

@protocol CloudLayoutOperationDelegate <NSObject>
/**
 Insert a title into the delegate's cloud view

 @param cloudTitle The descriptive title (source) to be displayed in the cloud
 */
- (void)insertTitle:(NSString *)cloudTitle;
/**
 Insert a word into the delegate's cloud view

 @param word The word to be displayed in the cloud

 @param pointSize The word's font pointsize

 @param color The word's color index

 @param center The word's center point

 @param isVertical Whether the word orientation is vertical
 */
- (void)insertWord:(NSString *)word pointSize:(CGFloat)pointSize color:(NSUInteger)color center:(CGPoint)center vertical:(BOOL)isVertical;

#ifdef DEBUG
@optional
/**
 Insert a bounding rect into the delegate's cloud view

 @param boundingRect The bounding rect to be displayed in the cloud
 */
- (void)insertBoundingRect:(CGRect)boundingRect;
#endif

@end

@interface CloudLayoutOperation : NSOperation
/**
 Initialize a cloud layout operation
 
 @param cloudWords A dictionary of words and their word counts
 
 @param title The descriptive title (source) for the words
 
 @param fontName The name of the font that the words will use
 
 @param containerSize The size of the delegate's container (view) that the words must fit in
 
 @param containerScale The scale factor associated with the device's screen

 @param delegate The delegate which will receive word layout and progress updates
 */
- (instancetype)initWithCloudWords:(NSArray *)cloudWords title:(NSString *)title fontName:(NSString *)fontName forContainerWithSize:(CGSize)containerSize scale:(CGFloat)containerScale delegate:(id<CloudLayoutOperationDelegate>)delegate;

@end
