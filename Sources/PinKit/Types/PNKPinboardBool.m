//
//  PNKPinboardBool.m
//  PinKit
//
//  Created by Marcel Dierkes on 03.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKPinboardBool.h"

BOOL PNKBoolFromPinboardBoolString(NSString *pinboardBoolString)
{
    if([pinboardBoolString isEqualToString:@"yes"])
    {
        return YES;
    }
    return NO;
}

NSString *PNKPinboardBoolStringFromBool(BOOL booleanValue)
{
    if(booleanValue == YES)
    {
        return @"yes";
    }
    return @"no";
}
