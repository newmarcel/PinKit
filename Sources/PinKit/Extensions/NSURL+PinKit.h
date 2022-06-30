//
//  NSURL+PinKit.h
//  PinKit
//
//  Created by Marcel Dierkes on 02.01.17.
//  Copyright © 2017 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (PinKit)
- (instancetype)pnk_URLByAppendingQueryItems:(NSArray<NSURLQueryItem *> *)queryItems;
@end

NS_ASSUME_NONNULL_END
