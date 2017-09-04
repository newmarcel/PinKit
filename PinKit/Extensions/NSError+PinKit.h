//
//  NSError+PinKit.h
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSErrorDomain PinKitErrorDomain;

typedef NS_ENUM(NSUInteger, PNKError) {
    PNKErrorUnknown = -1,
};

@interface NSError (PinKit)

+ (instancetype)pinKitErrorWithCode:(NSInteger)code;
+ (instancetype)pinKitErrorWithCode:(NSInteger)code userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
