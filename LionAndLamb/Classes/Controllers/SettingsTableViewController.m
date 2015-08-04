//
//  SettingsTableViewController.m
//  LionAndLamb
//
//  Created by Peter Jensen on 5/16/15.
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

#import "SettingsTableViewController.h"

#import "SourceTableViewController.h"
#import "VersionTableViewController.h"
#import "FontTableViewController.h"
#import "ColorTableViewController.h"

#import "LALDataSource.h"

typedef NS_ENUM(NSInteger, LALSettingsTableViewSection) {
    LALSettingsTableViewSectionSource,
    LALSettingsTableViewSectionVersion,
    LALSettingsTableViewSectionFont,
    LALSettingsTableViewSectionColor,
    LALSettingsTableViewSectionEmail,
    LALSettingsTableViewSectionApps,
};

static NSInteger kLALSettingsTableViewNumberOfSections = 6;

@interface SettingsTableViewController ()

@property (nonatomic, strong) NSArray *appLinks;

@end

@implementation SettingsTableViewController

@synthesize currentSourceSelection = _currentSourceSelection;
@synthesize currentVersionSelection = _currentVersionSelection;
@synthesize currentFontSelection = _currentFontSelection;
@synthesize currentColorSelection = _currentColorSelection;

@synthesize appLinks = _appLinks;

#pragma mark - Initialization

#pragma mark - Getters and setters

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.appLinks = @[@[@"Bible Memory", @"https://itunes.apple.com/app/bible-memory-to-god-be-glory/id714235223?mt=8&at=1010l3f4", @"OtherAppsBibleMemory"],
                      @[@"Names of God", @"https://itunes.apple.com/app/names-of-god-from-the-bible/id860449184?mt=8&at=1010l3f4", @"OtherAppsNamesOfGod"],
                      @[@"The Messiah", @"https://itunes.apple.com/app/messiah-bible-prophecies-about/id951349672?mt=8&at=1010l3f4", @"OtherAppsTheMessiah"],
                      @[@"Composite Gospel", @"https://itunes.apple.com/app/composite-gospel-life-jesus/id967907349?mt=8&at=1010l3f4", @"OtherAppsCompositeGospel"],
                      ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scene management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)__unused sender
{
    if ([[segue identifier] isEqualToString:@"showSource"])
    {
        SourceTableViewController *controller = (SourceTableViewController *)segue.destinationViewController;
        controller.currentSourceSelection = self.currentSourceSelection;
        controller.currentVersionSelection = self.currentVersionSelection;
    }
    else if ([[segue identifier] isEqualToString:@"showVersion"])
    {
        VersionTableViewController *controller = (VersionTableViewController *)segue.destinationViewController;
        controller.currentVersionSelection = self.currentVersionSelection;
    }
    else if ([[segue identifier] isEqualToString:@"showFont"])
    {
        FontTableViewController *controller = (FontTableViewController *)segue.destinationViewController;
        controller.currentFontSelection = self.currentFontSelection;
    }
    else if ([[segue identifier] isEqualToString:@"showColor"])
    {
        ColorTableViewController *controller = (ColorTableViewController *)segue.destinationViewController;
        controller.currentColorSelection = self.currentColorSelection;
    }
}

#pragma mark - <UITableviewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView
{
    return kLALSettingsTableViewNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)section
{
    return section == LALSettingsTableViewSectionApps ? self.appLinks.count : 1;
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case LALSettingsTableViewSectionSource:
            return @"Show most frequent words from";
        case LALSettingsTableViewSectionVersion:
            return @"Version preference";
        case LALSettingsTableViewSectionFont:
            return @"Font preference";
        case LALSettingsTableViewSectionColor:
            return @"Color preference";
        case LALSettingsTableViewSectionEmail:
            return @"App help and feedback";
        case LALSettingsTableViewSectionApps:
            return @"Other apps";
        default:
            return nil;
    }
}

- (NSString *)tableView:(UITableView *)__unused tableView titleForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case LALSettingsTableViewSectionSource:
            return @"You can swipe left or right on the word cloud to change this topic, or tap the word cloud to rearrange its words.";
        case LALSettingsTableViewSectionVersion:
            return @"The size of each cloud word indicates how often the word occurs. Common words are omitted.";
        case LALSettingsTableViewSectionApps:
            return @"Follow @BibleMemoryApp on Twitter to hear about upcoming apps.";
        case LALSettingsTableViewSectionFont:
        case LALSettingsTableViewSectionColor:
        case LALSettingsTableViewSectionEmail:
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    if (indexPath.section == LALSettingsTableViewSectionSource)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Source" forIndexPath:indexPath];
        cell.textLabel.text = [[LALDataSource sharedDataSource] titleForTopic:self.currentSourceSelection inVersion:self.currentVersionSelection];
        cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
    }
    else if (indexPath.section == LALSettingsTableViewSectionVersion)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Version" forIndexPath:indexPath];
        cell.textLabel.text = [[LALDataSource sharedDataSource] titleForVersion:self.currentVersionSelection];
        cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
    }
    else if (indexPath.section == LALSettingsTableViewSectionFont)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Font" forIndexPath:indexPath];
        cell.textLabel.text = @"Jesus Christ, God's Son, Savior";
        cell.textLabel.font = [UIFont fontWithName:[UIFont lal_fontNameForPreferredFont:self.currentFontSelection]
                                               size:(kLALsystemPointSize + self.preferredContentSizeDelta)];
    }
    else if (indexPath.section == LALSettingsTableViewSectionColor)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Color" forIndexPath:indexPath];
        cell.textLabel.attributedText = [UIColor lal_attributedTextWithPreferredColor:self.currentColorSelection contentSizeDelta:self.preferredContentSizeDelta];
    }
    else if (indexPath.section == LALSettingsTableViewSectionEmail)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"URL" forIndexPath:indexPath];
        cell.textLabel.text = @"Email developer";
        cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
        cell.imageView.image = nil;
    }
    else // LALSettingsTableViewSectionApps
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"URL" forIndexPath:indexPath];
        cell.textLabel.text = self.appLinks[indexPath.row][0];
        cell.textLabel.font = [UIFont systemFontOfSize:(kLALsystemPointSize + self.preferredContentSizeDelta)];
        cell.imageView.image = [UIImage imageNamed:self.appLinks[indexPath.row][2]];
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)__unused tableView canEditRowAtIndexPath:(NSIndexPath *)__unused indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)__unused tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == LALSettingsTableViewSectionColor)
    {
        cell.backgroundColor = [UIColor lal_backgroundColorForPreferredColor:self.currentColorSelection];
    }
}

- (void)tableView:(UITableView *)__unused tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == LALSettingsTableViewSectionEmail)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullable-to-nonnull-conversion"
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:BibleMemoryApp@gmail.com?subject=Lion%20and%20Lamb%20app"]];
#pragma clang diagnostic pop
    }
    else if (indexPath.section == LALSettingsTableViewSectionApps)
    {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullable-to-nonnull-conversion"
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appLinks[indexPath.row][1]]];
#pragma clang diagnostic pop
    }
}

#pragma mark - <UIStateRestoring>

static NSString * const kLALcurrentSourceSelectionKey = @"LALcurrentSourceSelectionKey";
static NSString * const kLALcurrentVersionSelectionKey = @"LALcurrentVersionSelectionKey";
static NSString * const kLALcurrentFontSelectionKey = @"LALcurrentFontSelectionKey";
static NSString * const kLALcurrentColorSelectionKey = @"LALcurrentColorSelectionKey";


- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];

    [coder encodeInteger:self.currentSourceSelection forKey:kLALcurrentSourceSelectionKey];
    [coder encodeInteger:self.currentVersionSelection forKey:kLALcurrentVersionSelectionKey];
    [coder encodeInteger:self.currentFontSelection forKey:kLALcurrentFontSelectionKey];
    [coder encodeInteger:self.currentColorSelection forKey:kLALcurrentColorSelectionKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];

    self.currentSourceSelection = [coder decodeIntegerForKey:kLALcurrentSourceSelectionKey];
    self.currentVersionSelection = [coder decodeIntegerForKey:kLALcurrentVersionSelectionKey];
    self.currentFontSelection = [coder decodeIntegerForKey:kLALcurrentFontSelectionKey];
    self.currentColorSelection = [coder decodeIntegerForKey:kLALcurrentColorSelectionKey];
}

#pragma mark - Notification handlers

#pragma mark - Actions

- (IBAction)cancel:(UIBarButtonItem *)__unused sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)unwindFromSourcePreference:(UIStoryboardSegue *)segue
{
    SourceTableViewController *sourceTableViewController = segue.sourceViewController;
    if (self.currentSourceSelection != sourceTableViewController.currentSourceSelection)
    {
        self.currentSourceSelection = sourceTableViewController.currentSourceSelection;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:LALSettingsTableViewSectionSource]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)unwindFromVersionPreference:(UIStoryboardSegue *)segue
{
    VersionTableViewController *versionTableViewController = segue.sourceViewController;
    if (self.currentVersionSelection != versionTableViewController.currentVersionSelection)
    {
        self.currentVersionSelection = versionTableViewController.currentVersionSelection;
        // Also reload the source, as the topic titles may differ between versions
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:LALSettingsTableViewSectionVersion],
                                                 [NSIndexPath indexPathForRow:0 inSection:LALSettingsTableViewSectionSource]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)unwindFromFontPreference:(UIStoryboardSegue *)segue
{
    FontTableViewController *fontTableViewController = segue.sourceViewController;
    if (self.currentFontSelection != fontTableViewController.currentFontSelection)
    {
        self.currentFontSelection = fontTableViewController.currentFontSelection;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:LALSettingsTableViewSectionFont]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)unwindFromColorPreference:(UIStoryboardSegue *)segue
{
    ColorTableViewController *colorTableViewController = segue.sourceViewController;
    if (self.currentColorSelection != colorTableViewController.currentColorSelection)
    {
        self.currentColorSelection = colorTableViewController.currentColorSelection;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:LALSettingsTableViewSectionColor]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Private methods

@end
