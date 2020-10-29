//
//  PNKGetTagsRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetTagsRequestCompletionHandler)(NSDictionary<NSString *, NSNumber *> *_Nullable tagsAndCounts, NSError *_Nullable error);

@interface PNKGetTagsRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, nullable) PNKGetTagsRequestCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
