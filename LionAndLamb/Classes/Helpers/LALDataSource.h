//
//  LALDataSource.h
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

@import Foundation;

@interface LALDataSource : NSObject
/**
 Returns the sharedDataSource singleton
 
 @return The LALDataSource singleton
 */
+ (instancetype)sharedDataSource;

/**
 Returns the number of topics for a specified version
 
 @param aVersion The numeric value of a version

 @return The number of topics for a version
 */
- (NSInteger)numberofTopicsInVersion:(NSInteger)aVersion;
/**
 Returns the title for a specified topic
 
 @param aTopic The numeric value of a topic
 
 @param aVersion The numeric value of a version

 @return The title for the given topic
 */
- (NSString *)titleForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion;
/**
 Returns the subtitle for a specified topic

 @param aTopic The numeric value of a topic

 @param aVersion The numeric value of a version

 @return The subtitle for the given topic
 */
- (NSString *)subtitleForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion;
/**
 Returns the number of total words in a specified topic

 @param aTopic The numeric value of a topic

 @param aVersion The numeric value of a version

 @return The number of total words in the given topic
 */
- (NSInteger)totalWordsForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion;
/**
 Returns the number of unique words in a specified topic

 @param aTopic The numeric value of a topic

 @param aVersion The numeric value of a version

 @return The number of unique words in the given topic
 */
- (NSInteger)uniqueWordsForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion;

/**
 Returns the successor of a specified topic

 @param aTopic The numeric value of a topic

 @param aVersion The numeric value of a version

 @return The topic after the given topic
 
 @note Successor of last topic wraps around to first topic
 */
- (NSInteger)nextTopicForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion;
/**
 Returns the predecessor of a specified topic

 @param aTopic The numeric value of a topic

 @param aVersion The numeric value of a version

 @return The topic before the given topic

 @note Predecessor of first topic wraps around to last topic
 */
- (NSInteger)previousTopicForTopic:(NSInteger)aTopic inVersion:(NSInteger)aVersion;

/**
 Returns an array of words in a specified topic

 @param aTopic The numeric value of a topic
 
 @param aVersion The numeric value of a version

 @param rank A boolean indicating whether or not the results include a word's rank

 @param stopWords A boolean indicating whether or not the results include stopwords

 @return The most frequent words inthe given topic
 */
- (NSArray *)cloudWordsForTopic:(NSInteger)aTopic includeRank:(BOOL)rank stopWords:(BOOL)stopWords inVersion:(NSInteger)aVersion;

/**
 Returns the number of versions

 @return The number of versions
 */
- (NSInteger)numberOfVersions;

/**
 Returns the title for a specified version

 @param aVersion The numeric value of a version

 @return The title for the given version
 */
- (NSString *)titleForVersion:(NSInteger)aVersion;
/**
 Returns the subtitle for a specified version

 @param aVersion The numeric value of a version

 @return The subtitle for the given version
 */
- (NSString *)subtitleForVersion:(NSInteger)aVersion;

@end
