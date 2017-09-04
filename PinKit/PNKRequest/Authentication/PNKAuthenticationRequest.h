//
//  PNKAuthenticationRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNKRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKAuthenticationRequestCompletionHandler)(NSString *token, NSError *_Nullable error);

@interface PNKAuthenticationRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *password;
@property (copy, nonatomic) PNKAuthenticationRequestCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
