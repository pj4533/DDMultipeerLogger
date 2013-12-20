//
//  SGSViewController.m
//  ExampleLoggingApp
//
//  Created by PJ Gray on 12/20/13.
//  Copyright (c) 2013 Say Goodnight Software. All rights reserved.
//

#import "SGSViewController.h"

@interface SGSViewController ()

@end

@implementation SGSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    DDLogInfo(@"ViewController Loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logSomethingTapped:(id)sender {
    
    DDLogInfo(@"Something");
    
}

@end
