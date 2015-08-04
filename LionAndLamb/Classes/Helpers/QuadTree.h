//
//  QuadTree.h
//  LionAndLamb
//
//  Created by Peter Jensen on 5/8/15.
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

@interface QuadTree : NSObject

/**
 Returns a quadtree object
 
 @param frame The region in the delegate's cloud view that this node covers
 
 @return An initialized quadtree object, or nil if the object could not be created for some reason
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
/**
 @warning Cannot initialize node without a region size (and origin).  Use initWithFrame:
 */
- (instancetype)init __attribute__((unavailable("Must use initWithFrame:")));
/**
 @warning Cannot initialize node without a region size (and origin).  Use initWithFrame:
 */
+ (instancetype)new __attribute__((unavailable("Must use initWithFrame:")));
/**
 Add a bounding rect to this quadtree
 
 @param boundingRect The bounding rect to be inserted into the quadtree
 
 @return YES if the insert succeeds (i.e., the bounding rect fits completely within the node's frame), otherwise NO.
 */
- (BOOL)insertBoundingRect:(CGRect)boundingRect;
/**
 Checks to see if the word's desired location intersects with any glyph's bounding rect

 @param wordRect The location to be compared against the quadtree

 @return YES if a glyph intersects the word's location, otherwise NO
 */
- (BOOL)hasGlyphThatIntersectsWithWordRect:(CGRect)wordRect;

@end
