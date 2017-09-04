//
//  PNKGetRecentPostsRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 06.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNKRequest.h"
#import "PNKBookmark.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetRecentPostsRequestCompletionHandler)(NSArray<PNKBookmark *> *_Nullable bookmarks, NSError *_Nullable error);

@interface PNKGetRecentPostsRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, nullable) NSArray<NSString *> *tags;
@property (nonatomic) NSUInteger resultsCount; // = 15
@property (copy, nonatomic, nullable) PNKGetRecentPostsRequestCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
