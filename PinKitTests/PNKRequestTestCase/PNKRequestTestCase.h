//
//  PNKRequestTestCase.h
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
@import PinKit;
@import RecorderSession;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const PNKTestUsername;
FOUNDATION_EXPORT NSString * const PNKTestPassword;
FOUNDATION_EXPORT NSString * const PNKTestToken;

@interface PNKRequestTestCase : XCTestCase
@property (nonatomic, nullable) PNKPinboardClient *client;
@property (nonatomic, readonly) RCNRecorderSession *recorderSession;

- (void)insertCassetteNamed:(NSString *)name;

- (PNKBookmark *)bookmark;
@end

NS_ASSUME_NONNULL_END
