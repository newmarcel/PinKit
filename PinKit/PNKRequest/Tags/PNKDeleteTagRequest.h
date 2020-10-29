//
//  PNKDeleteTagRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKDeleteTagRequestCompletionHandler)(BOOL success, NSError *_Nullable error);

@interface PNKDeleteTagRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, readonly) NSString *tagName;
@property (copy, nonatomic, nullable) PNKDeleteTagRequestCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTagName:(NSString *)tagName NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
