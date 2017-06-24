//
//  ViewController.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import "SZDownloadOperation.h"
#import "AppModel.h"
#import "AFNetworking.h"
#import "YYModel.h"

@interface ViewController ()

/**数据源**/
@property (nonatomic, strong) NSArray *arrData;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**队列**/
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [NSOperationQueue new];
    
    [self loadData];
    
    
}

#pragma mark - 触摸屏幕

/**
 * 测试DownloadOperation:点击屏幕，随机获取图片的地址，交给DownloadOperation去下载
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取随机索引
    int random = arc4random_uniform((int32_t)self.arrData.count);

    // 获取模型
    AppModel *app = self.arrData[random];
    SZDownloadOperation *op = [SZDownloadOperation downloadImageWithURLString:app.icon finishedBlock:^(UIImage *image) {
        
        _imageView.image = image;
    }];
    
    
    [self.queue addOperation:op];
}

#pragma mark - 加载数据
- (void)loadData
{
    NSString *urlStr = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM06/master/apps.json";
    
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        self.arrData = [NSArray yy_modelArrayWithClass:[AppModel class] json:responseObject];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
