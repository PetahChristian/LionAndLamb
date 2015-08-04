//
//  CloudWordTests.m
//  LionAndLamb
//
//  Created by Peter Jensen on 4/27/15.
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

#import "CloudWord.h"

@interface CloudWord ()

// Expose private methods for testing
- (CGPoint)randomGaussian;

@end

@interface CloudWordTests : XCTestCase

@property (nonatomic, strong) CloudWord *objectUnderTest;

@end

@implementation CloudWordTests

@synthesize objectUnderTest = _objectUnderTest;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.objectUnderTest = [[CloudWord alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.objectUnderTest = nil;
}

#pragma mark - -randomGaussian Tests

- (void)testThatRandomGaussianReturnsRandomPointWithinStandardNormalBounds
{
    // 2 or 3 occurrences > 6-sigma for 1,000,000,000 numbers
    NSUInteger iterations = 50000000;

    for (NSUInteger i = 0; i < iterations; i++)
    {
        CGPoint sut = [self.objectUnderTest randomGaussian];
        XCTAssertTrue(fabs(sut.x) <= 6 && fabs(sut.y) <= 6, @"large bounds for random point %@", NSStringFromCGPoint(sut));
    }
}

- (void)testThatRandomGaussianReturnsGaussianDistribution
{
    NSUInteger sigma[] = {0, 0, 0, 0, 0, 0};

    // 2 or 3 occurrences > 6-sigma for 1,000,000,000 numbers
    NSUInteger iterations = 50000000;

    for (NSUInteger i = 0; i < iterations; i++)
    {
        CGPoint sut = [self.objectUnderTest randomGaussian];
        switch ((NSUInteger)(fabs(sut.x)))
        {
            case 0:
                sigma[0]++;
            case 1:
                sigma[1]++;
            case 2:
                sigma[2]++;
            case 3:
                sigma[3]++;
            case 4:
                sigma[4]++;
            case 5:
                sigma[5]++;
            default:
                ;
        }
        switch ((NSUInteger)(fabs(sut.y)))
        {
            case 0:
                sigma[0]++;
            case 1:
                sigma[1]++;
            case 2:
                sigma[2]++;
            case 3:
                sigma[3]++;
            case 4:
                sigma[4]++;
            case 5:
                sigma[5]++;
            default:
                ;
        }
    }

    NSUInteger sigmaLength = sizeof(sigma) / sizeof(sigma[0]);
    iterations *= 2; // tested 2 values per iteration
    for (NSUInteger i = 0; i < sigmaLength; i++)
    {
        sigma[i] = (sigma[i] * 100) / iterations;
    }

    // 68.27% should fall within 1 standard deviation
    XCTAssertTrue(sigma[0] >= 67 && sigma[0] <= 69, @"unexpected distribution (%ld) within 1-sigma", (unsigned long)sigma[0]);

    // 95.45% should fall within 2 standard deviations
    XCTAssertTrue(sigma[1] >= 94 && sigma[1] <= 96, @"unexpected distribution (%ld) within 2-sigma", (unsigned long)sigma[1]);

    // 99.73% should fall within 3 standard deviations
    XCTAssertTrue(sigma[2] >= 98                  , @"unexpected distribution (%ld) within 3-sigma", (unsigned long)sigma[2]);

    // 99.99% should fall within 4 standard deviations
    XCTAssertTrue(sigma[3] >= 99                  , @"unexpected distribution (%ld) within 4-sigma", (unsigned long)sigma[3]);
    XCTAssertTrue(sigma[4] >= 99                  , @"unexpected distribution (%ld) within 5-sigma", (unsigned long)sigma[4]);
    XCTAssertTrue(sigma[5] >= 99                  , @"unexpected distribution (%ld) within 6-sigma", (unsigned long)sigma[5]);
}

- (void)testThatRandomGaussianReturnsMean
{
    // 2 or 3 occurrences > 6-sigma for 1,000,000,000 numbers
    NSUInteger iterations = 50000000;

    CGFloat totalX = 0.0;
    CGFloat totalY = 0.0;

    for (NSUInteger i = 0; i < iterations; i++)
    {
        CGPoint sut = [self.objectUnderTest randomGaussian];
        totalX += sut.x;
        totalY += sut.y;
    }

    CGFloat averageX, averageY;

    averageX = totalX / iterations;
    averageY = totalY / iterations;

    XCTAssertTrue(averageX < 0.001, @"Skewed average X %f", averageX);
    XCTAssertTrue(averageY < 0.001, @"Skewed average Y %f", averageY);
}


@end
