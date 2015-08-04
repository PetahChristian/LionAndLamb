// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LALTopic.h instead.

@import CoreData;

extern const struct LALTopicAttributes {
	__unsafe_unretained NSString *order;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *totalWords;
	__unsafe_unretained NSString *uniqueWords;
	__unsafe_unretained NSString *versionOrder;
} LALTopicAttributes;

extern const struct LALTopicRelationships {
	__unsafe_unretained NSString *nextTopic;
	__unsafe_unretained NSString *previousTopic;
	__unsafe_unretained NSString *version;
	__unsafe_unretained NSString *words;
} LALTopicRelationships;

@class LALTopic;
@class LALTopic;
@class LALVersion;
@class LALWord;

@interface LALTopicID : NSManagedObjectID {}
@end

@interface _LALTopic : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LALTopicID* objectID;

@property (nonatomic, strong) NSNumber* order;

@property (atomic) uint16_t orderValue;
- (uint16_t)orderValue;
- (void)setOrderValue:(uint16_t)value_;

//- (BOOL)validateOrder:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* subtitle;

//- (BOOL)validateSubtitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* totalWords;

@property (atomic) int32_t totalWordsValue;
- (int32_t)totalWordsValue;
- (void)setTotalWordsValue:(int32_t)value_;

//- (BOOL)validateTotalWords:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* uniqueWords;

@property (atomic) int16_t uniqueWordsValue;
- (int16_t)uniqueWordsValue;
- (void)setUniqueWordsValue:(int16_t)value_;

//- (BOOL)validateUniqueWords:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* versionOrder;

@property (atomic) uint16_t versionOrderValue;
- (uint16_t)versionOrderValue;
- (void)setVersionOrderValue:(uint16_t)value_;

//- (BOOL)validateVersionOrder:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LALTopic *nextTopic;

//- (BOOL)validateNextTopic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LALTopic *previousTopic;

//- (BOOL)validatePreviousTopic:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LALVersion *version;

//- (BOOL)validateVersion:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *words;

- (NSMutableSet*)wordsSet;

@end

@interface _LALTopic (WordsCoreDataGeneratedAccessors)
- (void)addWords:(NSSet*)value_;
- (void)removeWords:(NSSet*)value_;
- (void)addWordsObject:(LALWord*)value_;
- (void)removeWordsObject:(LALWord*)value_;

@end

@interface _LALTopic (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveOrder;
- (void)setPrimitiveOrder:(NSNumber*)value;

- (uint16_t)primitiveOrderValue;
- (void)setPrimitiveOrderValue:(uint16_t)value_;

- (NSString*)primitiveSubtitle;
- (void)setPrimitiveSubtitle:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSNumber*)primitiveTotalWords;
- (void)setPrimitiveTotalWords:(NSNumber*)value;

- (int32_t)primitiveTotalWordsValue;
- (void)setPrimitiveTotalWordsValue:(int32_t)value_;

- (NSNumber*)primitiveUniqueWords;
- (void)setPrimitiveUniqueWords:(NSNumber*)value;

- (int16_t)primitiveUniqueWordsValue;
- (void)setPrimitiveUniqueWordsValue:(int16_t)value_;

- (NSNumber*)primitiveVersionOrder;
- (void)setPrimitiveVersionOrder:(NSNumber*)value;

- (uint16_t)primitiveVersionOrderValue;
- (void)setPrimitiveVersionOrderValue:(uint16_t)value_;

- (LALTopic*)primitiveNextTopic;
- (void)setPrimitiveNextTopic:(LALTopic*)value;

- (LALTopic*)primitivePreviousTopic;
- (void)setPrimitivePreviousTopic:(LALTopic*)value;

- (LALVersion*)primitiveVersion;
- (void)setPrimitiveVersion:(LALVersion*)value;

- (NSMutableSet*)primitiveWords;
- (void)setPrimitiveWords:(NSMutableSet*)value;

@end
