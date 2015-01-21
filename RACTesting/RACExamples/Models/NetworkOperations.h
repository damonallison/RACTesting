//
//  NetworkOperations.h
//  RACTesting
//
//  Created by Damon Allison on 1/20/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkOperations : NSObject

/**
 * Simulates a long running (network) operation in background
 * to highlight asynchronous operations.
 *
 * A single value will be delivered on the signal - the 
 * result of the network operation.
 */
+ (RACSignal *)performAddInBackground:(int)x to:(int)y;

@end
