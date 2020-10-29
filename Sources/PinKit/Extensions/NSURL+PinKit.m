//
//  NSURL+PinKit.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "NSURL+PinKit.h"

@implementation NSURL (PinKit)

- (instancetype)pnk_URLByAppendingQueryItems:(NSArray<NSURLQueryItem *> *)queryItems
{
    NSParameterAssert(queryItems);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    NSMutableArray *allQueryItems = [NSMutableArray arrayWithArray:components.queryItems];
    [allQueryItems addObjectsFromArray:queryItems];
    components.queryItems = allQueryItems;
    return components.URL;
}

@end
