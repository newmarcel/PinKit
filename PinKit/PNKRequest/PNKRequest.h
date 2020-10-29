//
//  PNKRequest.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PinKit/PNKHTTP.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Represents a Pinboard API request. You might want to use the concrete
 `PNKRequest` class directly instead of this protocol.
 */
@protocol PNKRequest <NSObject>

/**
 The relative API path of the request.
 */
@property (nonatomic, readonly) NSString *endpoint;

/**
 The HTTP method to use.
 */
@property (nonatomic, readonly) PNKHTTPMethod HTTPMethod;

/**
 A dictionary with all aditional request parameters. These are usually
 transformed into query items for HTTP GET requests.
 */
@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *parameters;

/**
 The response format, e.g. json or xml.
 */
@property (copy, nonatomic) NSString *format;

/**
 The request authentication token. `PNKPinboardClient` injects
 this token for authenticated requests.
 */
@property (copy, nonatomic) NSString *authenticationToken;

/**
 A completion method that is responsible for post-processing the
 response values for the request. An implementing object can use this
 callback to integrate custom completion handlers.

 @param object The deserialized JSON object
 @param response The URL response
 @param error An optional request error
 */
- (void)handleCompletionWithJSONObject:(nullable id)object response:(NSHTTPURLResponse *)response error:(nullable NSError *)error;

/**
 Converts the implementing object into an `NSURLRequest`.

 @param baseURL The base URL that should be used for the request
 @return An `NSURLRequest` representing this request.
 */
- (NSURLRequest *)URLRequestRelativeToURL:(NSURL *)baseURL;

@end


/**
 A Pinboard API request representation.
 */
@interface PNKRequest : NSObject <PNKRequest>

/**
 The relative API path of the request.
 */
@property (nonatomic, readonly) NSString *endpoint;

/**
 The HTTP method to use.
 */
@property (nonatomic, readonly) PNKHTTPMethod HTTPMethod;

/**
 The response format, e.g. either json or xml. Defaults to json.
 */
@property (copy, nonatomic) NSString *format;

/**
 The request authentication token. `PNKPinboardClient` injects
 this token for authenticated requests.
 */
@property (copy, nonatomic) NSString *authenticationToken;

/**
 Returns a dictionary with all aditional request parameters.
 
 Make sure the subclass implementation calls super before returning!

 @return Request parameters
 */
- (NSDictionary<NSString *, NSString *> *)parameters NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
