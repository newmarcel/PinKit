//
//  PNKGetNoteRequest.m
//  PinKit
//
//  Created by Marcel Dierkes on 10.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKGetNoteRequest.h"
#import "PNKPinboardBool.h"
#import "NSArray+PNKMap.h"

@interface PNKGetNoteRequest ()
@property (copy, nonatomic, readwrite) NSString *identifier;
@end

@implementation PNKGetNoteRequest

- (NSString *)endpoint
{
    return [NSString stringWithFormat:@"/v1/notes/%@", self.identifier];
}

#pragma mark - Life Cycle

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    NSParameterAssert(identifier);
    
    self = [super init];
    if(self)
    {
        self.identifier = identifier;
    }
    return self;
}

#pragma mark - PNKRequest

- (void)handleCompletionWithJSONObject:(id)object response:(NSHTTPURLResponse *)response error:(NSError *)error
{
    PNKNote *note = nil;
    if(error == nil && [object isKindOfClass:[NSDictionary class]])
    {
        note = [[PNKNote alloc] initWithDictionary:object];
    }
    
    if(self.completionHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completionHandler(note, error);
        });
    }
}

@end
