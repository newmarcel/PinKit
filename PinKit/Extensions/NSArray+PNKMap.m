//
//  NSArray+PNKMap.m
//  Sienna
//
//  Created by Marcel Dierkes on 24.12.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import "NSArray+PNKMap.h"

@implementation NSArray (PNKMap)

- (NSArray *)pnk_map:(id(^)(id element))transform
{
    NSArray *collection = self;
    NSMutableArray *results = [NSMutableArray new];
    for(id element in collection)
    {
        id transformed = transform(element);
        if(transformed)
        {
            [results addObject:transformed];
        }
        else
        {
            [results addObject:[NSNull null]];
        }
    }
    return [NSArray arrayWithArray:results];
}

- (NSArray *)pnk_flatMap:(id(^)(id element))transform
{
    NSArray *collection = self;
    NSMutableArray *results = [NSMutableArray new];
    for(id element in collection)
    {
        id transformed = transform(element);
        if(transformed && ![transformed isKindOfClass:[NSNull class]])
        {
            [results addObject:transformed];
        }
    }
    return [NSArray arrayWithArray:results];
}

@end
