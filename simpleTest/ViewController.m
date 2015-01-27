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
    
    //via.http://objccn.io/issue-12-1/
    //animationTest
    UIImageView *testImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 81.5, 65)];
    testImage.image = [UIImage imageNamed:@"peo077_a"];
    [self.view addSubview:testImage];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @10;
    animation.toValue = @210;
    animation.duration = 1;
    animation.repeatCount = 10;
    
    [testImage.layer addAnimation:animation forKey:@"basic"];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
