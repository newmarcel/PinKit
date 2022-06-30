//
//  PNKGetSecretRSSKeyRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 11.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKGetSecretRSSKeyRequest.h>

@implementation PNKGetSecretRSSKeyRequest

- (NSString *)endpoint
{
    return @"/v1/user/secret";
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSString *secretRSSKey = nil;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary *)object;
        if([dict[@"result"] isKindOfClass:[NSString class]])
        {
            secretRSSKey = (NSString *)dict[@"result"];
        }
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(secretRSSKey, error);
        });
    }
}

@end
