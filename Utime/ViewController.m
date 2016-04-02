//
//  ViewController.m
//  Utime
//
//  Created by AdrianHsu on 2015/5/9.
//  Copyright (c) 2015年 AdrianHsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"show_login_segue" sender:nil];
        //[self performSegueWithIdentifier:@"show_profile_segue" sender:nil];
    });

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"isLogined:%d",self.isLogined);
    
    if (self.isLogined) {
        [self performSegueWithIdentifier:@"show_profile_segue" sender:nil];
    }
    
}

- (IBAction) exitFromLoginPage:(UIStoryboardSegue *)segue {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
