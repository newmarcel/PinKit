//
//  PNKDeleteTagRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKDeleteTagRequest.h>
#import "../../Types/PNKPinboardBool.h"
#import "../../Extensions/NSDateFormatter+PNKPinboard.h"
#import <PinKit/NSError+PinKit.h>

@interface PNKDeleteTagRequest ()
@property (copy, nonatomic, readwrite) NSString *tagName;
@end

@implementation PNKDeleteTagRequest

- (NSString *)endpoint
{
    return @"/v1/tags/delete";
}

#pragma mark - Life Cycle

- (instancetype)initWithTagName:(NSString *)tagName
{
    NSParameterAssert(tagName);
    
    self = [super init];
    if(self)
    {
        self.tagName = tagName;
    }
    return self;
}

#pragma mark - Parameters

- (NSDictionary<NSString *, NSString *> *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super parameters]];
    parameters[@"tag"] = self.tagName;
    
    return [NSDictionary dictionaryWithDictionary:parameters];
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    BOOL success = NO;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        NSString *resultCode = ((NSDictionary *)object)[@"result"];
        if(resultCode != nil)
        {
            if([resultCode.lowercaseString isEqualToString:@"done"])
            {
                success = YES;
            }
            else
            {
                NSError *unknownError = [NSError pinKitErrorWithCode:PNKErrorUnknown userInfo:@{@"reason": resultCode}];
                [self completeWithSuccess:success error:unknownError];
                return;
            }
        }
    }
    
    [self completeWithSuccess:success error:error];
}

- (void)completeWithSuccess:(BOOL)success error:(NSError *)error
{
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(success, error);
        });
    }
}

@end
