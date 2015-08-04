//
//  SourceTableViewController.m
//  LionAndLamb
//
//  Created by Peter Jensen on 5/19/15.
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

#import "SourceTableViewController.h"

#import "UIFont+CloudSettings.h" // For +lal_preferredContentSizeDelta

#import "LALDataSource.h"

@implementation SourceTableViewController

@synthesize currentSourceSelection = _currentSourceSelection;
@synthesize currentVersionSelection = _currentVersionSelection;

#pragma mark - Initialization

#pragma mark - Getters and setters

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scene management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindFromSourcePreference"])
    {
        NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
        self.currentSourceSelection = selectedPath.row;
    }
}

#pragma mark - <UITableviewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section
{
    return [[LALDataSource sharedDataSource] numberofTopicsInVersion:self.currentVersionSelection];
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForHeaderInSection:(NSInteger)__unused section
{
    return @"Show most frequent words from";
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForFooterInSection:(NSInteger)__unused section
{
    return @"“For God so loved the world that He gave His only begotten Son, that whoever believes in Him should not perish but have everlasting life.”\n\n“But God demonstrates His own love toward us, in that while we were still sinners, Christ died for us.”";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Source" forIndexPath:indexPath];

    cell.textLabel.text = [[LALDataSource sharedDataSource] titleForTopic:indexPath.row inVersion:self.currentVersionSelection];
    cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
    
    cell.detailTextLabel.text = [[LALDataSource sharedDataSource] subtitleForTopic:indexPath.row inVersion:self.currentVersionSelection];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize - 5.0 + self.preferredContentSizeDelta)];

    cell.accessoryType = (indexPath.row == self.currentSourceSelection) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == self.currentSourceSelection)
    {
        return;
    }

    NSInteger previousSourceSelection = self.currentSourceSelection;
    self.currentSourceSelection = indexPath.row;

    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:previousSourceSelection inSection:0],
                                        [NSIndexPath indexPathForRow:self.currentSourceSelection inSection:0]]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <UIStateRestoring>

static NSString * const kLALcurrentSourceSelectionKey = @"LALcurrentSourceSelectionKey";
static NSString * const kLALcurrentVersionSelectionKey = @"LALcurrentVersionSelectionKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];

    [coder encodeInteger:self.currentSourceSelection forKey:kLALcurrentSourceSelectionKey];
    [coder encodeInteger:self.currentVersionSelection forKey:kLALcurrentVersionSelectionKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];

    self.currentSourceSelection = [coder decodeIntegerForKey:kLALcurrentSourceSelectionKey];
    self.currentVersionSelection = [coder decodeIntegerForKey:kLALcurrentVersionSelectionKey];
}

#pragma mark - Notification handlers

#pragma mark - Actions

#pragma mark - Private methods

@end
