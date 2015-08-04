//
//  LALDataSource.m
//  LionAndLamb
//
//  Created by Peter Jensen on 6/22/15.
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

#import "LALDataSource.h"

#import "LALVersion.h"
#import "LALTopic.h"
#import "LALWord.h"

@import CoreData;

@interface LALDataSource ()
/**
 The managed object context
 */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
/**
 The managed object model
 */
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
/**
 The persistent store coordinator

 @note The store is located in the main bundle, and is read-only
 */
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation LALDataSource

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Getters and setters

+ (instancetype)sharedDataSource
{
    static LALDataSource *sharedDataSource = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataSource = [[self alloc] init];
    });

    return sharedDataSource;
}

- (NSManagedObjectModel *)managedObjectModel
{
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LionAndLamb" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[NSBundle mainBundle] URLForResource:@"LionAndLamb" withExtension:@"sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:@{NSReadOnlyPersistentStoreOption : @YES,                                                                                                                            NSSQLitePragmasOption: @{ @"journal_mode" : @"DELETE"}}
                                                           error:&error])
    {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullable-to-nonnull-conversion"
        error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:9999 userInfo:dict];
#pragma clang diagnostic pop
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Public methods

- (NSInteger)numberofTopicsInVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALTopic entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", LALTopicAttributes.versionOrder, @(aVersion)]];

    NSError *error = nil;

    NSUInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];

    if (count == NSNotFound) {
        // Handle error
        return 0;
    }

    return count;
}

- (NSString *)titleForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALTopic entityName]];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = @[LALTopicAttributes.title];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", LALTopicAttributes.order, @(aTopic), LALTopicAttributes.versionOrder, @(aVersion)]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return nil;
    }

    return array.firstObject[LALTopicAttributes.title];
}

- (NSString *)subtitleForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALTopic entityName]];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = @[LALTopicAttributes.subtitle];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", LALTopicAttributes.order, @(aTopic), LALTopicAttributes.versionOrder, @(aVersion)]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return nil;
    }

    return array.firstObject[LALTopicAttributes.subtitle];
}

- (NSInteger)totalWordsForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALTopic entityName]];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = @[LALTopicAttributes.totalWords];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", LALTopicAttributes.order, @(aTopic), LALTopicAttributes.versionOrder, @(aVersion)]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return 0;
    }

    return [array.firstObject[LALTopicAttributes.totalWords] integerValue];
}

- (NSInteger)uniqueWordsForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALTopic entityName]];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = @[LALTopicAttributes.uniqueWords];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", LALTopicAttributes.order, @(aTopic), LALTopicAttributes.versionOrder, @(aVersion)]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return 0;
    }

    return [array.firstObject[LALTopicAttributes.uniqueWords] integerValue];
}


- (NSInteger)nextTopicForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion
{
    NSInteger numberofTopics = [self numberofTopicsInVersion:aVersion];
    return ++aTopic >= numberofTopics ? 0 : aTopic;
}

- (NSInteger)previousTopicForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion
{
    return aTopic > 0 ? --aTopic : [self numberofTopicsInVersion:aVersion] - 1;
}

- (NSArray *)cloudWordsForTopic:(NSInteger)aTopic includeRank:(BOOL)rank stopWords:(BOOL)stopWords inVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALWord entityName]];
    fetchRequest.resultType = NSDictionaryResultType;

    NSArray *fetchedAttributes = @[LALWordAttributes.title, LALWordAttributes.total];

    if (stopWords)
    {
        fetchedAttributes = [fetchedAttributes arrayByAddingObject:LALWordAttributes.stopword];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@", @"topic.order", @(aTopic), @"topic.versionOrder", @(aVersion)]];
    }
    else
    {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@ AND %K = %@ AND %K = 0", @"topic.order", @(aTopic), @"topic.versionOrder", @(aVersion), LALWordAttributes.stopword]];
    }

    if (rank)
    {
        fetchedAttributes = [fetchedAttributes arrayByAddingObject:LALWordAttributes.rank];
    }

    fetchRequest.propertiesToFetch = fetchedAttributes;

    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:LALWordAttributes.total ascending:NO],
                                       [[NSSortDescriptor alloc] initWithKey:LALWordAttributes.title ascending:YES],
                                       ]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return nil;
    }

    return array;
}

- (NSInteger)numberOfVersions
{
    return 5;
}

- (NSString *)titleForVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALVersion entityName]];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = @[LALVersionAttributes.title];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", LALVersionAttributes.order, @(aVersion)]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return nil;
    }

    return array.firstObject[LALVersionAttributes.title];
}

- (NSString *)subtitleForVersion:(NSInteger)aVersion
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[LALVersion entityName]];
    fetchRequest.resultType = NSDictionaryResultType;
    fetchRequest.propertiesToFetch = @[LALVersionAttributes.subtitle];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K = %@", LALVersionAttributes.order, @(aVersion)]];

    NSError *error = nil;

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (!array)
    {
        // Handle error
        return nil;
    }

    return array.firstObject[LALVersionAttributes.subtitle];
}

#pragma mark - Private methods

@end
