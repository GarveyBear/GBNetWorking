//
//  ViewController.m
//  GBNetworking
//
//  Created by Garvey's on 16/6/17.
//  Copyright © 2016年 Garvey's. All rights reserved.
//
#define GBLog(...) NSLog(__VA_ARGS__)
#define HANGZHOU @"杭州"
#import "ViewController.h"
#import "GBNetWorking.h"

@interface ViewController ();
@property (weak, nonatomic) IBOutlet UIProgressView *proGressView;
@property (weak, nonatomic) IBOutlet UILabel *proLb;

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    #pragma mark -- GET
    /**
     *  无类型区分的get请求
     *  @param strURL     请求的链接
     *  @param dictionary 请求回调的数据
     *  @param error      请求失败回调
     */
    NSString *strURL = @"http://api.worldweatheronline.com/free/v2/weather.ashx?q=Zhangzhou&num_of_days=1&format=json&tp=6&key=5f9fbd4fbbcae7c342d0978ca172e";
    
    [GBNetWorking GetRequest:strURL successBlock:^(NSDictionary * _Nullable dictionary)
    {
        GBLog(@"%@", dictionary);
        
    } errorBlock:^(NSError * _Nullable error) {
        GBLog(@"error %@", error);
    }];
    
    
    
    /**
     *  带类型区分的get请求
     *  @param strURL     请求的链接
     *  @param dictionary 请求回调的数据
     *  @param error      请求失败回调
     */
    [GBNetWorking GetRequestType:HANGZHOU Url:strURL successBlock:^(NSDictionary * _Nullable dictionary, NSString * _Nonnull type)
    {
        GBLog(@"%@ %@", type, dictionary);
        
    } errorBlock:^(NSError * _Nullable error) {
        GBLog(@"%@", error);
    }];
    
    #pragma mark -- POST
    /**
     *  无类型区分的post请求
     *  @param strURLPost 请求的链接
     *  @param dic        请求上传的数据
     *  @param dictionary 请求回调的数据
     *  @param error      请求失败回调
     */
    NSString *URLPost = [[NSString alloc] init];
    NSDictionary *dic = [[NSDictionary alloc] init];
    [GBNetWorking PostRequest:URLPost dicData:dic successBlock:^(NSDictionary * _Nullable dictionary) {
        GBLog(@"%@", dictionary);
        
    } errorBlock:^(NSError * _Nullable error)
    {
        GBLog(@"%@", error);
    }];
    
    /**
     *  无类型区分的post请求
     *  @param URLTYPE    请求的链接
     *  @param str        请求的类型
     *  @param dicType    请求上传的数据
     *  @param dictionary 请求回调的数据
     *  @param error      请求失败回调
     */
    NSString *URLTYPE = [[NSString alloc] init];
    NSString *str = [[NSString alloc] init];
    NSDictionary *dicType = [[NSDictionary alloc] init];
//    [GBNetWorking PostRequestType:str Url:URLTYPE dicData:dicType successPBlock:^(NSDictionary * _Nullable dictionary, NSString * _Nonnull type)
//    {
//        GBLog(@"%@ %@", type, dictionary);
//        
//    } errorBlock:^(NSError * _Nullable error)
//    {
//        GBLog(@"%@", error);
//    }];
    
    #pragma mark -- DOWNLOAD
    /**
     *  下载
     *
     *  @param URLString       请求的链接
     *  @param progress        进度的回调
     *  @param destination     返回URL的回调
     *  @param downLoadSuccess 发送成功的回调
     *  @param failure         发送失败的回调
     */
    NSString *URLString = @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg";
    __block UIProgressView *prossView = _proGressView;
    __block UILabel *prossLb = _proLb;
    [[GBNetWorking new] downLoadWithURL:URLString progress:^(NSProgress * _Nullable progress) {
        GBLog(@"progress == %@", progress);
        GBLog(@"%lf", 1.0 * progress.completedUnitCount / progress.totalUnitCount);
        dispatch_async(dispatch_get_main_queue(), ^{
            //Update the progress view
            prossView.progress = progress.completedUnitCount / progress.totalUnitCount;
            
            float _percent = prossView.progress;
            
            CFLocaleRef currentLocale = CFLocaleCopyCurrent();
            
            CFNumberFormatterRef numberFormatter = CFNumberFormatterCreate(NULL, currentLocale, kCFNumberFormatterPercentStyle);
            
            CFNumberRef number = CFNumberCreate(NULL, kCFNumberFloatType, &_percent);
            
            CFStringRef numberString = CFNumberFormatterCreateStringWithNumber(NULL, numberFormatter, number);
            
            prossLb.text =  (__bridge NSString *)numberString;
        });
    } destination:^NSURL * _Nullable(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        GBLog(@"targetPath == %@, response == %@", targetPath, response);
        
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hhhh.mp3"];
        return [NSURL fileURLWithPath:filePath];
    } downLoadSuccess:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath) {
        GBLog(@"下载完成\n%@--%@",response, filePath);
    } errorBlock:^(NSError * _Nullable error)
    {
        GBLog(@"error %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
