// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LALVersion.m instead.

#import "_LALVersion.h"

const struct LALVersionAttributes LALVersionAttributes = {
	.order = @"order",
	.subtitle = @"subtitle",
	.title = @"title",
};

const struct LALVersionRelationships LALVersionRelationships = {
	.topics = @"topics",
};

@implementation LALVersionID
@end

@implementation _LALVersion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LALVersion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LALVersion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LALVersion" inManagedObjectContext:moc_];
}

- (LALVersionID*)objectID {
	return (LALVersionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"orderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"order"];
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

@dynamic topics;

- (NSMutableSet*)topicsSet {
	[self willAccessValueForKey:@"topics"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"topics"];

	[self didAccessValueForKey:@"topics"];
	return result;
}

@end

