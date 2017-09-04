//
//  NSDateFormatter+PNKPinboard.m
//  PinKit
//
//  Created by Marcel Dierkes on 03.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "NSDateFormatter+PNKPinboard.h"

@implementation NSDateFormatter (PNKPinboard)

+ (NSDateFormatter *)pnk_UTCDateFormatter
{
    static dispatch_once_t once;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&once, ^{
        dateFormatter = [[self alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        dateFormatter.dateFormat = @"YYYY-MM-dd'T'HH:mm:ss'Z'";
    });
    return dateFormatter;
}

+ (NSDateFormatter *)pnk_shortUTCDateFormatter
{
    static dispatch_once_t once;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&once, ^{
        dateFormatter = [[self alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        dateFormatter.dateFormat = @"YYYY-MM-dd";
    });
    return dateFormatter;
}

+ (NSDateFormatter *)pnk_notesDateFormatter
{
    static dispatch_once_t once;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&once, ^{
        dateFormatter = [[self alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    });
    return dateFormatter;
}

@end
