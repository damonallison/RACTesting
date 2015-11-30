//
//  RACSequenceTests.m
//  RACTesting
//
//  Created by Damon Allison on 1/27/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import <XCTest/XCTest.h>

/**
 *  Sequences are pull-driven streams which are lazily evaluated.
 *  Similar to lazy-seq in clojure or "List" in haskell.
 *
 *  Sequences are superior to NSArray / NSSet because they allow you 
 *  to perform higher level functions on them (map, filter, reduce).
 *
 *  Like NSArray, NSSet, etc, RACSequence cannot contain `nil`.
 */
@interface RACSequenceTests : XCTestCase

@end

@implementation RACSequenceTests

/**
 *  In this example, show that items are evaluated only once.
 */
- (void)testLazyEvaluation {

    NSMutableArray *evaluated = [NSMutableArray arrayWithCapacity:3];

    NSArray *names = @[ @"damon", @"ryan", @"allison", @"junior" ];
    RACSequence *seq = names.rac_sequence;

    RACSequence *filtered = [seq filter:^BOOL(NSString *value) {
        BOOL pass = value.length > 4;
        if (pass) {
            [evaluated addObject:[value copy]];
        }
        return pass;
    }];

    // Only head should have evaluated
    NSString *first = filtered.head;
    XCTAssertEqualObjects(first, @"damon");
    XCTAssertTrue([evaluated isEqualToArray:@[@"damon"]]);

    // The next in the sequence should have evaluated
    NSString *next = filtered.tail.head;
    XCTAssertEqualObjects(next, @"allison");
    NSArray *expected = @[@"damon", @"allison"];
    XCTAssertTrue([evaluated isEqualToArray:expected]);

    // Note that this element has already been evalutated, thus it will
    // not be added to the "evaluated" array.
    NSString *next2 = filtered.tail.head;
    XCTAssertEqualObjects(next2, @"allison");
    XCTAssertTrue([evaluated isEqualToArray:expected]);

//    NSArray *expected = @[@(5), @(7)];
//    XCTAssertTrue([fs isEqualToArray:expected]);
}

/// Combining streams

/**
 *  concat combines values into a single stream.
 */
- (void)testConcat {
    RACSequence *letters = @[@"a", @"b", @"c"].rac_sequence;
    RACSequence *numbers = @[@(1), @(2), @(3)].rac_sequence;

    NSArray *all = [letters concat:numbers].array;
    NSArray *expected = @[@"a", @"b", @"c", @(1), @(2), @(3)];
    XCTAssertEqualObjects(all, expected);
}

- (void)testMap {

    NSArray *names = @[ @"damon", @"ryan", @"allison"];
    RACSequence *seq = names.rac_sequence;
    NSArray *longNameLengths = [[seq filter:^BOOL(NSString *value) {
        return [value length] > 4;
    }] map:^NSDictionary *(NSString *value) {
        return @{[value copy] : @([value length])};
    }].array;

    NSArray *expected = @[@{@"damon" : @(5)}, @{@"allison" : @(7)}];
    XCTAssertTrue([longNameLengths isEqualToArray:expected]);
}


@end
