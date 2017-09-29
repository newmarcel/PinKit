//
//  PNKBookmark.m
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKBookmark.h"
#import "PinKitMacros.h"
#import "PNKPinboardBool.h"
#import "NSDateFormatter+PNKPinboard.h"

static NSString * const PNKBookmarkTagsSeparator = @" ";

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

#pragma mark - Equality

- (BOOL)isEqual:(id)object
{
    PNKBookmark *rhs = (PNKBookmark *)object;
    if(self == rhs)
    {
        return YES;
    }
    if(!rhs || ![rhs isKindOfClass:[self class]])
    {
        return NO;
    }
    return [self isEqualToBookmark:rhs];
}

- (BOOL)isEqualToBookmark:(PNKBookmark *)bookmark
{
    NSParameterAssert(bookmark);
    
    return PNKIsEqual(self.title, bookmark.title)
        && PNKIsEqual(self.URL, bookmark.URL)
        && PNKIsEqual(self.descriptionText, bookmark.descriptionText);
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    PNKMutableBookmark *mutableCopy = [[PNKMutableBookmark alloc] initWithTitle:self.title
                                                                            URL:[self.URL copy]
                                                                descriptionText:self.descriptionText
                                                                           tags:[self.tags copy]
                                       ];
    mutableCopy.hashText = self.hashText;
    mutableCopy.meta = self.meta;
    mutableCopy.createdAt = [self.createdAt copy];
    mutableCopy.shared = [self isShared];
    mutableCopy.read = [self isRead];
    return mutableCopy;
}

@end

@implementation PNKBookmark (PNKDictionaryRepresentable)

#define kKeyTitle @"description"
#define kKeyDescription @"extended"
#define kKeyHash @"hash"
#define kKeyURL @"href"
#define kKeyMeta @"meta"
#define kKeyTags @"tags"
#define kKeyCreatedAt @"time"
#define kKeyShared @"shared"
#define kKeyUnread @"toread"

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    NSParameterAssert(dictionary);
    
    NSString *title = dictionary[kKeyTitle];
    NSString *descr = dictionary[kKeyDescription];
    NSString *hashString = dictionary[kKeyHash];
    NSURL *URL = [NSURL URLWithString:dictionary[kKeyURL]];
    NSString *meta = dictionary[kKeyMeta];
    NSArray<NSString *> *tags;
    if(dictionary[kKeyTags] != nil && ![dictionary[kKeyTags] isEqualToString:@""])
    {
        tags = [dictionary[kKeyTags] componentsSeparatedByString:PNKBookmarkTagsSeparator];
    }
    else
    {
        tags = @[];
    }
    NSString *dateString = dictionary[kKeyCreatedAt];
    BOOL shared = PNKBoolFromPinboardBoolString(dictionary[kKeyShared]);
    BOOL unread = PNKBoolFromPinboardBoolString(dictionary[kKeyUnread]);
    
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

- (NSDictionary<NSString *,id> *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[kKeyTitle] = self.title;
    if(self.descriptionText != nil) { dict[kKeyDescription] = self.descriptionText; }
    if(![self.hashText isEqualToString:@""]) { dict[kKeyHash] = self.hashText; }
    dict[kKeyURL] = self.URL.absoluteString;
    if(self.meta != nil) { dict[kKeyMeta] = self.meta; }
    dict[kKeyTags] = [self.tags componentsJoinedByString:PNKBookmarkTagsSeparator];
    dict[kKeyCreatedAt] = [NSDateFormatter.pnk_UTCDateFormatter stringFromDate:self.createdAt];
    dict[kKeyShared] = PNKPinboardBoolStringFromBool([self isShared]);
    dict[kKeyUnread] = PNKPinboardBoolStringFromBool(![self isRead]);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end

@implementation PNKMutableBookmark
@dynamic title, descriptionText, hashText, URL, meta, tags, createdAt, shared, read;
@end
