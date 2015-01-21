//
//  RACSequenceExamples.m
//  RACTesting
//
//  Created by Damon Allison on 1/13/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import "RACSequenceExamples.h"

@implementation RACSequenceExamples

/**
 *
 *  Sequences are pull-driven streams.
 *
 *  Sequences allow you to process signal data through functional pipelines
 *  (map / filter / reduce)
 
 *  Values are lazily-evaluated.
 *  Sequences cannot contain nil.
 *
 *  Similar to lazy-seq in clojure or "List" in haskell.
 */
- (void)sequenceExample {

    NSArray *names = @[ @"damon", @"ryan", @"allison" ];
    RACSequence *seq = names.rac_sequence;

    NSArray *fs = [[seq filter:^BOOL(NSString *value) {
        return value.length > 4;
    }] map:^NSNumber *(NSString *value) {
        return @([value length]);
    }].array;
    NSLog(@"Names > 4 characters have lengths of : %@", fs);
}

@end
