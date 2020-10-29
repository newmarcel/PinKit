//
//  PNKGetLastUpdateRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 05.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetLastUpdateRequestCompletionHandler)(NSDate *_Nullable lastUpdate, NSError *_Nullable error);

@interface PNKGetLastUpdateRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, nullable) PNKGetLastUpdateRequestCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
