//
//  PNKGetAllPostsRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>
#import <PinKit/PNKBookmark.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetAllPostsRequestCompletionHandler)(NSArray<PNKBookmark *> *_Nullable bookmarks, NSError *_Nullable error);

@interface PNKGetAllPostsRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, nullable) NSArray<NSString *> *tags;
@property (nonatomic) NSUInteger offset; // = 0
@property (nonatomic) NSUInteger resultsCount; // = 25
//@property (nonatomic, getter=isFetchMetaDataEnabled) BOOL fetchMetaDataEnabled; // FIXME: Doesn't work
@property (copy, nonatomic, nullable) PNKGetAllPostsRequestCompletionHandler completionHandler;

@end

NS_ASSUME_NONNULL_END
