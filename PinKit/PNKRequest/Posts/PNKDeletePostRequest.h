//
//  PNKDeletePostRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 09.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNKRequest.h"
#import "PNKBookmark.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKDeletePostCompletionHandler)(BOOL success, NSError *_Nullable error);

@interface PNKDeletePostRequest : PNKRequest <PNKRequest>
/**
 The bookmark to delete.
 
 Only the bookmark's URL property is required and the request
 will fail otherwise.
 */
@property (nonatomic, readonly) PNKBookmark *bookmark;
@property (copy, nonatomic, nullable) PNKDeletePostCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBookmark:(PNKBookmark *)bookmark NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
