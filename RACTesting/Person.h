//
//  Person.h
//  RACTesting
//
//  Created by Damon Allison on 1/5/15.
//  Copyright (c) 2015 Code42. All rights reserved.
//

@interface Person : NSObject

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, readonly) NSString *fullName;

- (RACSignal *)onUsernameChange;
- (RACSignal *)onFullnameChange;
@end
