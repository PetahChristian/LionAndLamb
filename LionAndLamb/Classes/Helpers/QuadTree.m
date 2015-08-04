//
//  QuadTree.m
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
#import "QuadTree.h"

static const NSUInteger kLALBoundingRectThreshold = 8;

@interface QuadTree ()
/**
 The frame (region) corresponding to this node
 */
@property (nonatomic, assign) CGRect frame;
/**
 A strong reference to the bounding rects that fit within this node's frame
 
 @note These are rects that don't fit completely within a sub quad
 
 @note Will be nil if this node is empty, or if all its rects fit within sub quads
 */
@property (nonatomic, strong) NSMutableArray *boundingRects;
/**
 A strong reference to the top left quadrant of this node
 
 @note Will be nil if this node has no sub quads
 */
@property (nonatomic, strong) QuadTree *topLeftQuad;
/**
 A strong reference to the top right quadrant of this node

 @note Will be nil if this node has no sub quads
 */
@property (nonatomic, strong) QuadTree *topRightQuad;
/**
 A strong reference to the bottom left quadrant of this node

 @note Will be nil if this node has no sub quads
 */
@property (nonatomic, strong) QuadTree *bottomLeftQuad;
/**
 A strong reference to the bottom right quadrant of this node

 @note Will be nil if this node has no sub quads
 */
@property (nonatomic, strong) QuadTree *bottomRightQuad;

@end

@implementation QuadTree

@synthesize frame = _frame;
@synthesize boundingRects = _boundingRects;
@synthesize topLeftQuad = _topLeftQuad;
@synthesize topRightQuad = _topRightQuad;
@synthesize bottomLeftQuad = _bottomLeftQuad;
@synthesize bottomRightQuad = _bottomRightQuad;

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        _frame = frame;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

#pragma mark - Public methods

#ifdef DEBUG
- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p> frame = (%.0f %.0f; %.0f %.0f); boundingRects = %@; topLeftQuad = %@; topRightQuad = %@; bottomLeftQuad = %@; bottomRightQuad = %@",
            self.class,
            self,
            CGRectGetMinX(self.frame),
            CGRectGetMinY(self.frame),
            CGRectGetWidth(self.frame),
            CGRectGetHeight(self.frame),
            self.boundingRects,
            [self.topLeftQuad debugDescription],
            [self.topRightQuad debugDescription],
            [self.bottomLeftQuad debugDescription],
            [self.bottomRightQuad debugDescription]];
}
#endif

- (BOOL)insertBoundingRect:(CGRect)boundingRect
{
    if (!CGRectContainsRect(self.frame, boundingRect))
    {
        // The rect doesn't fit in this node.  Give up
        return NO;
    }

    // Pre-insert, check if no sub quads, and rect threshold reached
    if (!self.topLeftQuad && self.boundingRects.count > kLALBoundingRectThreshold)
    {
        [self setupChildQuads];
        [self migrateBoundingRects];
    }

    if (self.topLeftQuad && [self migrateBoundingRect:boundingRect])
    {
        // The bounding rect was inserted into a sub quad
        return YES;
    }

    // The bounding rect did not fit into a sub quad.  Add it to this node's array
    if (!self.boundingRects)
    {
        self.boundingRects = [[NSMutableArray alloc] init];
    }
    [self.boundingRects addObject:[NSValue valueWithCGRect:boundingRect]];
    return YES;
}

- (BOOL)hasGlyphThatIntersectsWithWordRect:(CGRect)wordRect
{
    // First test the node's bounding rects

    for (NSValue *value in self.boundingRects)
    {
        CGRect glyphBoundingRect = [value CGRectValue];
        if (CGRectIntersectsRect(glyphBoundingRect, wordRect))
        {
            return YES;
        }
    }

    // If no sub quads, we're done looking for intersections

    if (!self.topLeftQuad)
    {
        return NO;
    }

    // Check a sub quad if its frame intersects with the word

    if (CGRectIntersectsRect(self.topLeftQuad.frame, wordRect))
    {
        if ([self.topLeftQuad hasGlyphThatIntersectsWithWordRect:wordRect])
        {
            // One of its glyphs intersects with our word
            return YES;
        }
        if (CGRectContainsRect(self.topLeftQuad.frame, wordRect))
        {
            // Our word fits completely within topLeft.  No need to check other sub quads
            return NO;
        }
    }

    if (CGRectIntersectsRect(self.topRightQuad.frame, wordRect))
    {
        if ([self.topRightQuad hasGlyphThatIntersectsWithWordRect:wordRect])
        {
            // One of its glyphs intersects with our word
            return YES;
        }
        if (CGRectContainsRect(self.topRightQuad.frame, wordRect))
        {
            // Our word fits completely within topRight.  No need to check other sub quads
            return NO;
        }
    }

    if (CGRectIntersectsRect(self.bottomLeftQuad.frame, wordRect))
    {
        if ([self.bottomLeftQuad hasGlyphThatIntersectsWithWordRect:wordRect])
        {
            // One of its glyphs intersects with our word
            return YES;
        }
        if (CGRectContainsRect(self.bottomLeftQuad.frame, wordRect))
        {
            // Our word fits completely within bottomLeft.  No need to check other sub quads
            return NO;
        }
    }

    if (CGRectIntersectsRect(self.bottomRightQuad.frame, wordRect))
    {
        if ([self.bottomRightQuad hasGlyphThatIntersectsWithWordRect:wordRect])
        {
            // One of its glyphs intersects with our word
            return YES;
        }
    }

    // No more sub quads to check.  If we've got this far, there are no intersections
    return NO;
}

#pragma mark - Private methods

/**
 Create sub quads, provided that they do not already exist
 */
- (void)setupChildQuads
{
    if (self.topLeftQuad)
    {
        // Sub quads already exist
        return;
    }

    // Create sub quads

    CGFloat currentX = CGRectGetMinX(self.frame);
    CGFloat currentY = CGRectGetMinY(self.frame);
    CGFloat childWidth = CGRectGetWidth(self.frame) / 2.0;
    CGFloat childHeight = CGRectGetWidth(self.frame) / 2.0;

    self.topLeftQuad = [[QuadTree alloc] initWithFrame:CGRectMake(currentX, currentY, childWidth, childHeight)];
    self.topRightQuad = [[QuadTree alloc] initWithFrame:CGRectMake(currentX + childWidth, currentY, childWidth, childHeight)];
    currentY += childHeight;
    self.bottomLeftQuad = [[QuadTree alloc] initWithFrame:CGRectMake(currentX, currentY, childWidth, childHeight)];
    self.bottomRightQuad = [[QuadTree alloc] initWithFrame:CGRectMake(currentX + childWidth, currentY, childWidth, childHeight)];
}

/**
 Migrate any existing bounding rects to any sub quads that can enclose them
*/
- (void)migrateBoundingRects
{
    // Setup an array to hold any migrated rects that will need to be deleted from this node's array of rects
    NSMutableArray *migratedBoundingRects = [[NSMutableArray alloc] init];

    for (NSValue *value in self.boundingRects)
    {
        CGRect boundingRect = value.CGRectValue;

        if ([self migrateBoundingRect:boundingRect])
        {
            // Can't delete during fast enumeration.  Save to be deleted
            [migratedBoundingRects addObject:value];
        }
    }

    if (migratedBoundingRects.count)
    {
        for (NSValue *value in migratedBoundingRects)
        {
            [self.boundingRects removeObject:value];
        }
    }

    if (!self.boundingRects.count)
    {
        // All nodes were moved.  Free up empty array
        self.boundingRects = nil;
    }
}

/**
 Migrate an existing bounding rect to any sub quad that can enclose it
 
 @param boundingRect The bounding rect to insert into a sub quad
 
 @return YES if the bounding rect fit within a sub quad and was migrated, else NO
 */
- (BOOL)migrateBoundingRect:(CGRect)boundingRect
{
    if ([self.topLeftQuad insertBoundingRect:boundingRect] ||
        [self.topRightQuad insertBoundingRect:boundingRect] ||
        [self.bottomLeftQuad insertBoundingRect:boundingRect] ||
        [self.bottomRightQuad insertBoundingRect:boundingRect])
    {
        // Bounding rect migrated to a sub quad
        return YES;
    }

    return NO;
}

@end
