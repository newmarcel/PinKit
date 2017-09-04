//
//  PNKBookmark.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKBookmark.h"
#import "PNKPinboardBool.h"
#import "NSDateFormatter+PNKPinboard.h"

@interface PNKBookmark ()
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite, nullable) NSString *descriptionText;
@property (nonatomic, readwrite) NSString *hashText;
@property (nonatomic, readwrite) NSURL *URL;
@property (nonatomic, readwrite, nullable) NSString *meta;
@property (nonatomic, readwrite) NSArray<NSString *> *tags;
@property (nonatomic, readwrite) NSDate *createdAt;

@property (nonatomic, readwrite, getter=isShared) BOOL shared;
@property (nonatomic, readwrite, getter=isRead) BOOL read;

@end

@implementation PNKBookmark

- (instancetype)initWithTitle:(NSString *)title URL:(NSURL *)URL descriptionText:(NSString *)descriptionText tags:(NSArray<NSString *> *)tags
{
    NSParameterAssert(title);
    NSParameterAssert(URL);
    NSParameterAssert(tags);
    
    self = [super init];
    if(self)
    {
        self.title = title;
        self.descriptionText = descriptionText;
        self.hashText = @"";
        self.URL = URL;
        self.meta = nil;
        self.tags = tags;
        self.createdAt = [NSDate date];
        self.shared = NO;
        self.read = NO;
    }
    return self;
}

@end

@implementation PNKBookmark (PNKDictionaryRepresentable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSParameterAssert(dictionary);
    
    NSString *title = dictionary[@"description"];
    NSString *descr = dictionary[@"extended"];
    NSString *hashString = dictionary[@"hash"];
    NSURL *URL = [NSURL URLWithString:dictionary[@"href"]];
    NSString *meta = dictionary[@"meta"];
    NSArray<NSString *> *tags;
    if(dictionary[@"tags"] != nil && ![dictionary[@"tags"] isEqualToString:@""])
    {
        tags = [dictionary[@"tags"] componentsSeparatedByString:@" "];
    }
    else
    {
        tags = @[];
    }
    NSString *dateString = dictionary[@"time"];
    BOOL shared = PNKBoolFromPinboardBoolString(dictionary[@"shared"]);
    BOOL unread = PNKBoolFromPinboardBoolString(dictionary[@"toread"]);
    
    PNKBookmark *bookmark = [PNKBookmark new];
    bookmark.title = title;
    bookmark.descriptionText = descr;
    bookmark.hashText = hashString;
    bookmark.URL = URL;
    bookmark.meta = meta;
    bookmark.tags = tags;
    bookmark.createdAt = [NSDateFormatter.pnk_UTCDateFormatter dateFromString:dateString];
    bookmark.shared = shared;
    bookmark.read = !unread;
    
    return bookmark;
}

@end

@implementation PNKMutableBookmark
@dynamic title, descriptionText, hashText, URL, meta, tags, createdAt, shared, read;
@end
