//
//  RACExampleViewController.m
//  RACTesting
//
//  Created by Damon Allison on 12/1/14.
//  Copyright (c) 2014 Code42. All rights reserved.
//

#import "RACExampleViewController.h"

#import "Person.h"
@interface RACExampleViewController ()

// Notice that IBActions are *not* declared and wired up from IB.
// Actions will be added via RAC signal subscriptions.
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, strong) Person *person;

@end

@implementation RACExampleViewController


- (void)viewDidLoad {
    [self printSomething:@"damon"];

    [super viewDidLoad];

    self.person = [[Person alloc] init];

    // Add an extra subscriber to the username changed event
    @weakify(self)
    RACSignal *s = RACObserve(self.person, username);
    // Sends something to NSLog for each event.
    [s logAll];

    // Subscribe to all events.
    [s subscribeNext:^(NSString *x) {
        @strongify(self)
        NSLog(@"Next! username is : %@", self.person.username);
        NSLog(@"username is %@", x);
        if (x) {
            assert([x isKindOfClass:[NSString class]]);
            assert([x isEqualToString:self.person.username]);
        }
    } error:^(NSError *error) {
        NSLog(@"Error %@", error);
    } completed:^{
        NSLog(@"Completed!");
    }];

    [RACObserve(self.person, isValid) subscribeNext:^(NSNumber *x) {
        NSLog(@"Hey, validity changed : %d", x.boolValue);
    }];


    // rac_command will be signaled when the button is pressed.
    self.button1.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        NSLog(@"button was pressed");
        if (self.person.username == nil) {
            self.person.username = @"";
        }
        if (self.person.firstName == nil) {
            self.person.firstName = @"";
        }
        if (self.person.lastName == nil) {
            self.person.lastName = @"";
        }
        self.person.username = [self.person.username stringByAppendingString:@"+"];
        self.person.firstName = [self.person.firstName stringByAppendingString:@"F"];
        self.person.lastName = [self.person.lastName stringByAppendingString:@"L"];
        // returns a signal that immediately completes.
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printSomething:(NSString *)something {
    NSLog(@"Hello from %@, %@ - %@", self, NSStringFromSelector(_cmd), something);
}

@end
