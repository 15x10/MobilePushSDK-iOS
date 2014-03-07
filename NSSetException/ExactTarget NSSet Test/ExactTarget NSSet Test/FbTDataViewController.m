//
//  FbTDataViewController.m
//  ExactTarget NSSet Test
//
//  Created by Don Huff on 3/6/14.
//  Copyright (c) 2014 15 by 10, LLC. All rights reserved.
//

#import "FbTDataViewController.h"

#import "ETPush.h"

@interface FbTDataViewController ()

- (IBAction)_handleValueChanged1:(UISwitch *)sender;
- (IBAction)_handleValueChanged2:(UISwitch *)sender;

@end

@implementation FbTDataViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (IBAction)_handleValueChanged1:(UISwitch *)sender
{
    if (sender.isOn) {
        [[ETPush pushManager] addTag:@"Foo1"];
    } else {
        [[ETPush pushManager] removeTag:@"Foo1"];
    }
}

- (IBAction)_handleValueChanged2:(UISwitch *)sender
{
    if (sender.isOn) {
        [[ETPush pushManager] addTag:@"Foo2"];
    } else {
        [[ETPush pushManager] removeTag:@"Foo2"];
    }
}

@end
