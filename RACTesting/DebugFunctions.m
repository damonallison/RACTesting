//
//  DebugFunctions.m
//  RACTesting
//
//  Created by Damon Allison on 1/27/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import "DebugFunctions.h"

@implementation DebugFunctions

+ (void)printEnvironment {

    NSProcessInfo *pi = [NSProcessInfo processInfo];
    NSLog(@"Process Name : %@", pi.processName);
    NSLog(@"%@", [pi environment]);
}

@end
