//
//  RACTestingTests.m
//  RACTestingTests
//
//  Created by Damon Allison on 11/17/14.
//  Copyright (c) 2014 Damon Allison. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACTestingTests : XCTestCase {

}

@property (nonatomic, strong) NSString *firstName;
@end

@implementation RACTestingTests


- (void)setUp {
    [super setUp];
    self.firstName = nil;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/// Simple property observation.
///
/// Note that the initial value is sent upon initial subsription.
///
- (void)testRACStream {
    
    __block NSArray *changes = [NSArray array];
    
    [RACObserve(self, firstName) subscribeNext:^(NSString *x) {
        changes = [changes arrayByAddingObject:(x ? [x copy] : @"null")];
    }];
    
    self.firstName = @"damon";
    self.firstName = @"Damon";
    
    NSArray *expected = @[@"null", @"damon", @"Damon"];
    XCTAssertEqualObjects(expected, changes);
}

- (void)testRACFilter {
    
    __block NSArray *changes = [NSArray array];
    
    [RACObserve(self, firstName) filter:^BOOL(NSString *newName) {
        return [[newName lowercaseString] rangeOfString:@"damon"].location != NSNotFound;
    }] 
    
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

@end
