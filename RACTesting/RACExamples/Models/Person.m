//
//  Person.m
//  RACTesting
//
//  Created by Damon Allison on 1/5/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

#import "Person.h"

@interface Person()

@property (nonatomic, readwrite) BOOL isValid;
@property (nonatomic, readwrite) NSString *fullName;

@end

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        _firstName = @"";
        _lastName = @"";
        _fullName = @"";
        
        // Validity is based on username length.
        // Only when validity changes will we update the isValid
        // property.

        @weakify(self);
        RACSignal *validityChanged = [[RACObserve(self, username) map:^NSNumber *(NSString *value) {
            return @([value length] > 5);
        }] filter:^BOOL(NSNumber *isValid) {
            @strongify(self);
            return isValid.boolValue != self.isValid;
        }];
        RAC(self, isValid) = validityChanged;
        RAC(self, fullName) = [self fullnameChanged];
    }

    return self;
}

- (RACSignal *)usernameChanged {
    return RACObserve(self, username);
}

- (RACSignal *)fullnameChanged {
    @weakify(self)
    return [RACSignal combineLatest:@[ RACObserve(self, firstName), RACObserve(self, lastName) ]
                             reduce:^(NSString *firstName, NSString *lastName) {
                                 @strongify(self)
                                 return self.fullName;
                            }];
}

@end
