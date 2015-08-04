//
//  FontTableViewController.m
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

#import "FontTableViewController.h"

@implementation FontTableViewController

@synthesize currentFontSelection = _currentFontSelection;

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
    if ([[segue identifier] isEqualToString:@"unwindFromFontPreference"])
    {
        NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
        self.currentFontSelection = selectedPath.row;
    }
}

#pragma mark - <UITableviewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section
{
    return [UIFont lal_numberOfPreferredFonts];
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForHeaderInSection:(NSInteger)__unused section
{
    return @"Font preference";
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForFooterInSection:(NSInteger)__unused section
{
    return @"“Behold! The Lamb of God who takes away the sin of the world!”\n\n“that if you confess with your mouth the Lord Jesus and believe in your heart that God has raised Him from the dead, you will be saved. For with the heart one believes unto righteousness, and with the mouth confession is made unto salvation.”";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Font" forIndexPath:indexPath];

    cell.textLabel.text = @"Jesus Christ, God's Son, Savior";
    cell.textLabel.font = [UIFont fontWithName:[UIFont lal_fontNameForPreferredFont:indexPath.row] size:16.0 + self.preferredContentSizeDelta];

    cell.accessoryType = (indexPath.row == self.currentFontSelection) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == self.currentFontSelection)
    {
        return;
    }

    NSInteger previousFontSelection = self.currentFontSelection;
    self.currentFontSelection = indexPath.row;

    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:previousFontSelection inSection:0],
                                        [NSIndexPath indexPathForRow:self.currentFontSelection inSection:0]]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - <UIStateRestoring>

static NSString * const kLALcurrentFontSelectionKey = @"LALcurrentFontSelectionKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];

    [coder encodeInteger:self.currentFontSelection forKey:kLALcurrentFontSelectionKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];

    self.currentFontSelection = [coder decodeIntegerForKey:kLALcurrentFontSelectionKey];
}

#pragma mark - Notification handlers

#pragma mark - Actions

#pragma mark - Private methods

@end
