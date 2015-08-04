//
//  ColorTableViewController.m
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

#import "ColorTableViewController.h"

#import "UIFont+CloudSettings.h" // For +lal_preferredContentSizeDelta

@implementation ColorTableViewController

@synthesize currentColorSelection = _currentColorSelection;

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
    if ([[segue identifier] isEqualToString:@"unwindFromColorPreference"])
    {
        NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
        self.currentColorSelection = selectedPath.row;
    }
}

#pragma mark - <UITableviewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section
{
    return [UIColor lal_numberOfPreferredColors];
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForHeaderInSection:(NSInteger)__unused section
{
    return @"Color preference";
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForFooterInSection:(NSInteger)__unused section
{
    return @"“Behold, the Lion of the tribe of Judah, the Root of David, has prevailed...”\n\n“And behold, I am coming quickly, and My reward is with Me, to give to every one according to his work. I am the Alpha and the Omega, the Beginning and the End, the First and the Last.”";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Color" forIndexPath:indexPath];
    cell.textLabel.attributedText = [UIColor lal_attributedTextWithPreferredColor:indexPath.row contentSizeDelta:self.preferredContentSizeDelta];

    cell.accessoryType = (indexPath.row == self.currentColorSelection) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)__unused tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor lal_backgroundColorForPreferredColor:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == self.currentColorSelection)
    {
        return;
    }

    NSInteger previousFontSelection = self.currentColorSelection;
    self.currentColorSelection = indexPath.row;

    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:previousFontSelection inSection:0],
                                        [NSIndexPath indexPathForRow:self.currentColorSelection inSection:0]]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <UIStateRestoring>

static NSString * const kLALcurrentColorSelectionKey = @"LALcurrentColorSelectionKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];

    [coder encodeInteger:self.currentColorSelection forKey:kLALcurrentColorSelectionKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];

    self.currentColorSelection = [coder decodeIntegerForKey:kLALcurrentColorSelectionKey];
}

#pragma mark - Notification handlers

#pragma mark - Actions

#pragma mark - Private methods

@end
