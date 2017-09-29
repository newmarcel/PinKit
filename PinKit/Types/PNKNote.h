//
//  PNKNote.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PNKNote : NSObject <NSCopying>
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *hashText;
@property (nonatomic, readonly) NSDate *createdAt;
@property (nonatomic, readonly) NSDate *updatedAt;
@property (nonatomic, readonly) NSUInteger length;
@property (nonatomic, readonly, nullable) NSString *text;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark Equality

/**
 Returns a Boolean value that indicates whether the receiver and the given note are equal.
 
 @param note A note to be compared to the receiver.
 @return YES if note is equal to the receiver.
 */
- (BOOL)isEqualToNote:(PNKNote *)note;

@end

@interface PNKNote (PNKDictionaryRepresentable)
@property (nonatomic, readonly) NSDictionary<NSString *, id> *dictionaryRepresentation;
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
@end

NS_ASSUME_NONNULL_END
