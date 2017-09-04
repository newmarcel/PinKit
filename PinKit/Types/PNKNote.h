//
//  PNKNote.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PNKNote : NSObject
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *hashText;
@property (nonatomic, readonly) NSDate *createdAt;
@property (nonatomic, readonly) NSDate *updatedAt;
@property (nonatomic, readonly) NSUInteger length;
@property (nonatomic, readonly, nullable) NSString *text;

- (instancetype)init NS_UNAVAILABLE;

@end

@interface PNKNote (PNKDictionaryRepresentable)
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
@end

NS_ASSUME_NONNULL_END
