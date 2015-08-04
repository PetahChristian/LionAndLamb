//
//  CloudViewController.m
//  LionAndLamb
//
//  Created by Peter Jensen on 4/24/15.
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

#import "CloudViewController.h"

#import "CloudLayoutOperation.h" // For <CloudLayoutOperationDelegate> protocol

#import "UIFont+CloudSettings.h" // For LALSettingsFont
#import "UIColor+CloudSettings.h" // For LALSettingsColor

#import "LALDataSource.h"

#import "SettingsTableViewController.h"
#import "StatisticsTableViewController.h"

NSString * const kLALuserSettingsSourceKey = @"LALuserSettingsSourceKey";
NSString * const kLALuserSettingsVersionKey = @"LALuserSettingsVersionKey";
NSString * const kLALuserSettingsFontKey = @"LALuserSettingsFontKey";
NSString * const kLALuserSettingsColorKey = @"LALuserSettingsColorKey";
NSString * const kLALuserSettingsStopwordsKey = @"LALuserSettingsStopwordsKey";
NSString * const kLALshowHintCloudTapKey = @"LALshowHintCloudTapKey";
NSString * const kLALshowHintCloudSwipeKey = @"LALshowHintCloudSwipeKey";
NSString * const kLALshowAnimationCloudTitleKey = @"LALshowAnimationCloudTitleKey";

@interface CloudViewController () <CloudLayoutOperationDelegate>
/**
 A weak reference to the cloud's descriptive title
 */
@property (nonatomic, weak) IBOutlet UIButton *cloudTitle;
///**
// A strong reference to the dictionary of words and their word counts
// */
//@property (nonatomic, strong) NSDictionary *cloudWords;
/**
 A strong reference to an array of UIColor cloud colors
 
 @note These colors are related to the currentColorPreference enum
 */
@property (nonatomic, strong) NSArray *cloudColors;
/**
 A strong reference to the current cloud font name
 */
@property (nonatomic, strong) NSString *cloudFontName;
/**
 A strong reference to the cloud layout operation queue
 
 @note This is a sequential operation queue that handles the layout for the cloud words
 */
@property (nonatomic, strong) NSOperationQueue *cloudLayoutOperationQueue;
/**
 The current source preference for the cloud's words

 @note This is the bible, the old or new testament, or a specific bible book
 */
@property (nonatomic, assign) NSInteger currentSourcePreference;
/**
 The current (bible) version preference for the cloud's words
 */
@property (nonatomic, assign) NSInteger currentVersionPreference;
/**
 The current font preference for the cloud's words
 */
@property (nonatomic, assign) LALSettingsFont currentFontPreference;
/**
 The current color preference for the cloud's words
 */
@property (nonatomic, assign) LALSettingsColor currentColorPreference;

@end

@implementation CloudViewController

@synthesize managedObjectContext = _managedObjectContext;

@synthesize cloudTitle = _cloudTitle;
//@synthesize cloudWords = _cloudWords;
@synthesize cloudColors = _cloudColors;
@synthesize cloudFontName = _cloudFontName;
@synthesize cloudLayoutOperationQueue = _cloudLayoutOperationQueue;
@synthesize currentSourcePreference = _currentSourcePreference;
@synthesize currentVersionPreference = _currentVersionPreference;
@synthesize currentFontPreference = _currentFontPreference;
@synthesize currentColorPreference = _currentColorPreference;

#pragma mark - Initialization

// Override to support custom initialization.
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // Custom initialization
        _cloudLayoutOperationQueue = [[NSOperationQueue alloc] init];
        _cloudLayoutOperationQueue.name = @"Cloud layout operation queue";
        _cloudLayoutOperationQueue.maxConcurrentOperationCount = 1;

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
    [_cloudLayoutOperationQueue cancelAllOperations];

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.currentSourcePreference = [[NSUserDefaults standardUserDefaults] integerForKey:kLALuserSettingsSourceKey];
    self.currentVersionPreference = [[NSUserDefaults standardUserDefaults] integerForKey:kLALuserSettingsVersionKey];
    self.currentFontPreference = [[NSUserDefaults standardUserDefaults] integerForKey:kLALuserSettingsFontKey];
    self.currentColorPreference = [[NSUserDefaults standardUserDefaults] integerForKey:kLALuserSettingsColorKey];

    [self layoutCloudWords];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public methods

#pragma mark - Scene management

#pragma mark - <CloudLayoutOperationDelegate>

- (void)insertTitle:(NSString *)cloudTitle
{
    BOOL showCloudTitleAnimation = [[NSUserDefaults standardUserDefaults] boolForKey:kLALshowAnimationCloudTitleKey];

    if (showCloudTitleAnimation)
    {
        [self updateCloudTitle:cloudTitle];
        self.cloudTitle.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:6.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.cloudTitle.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    else
    {
        [UIView performWithoutAnimation:^{
            [self updateCloudTitle:cloudTitle];
        }];
    }
}

- (void)insertWord:(NSString *)word pointSize:(CGFloat)pointSize color:(NSUInteger)color center:(CGPoint)center vertical:(BOOL)isVertical
{
    UILabel *wordLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    wordLabel.text = word;
    wordLabel.textAlignment = NSTextAlignmentCenter;
    wordLabel.textColor = self.cloudColors[color < self.cloudColors.count ? color : 0];
    wordLabel.font = [UIFont fontWithName:self.cloudFontName size:pointSize];

    [wordLabel sizeToFit];

    // Round up size to even multiples to "align" frame without ofsetting center
    CGRect wordLabelRect = wordLabel.frame;
    wordLabelRect.size.width = ((NSInteger)((CGRectGetWidth(wordLabelRect) + 3) / 2)) * 2;
    wordLabelRect.size.height = ((NSInteger)((CGRectGetHeight(wordLabelRect) + 3) / 2)) * 2;
    wordLabel.frame = wordLabelRect;

    wordLabel.center = center;

    if (isVertical)
    {
        wordLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    }

//#ifdef DEBUG
//    wordLabel.layer.borderColor = [UIColor redColor].CGColor;
//    wordLabel.layer.borderWidth = 1;
//#endif

    [self.view addSubview:wordLabel];
}

#ifdef DEBUG
- (void)insertBoundingRect:(CGRect)rect
{
    CALayer *boundingRect = [CALayer layer];
    boundingRect.frame = rect;
    boundingRect.borderColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.5].CGColor;
    boundingRect.borderWidth = 1;
    [self.view.layer addSublayer:boundingRect];
}
#endif

#pragma mark - <UIContentContainer>

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    __weak __typeof__(&*self) weakSelf = self;

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>__unused context) {
        __typeof__(&*weakSelf) strongSelf = weakSelf;
        [strongSelf layoutCloudWords];
    } completion:nil];
}

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
 Content size category has changed.  Layout cloud again, to account for new pointSize
 */
- (void)contentSizeCategoryDidChange:(NSNotification *)__unused notification
{
    [self layoutCloudWords];
}

#pragma mark - Actions

/**
 User tapped the cloud view.  Layout cloud again (to rearrange its appearance)
 */
- (IBAction)layoutCloudWordsAgain:(UITapGestureRecognizer *)__unused sender
{
    [self layoutCloudWords];

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLALshowHintCloudTapKey];
}

- (IBAction)previousSource:(UISwipeGestureRecognizer *)__unused sender
{
    self.currentSourcePreference = [[LALDataSource sharedDataSource] previousTopicForTopic:self.currentSourcePreference inVersion:self.currentVersionPreference];
    [[NSUserDefaults standardUserDefaults] setValue:@(self.currentSourcePreference) forKey:kLALuserSettingsSourceKey];
    [self layoutCloudWords];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLALshowHintCloudSwipeKey];
}

- (IBAction)nextSource:(UISwipeGestureRecognizer *)__unused sender
{
    self.currentSourcePreference = [[LALDataSource sharedDataSource] nextTopicForTopic:self.currentSourcePreference inVersion:self.currentVersionPreference];
    [[NSUserDefaults standardUserDefaults] setValue:@(self.currentSourcePreference) forKey:kLALuserSettingsSourceKey];
    [self layoutCloudWords];

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLALshowHintCloudSwipeKey];
}

/**
 Presents an action sheet that lets the user share, redraw, or change the word cloud,
 or to get information about the Lord and the app
 
 @param sender The UIButton that initiated the action
 */
- (IBAction)showActionSheet:(UIButton *)sender
{
    // The button's bounds is large, to give it a big hit area.  Use a smaller bounds so any popover arrow will be closer to the button's title

    CGRect bounds = sender.bounds;
    bounds.size.width -= 32;
    bounds.size.height -= 32;
    bounds.origin.y += 32;

    BOOL showCloudTapGesture = [[NSUserDefaults standardUserDefaults] boolForKey:kLALshowHintCloudTapKey];
    BOOL showCloudSwipeGesture = [[NSUserDefaults standardUserDefaults] boolForKey:kLALshowHintCloudSwipeKey];

    NSString *title = showCloudTapGesture || showCloudSwipeGesture ? @"Alternative gestures for the word cloud" : nil;
    NSString *message = showCloudTapGesture || showCloudSwipeGesture ? @"You can also swipe left/right to change the cloud's topic, or tap to shuffle its words." : nil;

    __weak __typeof__(&*self) weakSelf = self;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"Share word cloud with others" style:UIAlertActionStyleDefault handler:^ void (UIAlertAction __unused *action)
                                  {
                                      __typeof__(&*weakSelf) strongSelf = weakSelf;

                                      UIGraphicsBeginImageContextWithOptions(strongSelf.view.bounds.size, YES, 0.0);
                                      BOOL success = [strongSelf.view drawViewHierarchyInRect:strongSelf.view.bounds afterScreenUpdates:NO];
                                      if (success)
                                      {
                                          UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
                                          NSURL *appURL = [NSURL URLWithString:@"https://itunes.apple.com/app/lion-lamb-admiring-jesus-christ/id1018992236?mt=8&at=1010l3f4"];

                                          UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[snapshotImage, appURL] applicationActivities:nil];

                                          // Exclude AirDrop, as it appears to delay the initial appearance of the activity sheet
//                                          activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];

                                          UIPopoverPresentationController *popoverPresentationController = [activityViewController popoverPresentationController];

                                          popoverPresentationController.sourceView = sender;
                                          popoverPresentationController.sourceRect = bounds;

                                          [strongSelf presentViewController:activityViewController animated:YES completion:nil];
                                      }
                                      UIGraphicsEndImageContext();

                                  }];
    [alertController addAction:shareAction];

    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Choose a different topic" style:UIAlertActionStyleDefault handler:^ void (UIAlertAction __unused *action)
                                     {
                                         __typeof__(&*weakSelf) strongSelf = weakSelf;

                                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

                                         UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"SettingsNavigationControllerID"];
                                         if ([navigationController.topViewController isKindOfClass:[SettingsTableViewController class]])
                                         {
                                             SettingsTableViewController *tableViewController = (SettingsTableViewController *)navigationController.topViewController;

                                             tableViewController.currentSourceSelection = self.currentSourcePreference;
                                             tableViewController.currentVersionSelection = self.currentVersionPreference;
                                             tableViewController.currentFontSelection = self.currentFontPreference;
                                             tableViewController.currentColorSelection = self.currentColorPreference;
                                         }

                                         [strongSelf presentViewController:navigationController animated:YES completion:nil];
                                     }];
    [alertController addAction:settingsAction];

    UIAlertAction *redrawAction = [UIAlertAction actionWithTitle:@"Shuffle these words" style:UIAlertActionStyleDefault handler:^ void (UIAlertAction __unused *action)
                                   {
                                       __typeof__(&*weakSelf) strongSelf = weakSelf;
                                       [strongSelf layoutCloudWords];
                                   }];
    [alertController addAction:redrawAction];

    UIAlertAction *infoAction = [UIAlertAction actionWithTitle:@"Show statistics" style:UIAlertActionStyleDefault handler:^ void (UIAlertAction __unused *action)
                                 {
                                     __typeof__(&*weakSelf) strongSelf = weakSelf;

                                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

                                     UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"StatisticsNavigationControllerID"];
                                     if ([navigationController.topViewController isKindOfClass:[StatisticsTableViewController class]])
                                     {
                                         StatisticsTableViewController *tableViewController = (StatisticsTableViewController *)navigationController.topViewController;

                                         tableViewController.currentSourceSelection = self.currentSourcePreference;
                                         tableViewController.currentVersionSelection = self.currentVersionPreference;
                                     }

                                     [strongSelf presentViewController:navigationController animated:YES completion:nil];
                                 }];
    [alertController addAction:infoAction];

    // Create a cancel action

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    // Configure the alert controller's popover presentation controller if it has one

    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];

    popoverPresentationController.sourceView = sender;
    popoverPresentationController.sourceRect = bounds;

    [self presentViewController:alertController animated:YES completion:nil];

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLALshowAnimationCloudTitleKey];
}

- (IBAction)unwindToCloudViewController:(UIStoryboardSegue *)sender
{
    if ([sender.sourceViewController isKindOfClass:[SettingsTableViewController class]])
    {
        SettingsTableViewController *sourceViewController = sender.sourceViewController;

        BOOL settingsChanged = NO;

        // Check to see if any settings have changed.  If so, save the new settings, and layout the cloud again

        if (self.currentSourcePreference != sourceViewController.currentSourceSelection)
        {
            settingsChanged = YES;
            self.currentSourcePreference = sourceViewController.currentSourceSelection;
            [[NSUserDefaults standardUserDefaults] setValue:@(self.currentSourcePreference) forKey:kLALuserSettingsSourceKey];
        }

        if (self.currentVersionPreference != sourceViewController.currentVersionSelection)
        {
            settingsChanged = YES;
            self.currentVersionPreference = sourceViewController.currentVersionSelection;
            [[NSUserDefaults standardUserDefaults] setValue:@(self.currentVersionPreference) forKey:kLALuserSettingsVersionKey];
        }

        if (self.currentFontPreference != sourceViewController.currentFontSelection)
        {
            settingsChanged = YES;
            self.currentFontPreference = sourceViewController.currentFontSelection;
            [[NSUserDefaults standardUserDefaults] setValue:@(self.currentFontPreference) forKey:kLALuserSettingsFontKey];
        }

        if (self.currentColorPreference != sourceViewController.currentColorSelection)
        {
            settingsChanged = YES;
            self.currentColorPreference = sourceViewController.currentColorSelection;
            [[NSUserDefaults standardUserDefaults] setValue:@(self.currentColorPreference) forKey:kLALuserSettingsColorKey];
        }

        if (settingsChanged)
        {
            [self layoutCloudWords];
        }
    }
}

#pragma mark - Private methods

/**
 Remove all words from the cloud view
 */
- (void)removeCloudWords
{
    NSMutableArray *removableObjects = [[NSMutableArray alloc] init];

    // Remove cloud words (UILabels)

    for (id subview in self.view.subviews)
    {
        if ([subview isKindOfClass:[UILabel class]])
        {
            [removableObjects addObject:subview];
        }
    }

    [removableObjects makeObjectsPerformSelector:@selector(removeFromSuperview)];

#ifdef DEBUG
    // Remove bounding boxes

    [removableObjects removeAllObjects];

    for (id sublayer in self.view.layer.sublayers)
    {
        if ([sublayer isKindOfClass:[CALayer class]] && ((CALayer *)sublayer).borderWidth && ![sublayer delegate])
        {
            [removableObjects addObject:sublayer];
        }
    }

    [removableObjects makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
#endif
}

- (void)layoutCloudWords
{
    // Cancel any in-progress layout
    [self.cloudLayoutOperationQueue cancelAllOperations];
    [self.cloudLayoutOperationQueue waitUntilAllOperationsAreFinished];

    [self removeCloudWords];

    self.cloudColors = [UIColor lal_colorsForPreferredColor:self.currentColorPreference];
    self.view.backgroundColor = [UIColor lal_backgroundColorForPreferredColor:self.currentColorPreference];

    self.cloudFontName = [UIFont lal_fontNameForPreferredFont:self.currentFontPreference];

    // Start a new cloud layout operation

    NSArray *cloudWords = [[LALDataSource sharedDataSource] cloudWordsForTopic:self.currentSourcePreference includeRank:NO stopWords:NO inVersion:self.currentVersionPreference];
    NSString *cloudTitle = [[LALDataSource sharedDataSource] titleForTopic:self.currentSourcePreference inVersion:self.currentVersionPreference];

    CloudLayoutOperation *newCloudLayoutOperation = [[CloudLayoutOperation alloc] initWithCloudWords:cloudWords
                                                                                               title:cloudTitle
                                                                                            fontName:self.cloudFontName
                                                                                forContainerWithSize:self.view.bounds.size
                                                                                               scale:[[UIScreen mainScreen] scale]
                                                                                            delegate:self];
    [self.cloudLayoutOperationQueue addOperation:newCloudLayoutOperation];
}

/**
 Update the title label for the cloudTitle button
 
 @param newTitle The new title
 */
- (void)updateCloudTitle:(NSString *)newTitle
{
    CGFloat pointSize = kLALsystemPointSize + [UIFont lal_preferredContentSizeDelta];
    self.cloudTitle.titleLabel.font = [UIFont systemFontOfSize:pointSize];
    [self.cloudTitle setTitle:newTitle forState:UIControlStateNormal];
    [self.cloudTitle layoutIfNeeded];
}

@end
