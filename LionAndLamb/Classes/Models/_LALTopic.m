// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LALTopic.m instead.

#import "_LALTopic.h"

const struct LALTopicAttributes LALTopicAttributes = {
	.order = @"order",
	.subtitle = @"subtitle",
	.title = @"title",
	.totalWords = @"totalWords",
	.uniqueWords = @"uniqueWords",
	.versionOrder = @"versionOrder",
};

const struct LALTopicRelationships LALTopicRelationships = {
	.nextTopic = @"nextTopic",
	.previousTopic = @"previousTopic",
	.version = @"version",
	.words = @"words",
};

@implementation LALTopicID
@end

@implementation _LALTopic

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LALTopic" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LALTopic";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LALTopic" inManagedObjectContext:moc_];
}

- (LALTopicID*)objectID {
	return (LALTopicID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"orderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"order"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"totalWordsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"totalWords"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"uniqueWordsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uniqueWords"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"versionOrderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"versionOrder"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic order;

- (uint16_t)orderValue {
	NSNumber *result = [self order];
	return [result unsignedShortValue];
}

- (void)setOrderValue:(uint16_t)value_ {
	[self setOrder:@(value_)];
}

- (uint16_t)primitiveOrderValue {
	NSNumber *result = [self primitiveOrder];
	return [result unsignedShortValue];
}

- (void)setPrimitiveOrderValue:(uint16_t)value_ {
	[self setPrimitiveOrder:@(value_)];
}

@dynamic subtitle;

@dynamic title;

@dynamic totalWords;

- (int32_t)totalWordsValue {
	NSNumber *result = [self totalWords];
	return [result intValue];
}

- (void)setTotalWordsValue:(int32_t)value_ {
	[self setTotalWords:@(value_)];
}

- (int32_t)primitiveTotalWordsValue {
	NSNumber *result = [self primitiveTotalWords];
	return [result intValue];
}

- (void)setPrimitiveTotalWordsValue:(int32_t)value_ {
	[self setPrimitiveTotalWords:@(value_)];
}

@dynamic uniqueWords;

- (int16_t)uniqueWordsValue {
	NSNumber *result = [self uniqueWords];
	return [result shortValue];
}

- (void)setUniqueWordsValue:(int16_t)value_ {
	[self setUniqueWords:@(value_)];
}

- (int16_t)primitiveUniqueWordsValue {
	NSNumber *result = [self primitiveUniqueWords];
	return [result shortValue];
}

- (void)setPrimitiveUniqueWordsValue:(int16_t)value_ {
	[self setPrimitiveUniqueWords:@(value_)];
}

@dynamic versionOrder;

- (uint16_t)versionOrderValue {
	NSNumber *result = [self versionOrder];
	return [result unsignedShortValue];
}

- (void)setVersionOrderValue:(uint16_t)value_ {
	[self setVersionOrder:@(value_)];
}

- (uint16_t)primitiveVersionOrderValue {
	NSNumber *result = [self primitiveVersionOrder];
	return [result unsignedShortValue];
}

- (void)setPrimitiveVersionOrderValue:(uint16_t)value_ {
	[self setPrimitiveVersionOrder:@(value_)];
}

@dynamic nextTopic;

@dynamic previousTopic;

@dynamic version;

@dynamic words;

- (NSMutableSet*)wordsSet {
	[self willAccessValueForKey:@"words"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"words"];

	[self didAccessValueForKey:@"words"];
	return result;
}

@end

