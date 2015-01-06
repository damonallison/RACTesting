//
//  ViewController.m
//  RACTesting
//
//  Created by Damon Allison on 12/1/14.
//  Copyright (c) 2014 Code42. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, strong) Person *person;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
    @weakify(self)
    [self.person.onUsernameChange subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"Next! username is : %@", self.person.username);
    } error:^(NSError *error) {
        NSLog(@"Error %@", error);
    } completed:^{
        NSLog(@"Completed!");
    }];

    [self.person.onFullnameChange subscribeNext:^(NSString *fullname) {
        NSLog(@"Fullname changed : %@", fullname);
    }];

    [[RACSignal merge:@[ self.person.onUsernameChange, self.person.onFullnameChange ]] subscribeCompleted:^{
        NSLog(@"both fullname ** and ** username changed");
    }];

    // Do any additional setup after loading the view, typically from a nib.

    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        NSLog(@"button was pressed");
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

@end
