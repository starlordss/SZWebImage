//
//  ViewController.m
//  SZWebImage
//
//  Created by Zahi on 2017/6/23.
//  Copyright © 2017年 Zahi. All rights reserved.
//

#import "ViewController.h"
#import "AppModel.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "SZWebImageManager.h"

@interface ViewController ()

/**数据**/
@property (nonatomic, strong) NSArray *arrData;
/**图片视图*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**队列**/
@property (nonatomic, strong) NSOperationQueue *queue;
/**上一次图片链接**/
@property (nonatomic, copy) NSString *lastURLString;

/**操作缓存**/
@property (nonatomic, strong) NSMutableDictionary *OPCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 实例化队列
    self.queue = [NSOperationQueue new];
    // 实例缓存池
    self.OPCache = [NSMutableDictionary dictionary];
    
    // 加载数据
    [self loadData];
    
    
}

#pragma mark - 触摸屏幕

/**
 * 测试DownloadOperation:点击屏幕，随机获取图片的地址，交给DownloadOperation去下载
 * 问题：有网络延迟时，连续点击多次，后面下载的图片在赋值时，把前面下载的图片覆盖了
 * 解决方案: 当点击下一次时，把上一次正在执行的操作取消掉，只保留最后一次创建的下载操作去下载图片
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取随机索引
    int random = arc4random_uniform((int32_t)self.arrData.count);

    // 获取模型
    AppModel *app = self.arrData[random];
    
    // 判断本次链接和上次链接是否一样 不一样就把之前操作取消掉
    // 第一次下载 上一次图片地址为空
    if (self.lastURLString != nil && ![app.icon isEqualToString:self.lastURLString]) {//不一样
        
        [[SZWebImageManager sharedManager] cancelFormLastURLString:self.lastURLString];
    }
    
    // 记录上一次图片链接
    self.lastURLString = app.icon;

    
    // 单例管理下载操作：取消操作失效
    [[SZWebImageManager sharedManager] downloadImageWithURLString:app.icon completion:^(UIImage *image) {
        
        _imageView.image = image;
        
    }];
    
    
}

#pragma mark - 加载网络Json数据
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
