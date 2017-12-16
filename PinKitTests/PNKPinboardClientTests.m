//
//  PNKPinboardClientTests.m
//  PinKit
//
//  Created by Marcel Dierkes on 16.04.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

@import XCTest;
@import PinKit;
@import RecorderSession;
#import "PNKRequestTestCase.h"
#import "NSURLSession+PinKit.h"

@interface PNKPinboardClientTests : XCTestCase
@property (nonatomic) RCNRecorderSession *recorderSession;
@property (nonatomic) PNKPinboardClient *client;
@end

@implementation PNKPinboardClientTests

- (void)setUp
{
    [super setUp];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]].cassetteBundle;
    self.recorderSession = [[RCNRecorderSession alloc]
                            initWithBackingSession:NSURLSession.pinboardURLSession cassetteBundle:bundle];
    self.client = [[PNKPinboardClient alloc] initWithSession:self.recorderSession];
}

- (void)tearDown
{
    self.recorderSession = nil;
    self.client = nil;
    [super tearDown];
}

- (void)testUsernameTokenAndIsAuthenticated
{
    NSString *username = @"token";
    NSString *token = @"username";
    
    XCTAssertFalse([self.client isAuthenticated]);
    
    [self.client setUsername:username token:token];
    XCTAssert([username isEqualToString:self.client.username]);
    XCTAssert([token isEqualToString:self.client.token]);
    XCTAssertTrue([self.client isAuthenticated]);
}

- (void)testResetCredentials
{
    NSString *username = @"token";
    NSString *token = @"username";
    [self.client setUsername:username token:token];
    XCTAssertTrue([self.client isAuthenticated]);
    
    [self.client resetCredentials];
    XCTAssertFalse([self.client isAuthenticated]);
    XCTAssertNil(self.client.username);
    XCTAssertNil(self.client.token);
}

- (void)testAuthenticationToken
{
    XCTAssertNil([self.client performSelector:@selector(authenticationToken)]);  // test the private implementation
    
    NSString *username = @"token";
    NSString *token = @"username";
    [self.client setUsername:username token:token];
    
    NSString *authToken = [self.client performSelector:@selector(authenticationToken)];  // test the private implementation
    NSString *expectedAuthToken = [NSString stringWithFormat:@"%@:%@", username, token];
    XCTAssert([expectedAuthToken isEqualToString:authToken]);
}

- (void)testAuthenticate
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testAuthenticate"];
    [self.recorderSession insertCassetteWithName:@"Authentication/AuthenticationRequest"];
    
    NSString *username = PNKTestUsername;
    NSString *password = PNKTestPassword;
    NSString *expectedToken = PNKTestToken;
    
    [self.client authenticateWithUsername:username password:password completion:^(BOOL success, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertTrue(success);
        
        XCTAssert([expectedToken isEqualToString:self.client.token]);
        XCTAssert([username isEqualToString:self.client.username]);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:5.0];
}

@end
