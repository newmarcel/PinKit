//
//  PNKRenameTagRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKRequest.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PNKRenameTagRequestCompletionHandler)(BOOL success, NSError *_Nullable error);

@interface PNKRenameTagRequest : PNKRequest <PNKRequest>
@property (copy, nonatomic, readonly) NSString *fromName;
@property (copy, nonatomic, readonly) NSString *toName;
@property (copy, nonatomic, nullable) PNKRenameTagRequestCompletionHandler completionHandler;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFromName:(NSString *)fromName toName:(NSString *)toName NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
