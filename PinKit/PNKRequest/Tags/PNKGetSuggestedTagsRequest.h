//
//  PNKGetSuggestedTagsRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKGetSuggestedTagsRequestCompletionHandler)(NSArray<NSString *> *popularTags, NSArray<NSString *> *recommendedTags, NSError *_Nullable error);

@interface PNKGetSuggestedTagsRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, readonly) NSURL *URL;
@property (copy, nonatomic, nullable) PNKGetSuggestedTagsRequestCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithURL:(NSURL *)URL NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
