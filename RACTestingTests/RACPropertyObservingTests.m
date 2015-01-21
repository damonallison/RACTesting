//
//  RACTestingTests.m
//  RACTestingTests
//
//  Created by Damon Allison on 12/1/14.
//  Copyright (c) 2014 Code42. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Person.h"

@interface RACTestingTests : XCTestCase

@end

@implementation RACTestingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testPropertyObserving {

    Person *p = [[Person alloc] init];

    XCTestExpectation *fName = [self expectationWithDescription:@"fName"];
    [[RACObserve(p, firstName)
      skip:1]
     subscribeNext:^(NSString *firstName) {
         XCTAssertEqualObjects(firstName, @"Damon");
         [fName fulfill];
    }];
    p.firstName = @"Damon";
    [self waitForExpectationsWithTimeout:1.0 handler:nil];

}

- (void)testSignalMerging {

}

- (void)testFlattenMap {

}


@end
