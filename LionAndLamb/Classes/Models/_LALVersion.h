// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LALVersion.h instead.

@import CoreData;

extern const struct LALVersionAttributes {
	__unsafe_unretained NSString *order;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *title;
} LALVersionAttributes;

extern const struct LALVersionRelationships {
	__unsafe_unretained NSString *topics;
} LALVersionRelationships;

@class LALTopic;

@interface LALVersionID : NSManagedObjectID {}
@end

@interface _LALVersion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LALVersionID* objectID;

@property (nonatomic, strong) NSNumber* order;

@property (atomic) uint16_t orderValue;
- (uint16_t)orderValue;
- (void)setOrderValue:(uint16_t)value_;

//- (BOOL)validateOrder:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* subtitle;

//- (BOOL)validateSubtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *topics;

- (NSMutableSet*)topicsSet;

@end

@interface _LALVersion (TopicsCoreDataGeneratedAccessors)
- (void)addTopics:(NSSet*)value_;
- (void)removeTopics:(NSSet*)value_;
- (void)addTopicsObject:(LALTopic*)value_;
- (void)removeTopicsObject:(LALTopic*)value_;

@end

@interface _LALVersion (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveOrder;
- (void)setPrimitiveOrder:(NSNumber*)value;

- (uint16_t)primitiveOrderValue;
- (void)setPrimitiveOrderValue:(uint16_t)value_;

- (NSString*)primitiveSubtitle;
- (void)setPrimitiveSubtitle:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveTopics;
- (void)setPrimitiveTopics:(NSMutableSet*)value;

@end
