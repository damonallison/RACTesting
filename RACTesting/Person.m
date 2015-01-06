//
//  Person.m
//  RACTesting
//
//  Created by Damon Allison on 1/5/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import "Person.h"

@implementation Person

@dynamic fullName;

- (instancetype)init {
    if (self = [super init]) {
        _username = @"";
        _firstName = @"";
        _lastName = @"";
    }
    return self;
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
- (RACSignal *)onUsernameChange {
    return RACObserve(self, username);
}

- (RACSignal *)onFullnameChange {
    @weakify(self)
    return [RACSignal combineLatest:@[ RACObserve(self, firstName), RACObserve(self, lastName) ]
                             reduce:^(NSString *firstName, NSString *lastName) {
                                 @strongify(self)
                                 return self.fullName;
                            }];
}

@end
