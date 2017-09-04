//
//  PNKRequestTestCase.m
//  PinKit
//
//  Created by Marcel Dierkes on 08.03.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import "PNKRequestTestCase.h"
#import "NSURLSession+PinKit.h"

#define IS_RECORDING 0
#if IS_RECORDING
// Actual Pinboard credentials for recording new cassettes.
NSString * const PNKTestUsername = @"<REAL USERNAME>";
NSString * const PNKTestPassword = @"<REAL PASSWORD>";
NSString * const PNKTestToken = @"<REAL TOKEN>";
#else
// Fake Pinboard credentials for replaying cassettes.
NSString * const PNKTestUsername = @"rachel.rosen";
NSString * const PNKTestPassword = @"nexus-6";
NSString * const PNKTestToken = @"662ea47bdf3d2563f047";
#endif

@implementation PNKRequestTestCase

- (RCNRecorderSession *)recorderSession
{
    return (RCNRecorderSession *)self.client.session;
}

- (void)insertCassetteNamed:(NSString *)name
{
    [self.recorderSession insertCassetteWithName:name];
}

- (void)setUp
{
    [super setUp];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]].cassetteBundle;
    RCNRecorderSession *session = [[RCNRecorderSession alloc]
                                   initWithBackingSession:NSURLSession.pinboardURLSession cassetteBundle:bundle];
    session.validationOptions = RCNValidationOptionDefault ^ RCNValidationOptionQuery;
    
    PNKPinboardClient *client = [[PNKPinboardClient alloc] initWithSession:session];
    
    NSString *username = PNKTestUsername;
    NSString *token = PNKTestToken;
    [client setUsername:username token:token];
    self.client = client;
}

- (void)tearDown
{
    self.client = nil;
}


- (PNKBookmark *)bookmark
{
    return [[PNKBookmark alloc] initWithTitle:@"XCTest"
                                          URL:[NSURL URLWithString:@"https://developer.apple.com/reference/xctest"]
                              descriptionText:@"Create and run unit tests, performance tests, and UI tests for your Xcode project."
                                         tags:@[@"test", @"xctest"]
            ];
}

@end
