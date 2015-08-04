// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LALWord.m instead.

#import "_LALWord.h"

const struct LALWordAttributes LALWordAttributes = {
	.rank = @"rank",
	.stopword = @"stopword",
	.title = @"title",
	.total = @"total",
};

const struct LALWordRelationships LALWordRelationships = {
	.topic = @"topic",
};

@implementation LALWordID
@end

@implementation _LALWord

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LALWord" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LALWord";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LALWord" inManagedObjectContext:moc_];
}

- (LALWordID*)objectID {
	return (LALWordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"rankValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rank"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"stopwordValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stopword"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"totalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"total"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic rank;

- (int16_t)rankValue {
	NSNumber *result = [self rank];
	return [result shortValue];
}

- (void)setRankValue:(int16_t)value_ {
	[self setRank:@(value_)];
}

- (int16_t)primitiveRankValue {
	NSNumber *result = [self primitiveRank];
	return [result shortValue];
}

- (void)setPrimitiveRankValue:(int16_t)value_ {
	[self setPrimitiveRank:@(value_)];
}

@dynamic stopword;

- (BOOL)stopwordValue {
	NSNumber *result = [self stopword];
	return [result boolValue];
}

- (void)setStopwordValue:(BOOL)value_ {
	[self setStopword:@(value_)];
}

- (BOOL)primitiveStopwordValue {
	NSNumber *result = [self primitiveStopword];
	return [result boolValue];
}

- (void)setPrimitiveStopwordValue:(BOOL)value_ {
	[self setPrimitiveStopword:@(value_)];
}

@dynamic title;

@dynamic total;

- (int32_t)totalValue {
	NSNumber *result = [self total];
	return [result intValue];
}

- (void)setTotalValue:(int32_t)value_ {
	[self setTotal:@(value_)];
}

- (int32_t)primitiveTotalValue {
	NSNumber *result = [self primitiveTotal];
	return [result intValue];
}

- (void)setPrimitiveTotalValue:(int32_t)value_ {
	[self setPrimitiveTotal:@(value_)];
}

@dynamic topic;

@end

