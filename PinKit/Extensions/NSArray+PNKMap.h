//
//  NSArray+PNKMap.h
//  Sienna
//
//  Created by Marcel Dierkes on 24.12.16.
//  Copyright © 2016 Marcel Dierkes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (PNKMap)

/**
 Maps the transform function to each element in the collection.
 nil values from the transform function are replaced by NSNull.

 @param transform A transformation function
 @return A returned collection with the same number of elements as the original collection.
 */
- (NSArray *)pnk_map:(NS_NOESCAPE id(^)(id element))transform;

/**
 Maps and flattens the collection by the transform block.
 
 NSNull and nil values are removed from the result.

 @param transform A transformation function
 @return A returned collection with equal or less elements than the original collection.
 */
- (NSArray *)pnk_flatMap:(NS_NOESCAPE _Nullable id(^)(id element))transform;

@end

NS_ASSUME_NONNULL_END
