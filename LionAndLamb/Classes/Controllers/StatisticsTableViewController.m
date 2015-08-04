//
//  StatisticsTableViewController.m
//  LionAndLamb
//
//  Created by Peter Jensen on 6/24/15.
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

#import "StatisticsTableViewController.h"
#import "StatisticsTableViewCell.h"

#import "VersionTableViewController.h"

#import "LALDataSource.h"

#import "CloudViewController.h" // For kLALuserSettingsStopwordsKey

typedef NS_ENUM(NSInteger, LALStatisticsTableViewSection) {
    LALStatisticsTableViewSectionVersion,
    LALStatisticsTableViewSectionWords,
};

static NSInteger kLALSettingsTableViewNumberOfSections = 2;

@interface StatisticsTableViewController ()
/**
 A strong reference to an array of cloud words and their word counts
 */
@property (nonatomic, strong) NSArray *cloudWords;
/**
 The total number of words in the current source
 */
@property (nonatomic, assign) NSInteger totalWords;
/**
 The unique number of words in the current source
 */
@property (nonatomic, assign) NSInteger uniqueWords;
/**
 The user's preferred stopwords setting

 @note Stopwords never appear in the cloud, but can be toggled for statistics
 */
@property (nonatomic, assign, getter=hasStopWords) BOOL stopWords;
/**
 The word total for the most frequent word
 */
@property (nonatomic, assign) NSInteger mostFrequentWordTotal;

@end

@implementation StatisticsTableViewController

@synthesize currentSourceSelection = _currentSourceSelection;
@synthesize currentVersionSelection = _currentVersionSelection;

@synthesize cloudWords = _cloudWords;
@synthesize totalWords = _totalWords;
@synthesize uniqueWords = _uniqueWords;
@synthesize stopWords = _stopWords;
@synthesize mostFrequentWordTotal = _mostFrequentWordTotal;

#pragma mark - Initialization

#pragma mark - Getters and setters

- (NSArray *)cloudWords
{
    if (!_cloudWords)
    {
        _cloudWords = [[LALDataSource sharedDataSource] cloudWordsForTopic:self.currentSourceSelection includeRank:YES stopWords:self.stopWords inVersion:self.currentVersionSelection];
        self.mostFrequentWordTotal = [[[_cloudWords firstObject] valueForKey:@"total"] integerValue];
    }

    return _cloudWords;
}

- (NSInteger)totalWords
{
    if (!_totalWords)
    {
        _totalWords = [[LALDataSource sharedDataSource] totalWordsForTopic:self.currentSourceSelection inVersion:self.currentVersionSelection];
    }

    return _totalWords;
}

- (NSInteger)uniqueWords
{
    if (!_uniqueWords)
    {
        _uniqueWords = [[LALDataSource sharedDataSource] uniqueWordsForTopic:self.currentSourceSelection inVersion:self.currentVersionSelection];
    }

    return _uniqueWords;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.stopWords = [[NSUserDefaults standardUserDefaults] boolForKey:kLALuserSettingsStopwordsKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scene management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)__unused sender
{
    if ([[segue identifier] isEqualToString:@"showVersion"])
    {
        VersionTableViewController *controller = (VersionTableViewController *)segue.destinationViewController;
        controller.currentVersionSelection = self.currentVersionSelection;
    }
}

#pragma mark - <UITableviewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView
{
    return kLALSettingsTableViewNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)section
{
    return section == LALStatisticsTableViewSectionWords ? [self.cloudWords count] : 2;
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case LALStatisticsTableViewSectionVersion:
            return @"Version preference";
        case LALStatisticsTableViewSectionWords:
            return [NSString stringWithFormat:@"Most frequent words in %@\n%ld total words, %ld unique words", [[LALDataSource sharedDataSource] titleForTopic:self.currentSourceSelection inVersion:self.currentVersionSelection], (long)self.totalWords, (long)self.uniqueWords];
        default:
            return nil;
    }
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case LALStatisticsTableViewSectionVersion:
            return @"Common words are always omitted from the word cloud.";
        case LALStatisticsTableViewSectionWords:
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatisticsTableViewCell *cell = nil;

    if (indexPath.section == LALStatisticsTableViewSectionVersion)
    {
        if (indexPath.row)
        {
            // Common words
            cell = [tableView dequeueReusableCellWithIdentifier:@"Common Words" forIndexPath:indexPath];

            // If the cell does not already have a switch for its accessoryView, add one
            if (!cell.accessoryView)
            {
                cell.accessoryView = [[UISwitch alloc] init];
                [(UISwitch *)cell.accessoryView addTarget:self action:@selector(commonWordsChanged:) forControlEvents:UIControlEventValueChanged];
            }
            cell.textLabel.text = @"Common Words";
            cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
            UISwitch *accessorySwitch = (UISwitch *)cell.accessoryView;
            accessorySwitch.on = [self hasStopWords];
        }
        else
        {
            // Version
            cell = [tableView dequeueReusableCellWithIdentifier:@"Version" forIndexPath:indexPath];
            cell.textLabel.text = [[LALDataSource sharedDataSource] titleForVersion:self.currentVersionSelection];
            cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
        }
    }
    else // LALStatisticsTableViewSectionWords
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Statistics" forIndexPath:indexPath];

        NSDictionary *word = self.cloudWords[indexPath.row];

        cell.wordLabel.text = [NSString stringWithFormat:@"%@. %@", word[@"rank"], word[@"title"]];
        cell.wordLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];

        NSNumber *occurrences = word[@"total"];
        CGFloat percentage = occurrences.doubleValue * 100.0 / self.totalWords;

        cell.totalLabel.text = [NSString stringWithFormat:@"%@ (%0.1f%%)", occurrences, percentage];
        cell.totalLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize - 5.0 + self.preferredContentSizeDelta)];

        cell.totalBarMultiplier = occurrences.doubleValue / self.mostFrequentWordTotal;
    }

    return cell;
}

#pragma mark - <UITableViewDelegate>

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

- (IBAction)done:(UIBarButtonItem *)__unused sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)unwindFromVersionPreference:(UIStoryboardSegue *)segue
{
    VersionTableViewController *versionTableViewController = segue.sourceViewController;
    if (self.currentVersionSelection != versionTableViewController.currentVersionSelection)
    {
        self.currentVersionSelection = versionTableViewController.currentVersionSelection;
        self.cloudWords = nil;
        self.totalWords = 0;
        self.uniqueWords = 0;
        [self.tableView reloadData];
    }
}

- (void)commonWordsChanged:(UISwitch *)sender
{
    self.stopWords = sender.on;
    [[NSUserDefaults standardUserDefaults] setBool:self.stopWords forKey:kLALuserSettingsStopwordsKey];

    self.cloudWords = nil;
    [self.tableView reloadData];
}

#pragma mark - Private methods

@end
