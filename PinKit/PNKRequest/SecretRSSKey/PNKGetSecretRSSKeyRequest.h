//
//  PNKGetSecretRSSKeyRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNKRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetSecretRSSKeyRequestCompletionHandler)(NSString *secretRSSKey, NSError *_Nullable error);

@interface PNKGetSecretRSSKeyRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, nullable) PNKGetSecretRSSKeyRequestCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
