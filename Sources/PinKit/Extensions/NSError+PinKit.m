//
//  NSError+PinKit.m
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "NSError+PinKit.h"

NSErrorDomain PinKitErrorDomain = @"info.marcel-dierkes.PinKit.ErrorDomain";

@implementation NSError (PinKit)

+ (instancetype)pinKitErrorWithCode:(NSInteger)code
{
    return [self pinKitErrorWithCode:code userInfo:nil];
}

+ (instancetype)pinKitErrorWithCode:(NSInteger)code userInfo:(nullable NSDictionary *)userInfo
{
    return [[NSError alloc] initWithDomain:PinKitErrorDomain code:code userInfo:userInfo];
}

@end
