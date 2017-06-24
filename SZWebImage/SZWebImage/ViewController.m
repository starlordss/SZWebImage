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
    
    NSString *URLString = @"http://paper.taizhou.com.cn/tzwb/res/1/2/2015-01/20/12/res03_attpic_brief.jpg";
    
    SZDownloadOperation *op = [SZDownloadOperation downloadImageWithURLString:URLString finishedBlock:^(UIImage *image) {
        
        NSLog(@"%@ %@",image, [NSThread currentThread]);
    }];
    
//    SZDownloadOperation *op = [SZDownloadOperation downloadImageWithURLString:URLString finishedBlock:nil];
    
    
    [queue addOperation:op];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
