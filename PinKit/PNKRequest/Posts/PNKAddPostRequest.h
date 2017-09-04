//
//  PNKAddPostRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNKRequest.h"
#import "PNKBookmark.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKAddPostCompletionHandler)(BOOL success, NSError *_Nullable error);

@interface PNKAddPostRequest : PNKRequest <PNKRequest>
/**
 The bookmark to add.
 
 The bookmark's URL and title properties are required and the request
 will fail otherwise.
 */
@property (nonatomic, readonly) PNKBookmark *bookmark;
@property (nonatomic) BOOL shouldReplaceExisting; // defaults to YES
@property (copy, nonatomic, nullable) PNKAddPostCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBookmark:(PNKBookmark *)bookmark NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
