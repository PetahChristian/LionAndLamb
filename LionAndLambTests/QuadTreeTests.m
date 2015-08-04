//
//  QuadTreeTests.m
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
@import XCTest;

#import "QuadTree.h"

@interface QuadTreeTests : XCTestCase

@property (nonatomic, strong) QuadTree *objectUnderTest;

@end

@implementation QuadTreeTests

@synthesize objectUnderTest = _objectUnderTest;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.objectUnderTest = [[QuadTree alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.objectUnderTest = nil;
}

#pragma mark - -initWithFrame: Tests

/**
 @warning This would be an error, as there is no setter to assign a frame after initialization
 */
- (void)testThatInitWithFrameHandlesRectZero
{
    QuadTree *sut = [[QuadTree alloc] initWithFrame:CGRectZero];
    XCTAssertNotNil(sut, @"initWithFrame (zero) failed");
}

#pragma mark - -insertBoundingRect: Tests

- (void)testThatInsertBoundingRectHandlesRectZero
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectZero], @"insertBoundingRect (zero) failed");
}

- (void)testThatInsertBoundingRectHandlesRectFits
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0, 20.0, 20.0)], @"insertBoundingRect failed");
}

- (void)testThatInsertBoundingRectHandlesFiveRectFits
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0,  20.0,  20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(30.0, 30.0,  40.0,  40.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(20.0, 20.0,  60.0,  60.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0,  80.0,  80.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 0.0,  0.0, 100.0, 100.0)], @"insertBoundingRect failed");
}

- (void)testThatInsertBoundingRectHandlesTenRectFits
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0,  20.0,  20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(30.0, 30.0,  40.0,  40.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(20.0, 20.0,  60.0,  60.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0,  80.0,  80.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 0.0,  0.0, 100.0, 100.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0,  20.0,  20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(60.0, 60.0,  20.0,  20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(60.0, 10.0,  20.0,  20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 60.0,  20.0,  20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0,  10.0,  10.0)], @"insertBoundingRect failed");
}

/**
 Skewed to top left quad of top left quad
 */
- (void)testThatInsertBoundingRectHandlesTwentyRectFitsDepthFour
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 0.0,  0.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(20.0, 20.0,  4.0,  4.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 1.0,  1.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(11.0, 11.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(21.0, 21.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 2.0,  2.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(12.0, 12.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(22.0, 22.0,  2.0,  2.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 3.0,  3.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(13.0, 13.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(23.0, 23.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 4.0,  4.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(14.0, 14.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(24.0, 24.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 5.0,  5.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(15.0, 15.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(25.0, 25.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 0.0,  0.0, 25.0, 25.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 0.0,  0.0,  0.0,  0.0)], @"insertBoundingRect failed");
}

/**
 Skewed to top left quad
 */
- (void)testThatInsertBoundingRectHandlesTwentyTwoRectFitsDepthThree
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 0.0,  0.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(20.0, 20.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(30.0, 30.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0, 10.0, 10.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 5.0,  5.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(15.0, 15.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(25.0, 25.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(35.0, 35.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(45.0, 45.0,  5.0,  5.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 1.0,  1.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(11.0, 11.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(21.0, 21.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(31.0, 31.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(41.0, 41.0,  1.0,  1.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 5.0,  5.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(15.0, 15.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(25.0, 25.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(35.0, 35.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(45.0, 45.0,  3.0,  3.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake( 5.0,  5.0, 90.0, 90.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0, 90.0, 90.0)], @"insertBoundingRect failed");
}

- (void)testThatInsertBoundingRectHandlesRectTooWideAndHigh
{
    XCTAssertFalse([self.objectUnderTest insertBoundingRect:CGRectMake(0.0, 0.0, 200.0, 200.0)], @"insertBoundingRect (too large) still succeeded");
}

- (void)testThatInsertBoundingRectHandlesRectTooWide
{
    XCTAssertFalse([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0, 200.0, 10.0)], @"insertBoundingRect (too large) still succeeded");
}

- (void)testThatInsertBoundingRectHandlesRectTooHigh
{
    XCTAssertFalse([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, 10.0, 10.0, 200.0)], @"insertBoundingRect (too large) still succeeded");
}

- (void)testThatInsertBoundingRectHandlesRectPartiallyOutside
{
    XCTAssertFalse([self.objectUnderTest insertBoundingRect:CGRectMake(10.0, -10.0, 100.0, 10.0)], @"insertBoundingRect (too large) still succeeded");
}

#pragma mark - -hasGlyphThatIntersectsWithWordRect: Tests

- (void)testThatHasGlyphThatIntersectsWithWordRectHandlesEmptyQuadTree
{
    XCTAssertFalse([self.objectUnderTest hasGlyphThatIntersectsWithWordRect:CGRectZero], @"hasGlyphThatIntersectsWithWordRect matched while quadtree is empty");
}

- (void)testThatHasGlyphThatIntersectsWithWordRectHandlesEqualRects
{
    CGRect intersection = CGRectMake(10.0, 10.0, 90.0, 90.0);
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:intersection], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest hasGlyphThatIntersectsWithWordRect:intersection], @"hasGlyphThatIntersectsWithWordRect failed to match");
}

- (void)testThatHasGlyphThatIntersectsWithWordRectHandlesAdjacentCorners
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0, 40.0, 40.0)], @"insertBoundingRect failed");
    XCTAssertFalse([self.objectUnderTest hasGlyphThatIntersectsWithWordRect:CGRectMake(10.0, 10.0, 30.0, 30.0)], @"hasGlyphThatIntersectsWithWordRect failed to match");
}

- (void)testThatHasGlyphThatIntersectsWithWordRectHandlesAdjacentSides
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0, 40.0, 40.0)], @"insertBoundingRect failed");
    XCTAssertFalse([self.objectUnderTest hasGlyphThatIntersectsWithWordRect:CGRectMake(40.0, 20.0, 40.0, 20.0)], @"hasGlyphThatIntersectsWithWordRect failed to match");
}

- (void)testThatHasGlyphThatIntersectsWithWordRectHandlesContainsSmaller
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(40.0, 40.0, 40.0, 40.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest hasGlyphThatIntersectsWithWordRect:CGRectMake(50.0, 50.0, 20.0, 20.0)], @"hasGlyphThatIntersectsWithWordRect failed to match");
}

- (void)testThatHasGlyphThatIntersectsWithWordRectHandlesContainsLarger
{
    XCTAssertTrue([self.objectUnderTest insertBoundingRect:CGRectMake(50.0, 50.0, 20.0, 20.0)], @"insertBoundingRect failed");
    XCTAssertTrue([self.objectUnderTest hasGlyphThatIntersectsWithWordRect:CGRectMake(40.0, 40.0, 40.0, 40.0)], @"hasGlyphThatIntersectsWithWordRect failed to match");
}

@end
