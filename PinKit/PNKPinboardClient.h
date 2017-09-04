//
//  PNKPinboardClient.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PNKRequest;

/**
 An API client for the Pinboard API.
 */
@interface PNKPinboardClient : NSObject

/**
 The NSURLSession used for API requests.
 */
@property (nonatomic, readonly) NSURLSession *session;

/**
 A Pinboard username. This property is accessible after a successful
 `-authenticateWithUsername:password:completion:` request.
 */
@property (copy, nonatomic, readonly, nullable) NSString *username;

/**
 A Pinboard auth token. This property is accessible after a successful
 `-authenticateWithUsername:password:completion:` request.
 */
@property (copy, nonatomic, readonly, nullable) NSString *token;

/**
 Returns YES if `username` and `token` are set.
 */
@property (nonatomic, readonly, getter=isAuthenticated) BOOL authenticated;

/**
 A convenience initializer with a fully configured NSURLSession for requests.
 
 This is in general the preferred initializer.
 
 @return A new instance.
 */
- (instancetype)init;

/**
 The designated initializer.
 
 In general `-init` should be the preferred initializer because it provides
 a customized `NSURLSession` instance.

 @param session An NSURLSession instance.
 @return A new instance.
 */
- (instancetype)initWithSession:(NSURLSession *)session NS_DESIGNATED_INITIALIZER;

/**
 Performs an authentication request and propagates the username and token
 properties when the request was successful.
 
 It is recommended that you store the username and token values returned from
 the completion handler in the keychain.

 @param username The Pinboard username.
 @param password The Pinboard password.
 @param completion An optional completion handler, returning on a private request queue.
 */
- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password
                      completion:(void(^_Nullable)(BOOL success, NSError * _Nullable error))completion;

/**
 Sets the username and token properties with values previously retrieved from
 `-authenticateWithUsername:password:completion:`.
 
 Use this method to restore credentials from the keychain before performing requests.

 @param username A Pinboard username.
 @param token A Pinboard token.
 */
- (void)setUsername:(NSString *)username token:(NSString *)token NS_SWIFT_NAME(set(username:token:));

/**
 Performs a requests against the Pinboard API.
 
 This method injects authentication credentials into the request
 and creates an NSNURLSessionTask using the internal `session`.

 @param request A pinboard request.
 */
- (void)performRequest:(id<PNKRequest>)request NS_SWIFT_NAME(perform(request:));

@end

NS_ASSUME_NONNULL_END
