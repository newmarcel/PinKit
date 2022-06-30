//
//  PNKGetLastUpdateRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 05.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <PinKit/PNKGetLastUpdateRequest.h>
#import "../PNKDefines.h"
#import "../Extensions/NSDateFormatter+PNKPinboard.h"

@implementation PNKGetLastUpdateRequest

- (NSString *)endpoint
{
    return @"/v1/posts/update";
}

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSDate *lastUpdate = nil;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *updateTime = (NSDictionary *)object;
        NSString *lastUpdateString = updateTime[@"update_time"];
        
        NSDateFormatter *df = NSDateFormatter.pnk_UTCDateFormatter;
        lastUpdate = [df dateFromString:lastUpdateString];
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(lastUpdate, error);
        });
    }
}


@end
