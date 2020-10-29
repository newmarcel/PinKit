//
//  PNKGetNotesRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKGetNotesRequest.h"
#import "PNKPinboardBool.h"
#import "NSArray+PNKMap.h"

@implementation PNKGetNotesRequest

- (NSString *)endpoint
{
    return @"/v1/notes/list";
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    NSArray *notes = nil;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *responseObject = (NSDictionary *)object;
        NSNumber *notesCount = responseObject[@"count"];
        NSArray *objects = responseObject[@"notes"];
        notes = [objects pnk_flatMap:^id _Nonnull(id  _Nonnull element) {
            return [[PNKNote alloc] initWithDictionary:element];
        }];
        NSAssert(notes.count == notesCount.unsignedIntegerValue, @"The notes count and the actual notes must match.");
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(notes, error);
        });
    }
}

@end
