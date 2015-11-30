//
//  RACSignalTests.m
//  RACTesting
//
//  Created by Damon Allison on 1/27/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RACSignalTests : XCTestCase

@end

@implementation RACSignalTests

/**
 *  -do* allows you to add side effects to a signal. Blocks are added
 *  to the appropriate events and invoked each time the event fires.
 */
- (void)testDo {

    NSArray *letters = @[@"A", @"B", @"C", @"D"];
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    RACSignal *s = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        for (NSString *obj in letters) {
            [subscriber sendNext:obj];
        }
        [subscriber sendCompleted];
        return nil;
    }];

    // adding side effects to a signal (would be good for logging / tracking
    // statistics, etc)

    // You can chain do* calls together. Note that these will fire *before*
    // the event is passed up the chain.
    NSMutableArray *loggedLetters = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray *loggedLetters2= [NSMutableArray arrayWithCapacity:4];
    __block BOOL doCompleted = NO;
    s = [s doNext:^(NSString *x) {
        [loggedLetters addObject:x];
    }];
    s = [s doNext:^(NSString *x) {
        [loggedLetters2 addObject:x];
    }];
    s = [s doCompleted:^{
        doCompleted = YES;
    }];

    NSMutableArray *completedLetters = [NSMutableArray arrayWithCapacity:4];
    [s subscribeNext:^(NSString *x) {
        [completedLetters addObject:x];
    } completed:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
    XCTAssertTrue(doCompleted, @"The doCompleted() block did not execute");
    XCTAssertTrue([loggedLetters isEqualToArray:letters]);
    XCTAssertTrue([loggedLetters2 isEqualToArray:letters]);
    XCTAssertTrue([completedLetters isEqualToArray:letters]);
}


- (void)testConcat {
    RACSequence *s1 = @[@"A", @"B"].rac_sequence;
    RACSequence *s2 = @[@"C", @"D"].rac_sequence;

    NSArray *expected = @[@"A", @"B", @"C", @"D"];
    XCTAssertTrue([[s1 concat:s2].array isEqualToArray:expected]);
}

/**
 *  Flatten combines sequences.
 *  Flatten merges signals.
 */
- (void)testFlatten {

    RACSequence *s1 = @[@"A", @"B"].rac_sequence;
    RACSequence *s2 = @[@"C", @"D"].rac_sequence;
    RACSequence *allStreams = @[s1, s2].rac_sequence;

    NSArray *expected = @[@"A", @"B", @"C", @"D"];
    XCTAssertTrue([[allStreams flatten].array isEqualToArray:expected]);

    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSignal *signalOfSignals = [RACSignal createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
        [subscriber sendNext:letters];
        [subscriber sendNext:numbers];
        [subscriber sendCompleted];
        return nil;
    }];

    RACSignal *flattened = [signalOfSignals flatten];

    NSMutableArray *received = [NSMutableArray array];
    // Outputs: A 1 B C 2
    [flattened subscribeNext:^(NSString *x) {
        [received addObject:x];
    } completed:^{
        [expectation fulfill];
    }];

    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    [numbers sendCompleted];
    [letters sendCompleted];

    expected = @[@"A", @"1", @"B", @"C", @"2"];
    [self waitForExpectationsWithTimeout:1.0 handler:nil];
    XCTAssertTrue([received isEqualToArray:expected]);
}

/**
 *  flattenMap : used to transform each of a stream's values into a new stream.
 *               then, all streams returned will be flattened down into a single
 *               stream.
 */
- (void)testFlattenMap {

    NSArray *original = @[@"A", @"B", @"C", @"D"];

    // maps the original stream, returning a new stream, then flattens it
    // into a single stream.
    NSArray *doubled = [original.rac_sequence flattenMap:^RACStream *(NSString *value) {
        return @[value, value].rac_sequence;
    }].array;

    NSArray *expected = @[@"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D"];
    XCTAssertTrue([doubled isEqualToArray:expected]);
}

/**
 *  Forwards the values from many signals into a single stream.
 */
- (void)testMerge {




}



@end
