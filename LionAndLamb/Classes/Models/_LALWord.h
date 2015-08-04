// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LALWord.h instead.

@import CoreData;

extern const struct LALWordAttributes {
	__unsafe_unretained NSString *rank;
	__unsafe_unretained NSString *stopword;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *total;
} LALWordAttributes;

extern const struct LALWordRelationships {
	__unsafe_unretained NSString *topic;
} LALWordRelationships;

@class LALTopic;

@interface LALWordID : NSManagedObjectID {}
@end

@interface _LALWord : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LALWordID* objectID;

@property (nonatomic, strong) NSNumber* rank;

@property (atomic) int16_t rankValue;
- (int16_t)rankValue;
- (void)setRankValue:(int16_t)value_;

//- (BOOL)validateRank:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* stopword;

@property (atomic) BOOL stopwordValue;
- (BOOL)stopwordValue;
- (void)setStopwordValue:(BOOL)value_;

//- (BOOL)validateStopword:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* total;

@property (atomic) int32_t totalValue;
- (int32_t)totalValue;
- (void)setTotalValue:(int32_t)value_;

//- (BOOL)validateTotal:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LALTopic *topic;

//- (BOOL)validateTopic:(id*)value_ error:(NSError**)error_;

@end

@interface _LALWord (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveRank;
- (void)setPrimitiveRank:(NSNumber*)value;

- (int16_t)primitiveRankValue;
- (void)setPrimitiveRankValue:(int16_t)value_;

- (NSNumber*)primitiveStopword;
- (void)setPrimitiveStopword:(NSNumber*)value;

- (BOOL)primitiveStopwordValue;
- (void)setPrimitiveStopwordValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSNumber*)primitiveTotal;
- (void)setPrimitiveTotal:(NSNumber*)value;

- (int32_t)primitiveTotalValue;
- (void)setPrimitiveTotalValue:(int32_t)value_;

- (LALTopic*)primitiveTopic;
- (void)setPrimitiveTopic:(LALTopic*)value;

@end
