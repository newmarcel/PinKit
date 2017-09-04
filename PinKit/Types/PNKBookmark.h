//
//  PNKBookmark.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A Pinboard bookmark.
 */
@interface PNKBookmark : NSObject
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly, nullable) NSString *descriptionText;
@property (nonatomic, readonly) NSString *hashText;
@property (nonatomic, readonly) NSURL *URL;
@property (nonatomic, readonly, nullable) NSString *meta;
@property (nonatomic, readonly) NSArray<NSString *> *tags;
@property (nonatomic, readonly) NSDate *createdAt;

@property (nonatomic, readonly, getter=isShared) BOOL shared;
@property (nonatomic, readonly, getter=isRead) BOOL read;

- (instancetype)init NS_UNAVAILABLE;

/**
 Creates a new bookmark with the given parameters.
 
 Defaults:
 - hashText: empty string
 - meta: nil
 - createdAt: now
 - isShared: NO
 - isRead: NO

 @param title The bookmark title
 @param URL A URL
 @param descriptionText An optional description
 @param tags An array of up to 100 tags
 @return A new instance
 */
- (instancetype)initWithTitle:(NSString *)title
                          URL:(NSURL *)URL
              descriptionText:(nullable NSString *)descriptionText
                         tags:(NSArray<NSString *> *)tags;

@end

@interface PNKBookmark (PNKDictionaryRepresentable)
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
@end

@interface PNKMutableBookmark : PNKBookmark
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

NS_ASSUME_NONNULL_END
