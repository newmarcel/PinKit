//
//  NSURLSession+PinKit.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "NSURLSession+PinKit.h"
#import "../PNKDefines.h"
#import <PinKit/PNKRequest.h>

@implementation NSURLSession (PinKit)

+ (instancetype)pinboardURLSession
{
    return [self sessionWithConfiguration:[self pinboardSessionConfiguration]
                                 delegate:nil
                            delegateQueue:nil];
}

+ (NSURLSessionConfiguration *)pinboardSessionConfiguration
{
    static dispatch_once_t once;
    static NSURLSessionConfiguration *config;
    dispatch_once(&once, ^{
        config = NSURLSessionConfiguration.defaultSessionConfiguration;
        config.timeoutIntervalForRequest = 30.0;
        config.HTTPAdditionalHeaders = self.pnk_defaultHTTPHeaders;
        config.HTTPMaximumConnectionsPerHost = 2;
    });
    return config;
}

#pragma mark - Default HTTP Headers

+ (nonnull NSDictionary<NSString *, NSString *> *) pnk_defaultHTTPHeaders
{
    return @{
             @"Accept-Encoding": @"gzip;q=1.0,compress;q=0.5",
             @"Accept-Language": @"en",
             @"User-Agent": @"PinKit/1" // TODO
             };
}

@end
