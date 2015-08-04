//
//  StatisticsTableViewCell.m
//  LionAndLamb
//
//  Created by Peter Jensen on 7/5/15.
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

#import "StatisticsTableViewCell.h"

@interface StatisticsTableViewCell ()
/**
 A bar showing the word total.
 
 @note The progress view's progress is always 1.0
 */
@property (nonatomic, weak) IBOutlet UIProgressView *totalBar;
/**
 A width constraint used for the totalBar width
 
 @note The width of a bar corresponds to the word total
 */
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *totalBarWidth;
/**
 A flag indicating whether a forced initial layout pass occurred
 
 @note This is a workaround for incorrect initial label widths (since their initial frames are based on storyboard width, not contentView width)
 */
@property (nonatomic, assign, getter=hasForcedLayout) BOOL forcedLayout;

@end

@implementation StatisticsTableViewCell

@synthesize wordLabel = _wordLabel;
@synthesize totalLabel = _totalLabel;
@synthesize totalBarMultiplier = _totalBarMultiplier;

@synthesize totalBar = _totalBar;
@synthesize totalBarWidth = _totalBarWidth;
@synthesize forcedLayout = _forcedLayout;

#pragma mark - Initialization

#pragma mark - Public methods

- (void)layoutSubviews
{
    if (![self hasForcedLayout])
    {
        // Force an initial layout pass to ensure that the subViews are laid out for the correct (tableView) cell width
        [super layoutSubviews];
        [self.contentView layoutIfNeeded];
        self.forcedLayout = YES;
    }

    self.totalBarWidth.constant = CGRectGetWidth(self.wordLabel.bounds) * 0.7 * self.totalBarMultiplier;
    [super layoutSubviews];
}

@end
