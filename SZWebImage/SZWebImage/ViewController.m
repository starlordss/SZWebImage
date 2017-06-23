//
//  ViewController.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import "SZDownloadOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    SZDownloadOperation *op = [SZDownloadOperation new];
    
    [queue addOperation:op];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
