//
//  TableViewController.m
//  LionAndLamb
//
//  Created by Peter Jensen on 5/18/15.
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

#import "TableViewController.h"

@import Darwin.C.tgmath; // For fmax
#import "UIFont+CloudSettings.h" // For +lal_preferredContentSizeDelta

@interface TableViewController ()

@property (nonatomic, assign, readwrite) CGFloat preferredContentSizeDelta;

@end

@implementation TableViewController

@synthesize preferredContentSizeDelta = _preferredContentSizeDelta;

#pragma mark - Initialization

// Override to support custom initialization.
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initialization
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self
                               selector:@selector(contentSizeCategoryDidChange:)
                                   name:UIContentSizeCategoryDidChangeNotification
                                 object:nil];
    }
    return self;
}

- (void)dealloc
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

#pragma mark - Getters and setters

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tableView.rowHeight = [self p_determineRowHeightForPreferredFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableviewDataSource>

- (BOOL)tableView:(UITableView *)__unused tableView canEditRowAtIndexPath:(NSIndexPath *)__unused indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - <UITableViewDelegate>

#pragma mark - <UIStateRestoring>

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
}

#pragma mark - Notification handlers

/**
 Calculate a new estimated row height when the content size changes
 */
- (void)contentSizeCategoryDidChange:(NSNotification *)__unused notification
{
    self.tableView.rowHeight = [self p_determineRowHeightForPreferredFont];
    [self.tableView reloadData];
}

#pragma mark - Actions

#pragma mark - Private methods

- (CGFloat)p_determineRowHeightForPreferredFont
{
    // Cap delta to non-accessibility max size

    self.preferredContentSizeDelta = fmin(3.0, [UIFont lal_preferredContentSizeDelta]);

    return 44.0 + self.preferredContentSizeDelta;
}

@end
