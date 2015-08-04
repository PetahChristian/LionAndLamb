//
//  StatisticsTableViewCell.h
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

@import UIKit;

@interface StatisticsTableViewCell : UITableViewCell
/**
 A label used for the (word rank and) word title
 */
@property (nonatomic, weak) IBOutlet UILabel *wordLabel;
/**
 A label used for the word total (and percentage)
 */
@property (nonatomic, weak) IBOutlet UILabel *totalLabel;
/**
 A multiplier applied to the totalBar width, in proportion to the most frequent word
 
 @note The totalBar multiplier for the most frequent word is 1.0.  A word that
 occurs half as often as the most frequent word would have a multiplier of 0.5.
 */
@property (nonatomic, assign) CGFloat totalBarMultiplier;

@end
