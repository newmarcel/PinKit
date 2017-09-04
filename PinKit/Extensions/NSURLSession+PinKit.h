//
//  NSURLSession+PinKit.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSession (PinKit)
@property (class, copy, nonatomic, readonly) NSURLSession *pinboardURLSession;

@property (class, nonatomic, readonly) NSURLSessionConfiguration *pinboardSessionConfiguration;
@property (class, copy, nonatomic, readonly) NSDictionary<NSString *, NSString *> *pnk_defaultHTTPHeaders;

@end

NS_ASSUME_NONNULL_END
