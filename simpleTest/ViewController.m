//
//  ViewController.m
//  simpleTest
//
//  Created by idev on 15/1/4.
//  Copyright (c) 2015年 idev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str1 = @"-1";
    NSInteger iStr1 = [str1 integerValue];
    
    int val = 10;
    const char *fmt = "val = %d\n";
    void (^blk)(void) = ^{printf(fmt,val);};
    
    val = 2;
    fmt = "These values were changed. val = %d\n";
    
    blk();
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
