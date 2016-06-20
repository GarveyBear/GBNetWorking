//
//  GBConnectURL.m
//  GBNetworking
//
//  Created by Garvey's on 16/6/17.
//  Copyright © 2016年 Garvey's. All rights reserved.
//

#import "GBNetWorking.h"
#import "AFNetworking.h"

@implementation GBNetWorking
#pragma mark --- GET请求

/**
 *  封装的get请求
 *
 *  @param requestUrl     请求的链接
 *  @param successBlock   请求成功回调
 *  @param errorBlock     请求失败回调
 */
#pragma mark --- 不区分接口类型
+ (id)GetRequest:(NSString *)requestUrl successBlock:(GB_SucceedBlock)successBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithGetRequest:requestUrl successBlock:successBlock errorBlock:errorBlock];
}
- (id)initWithGetRequest:(NSString *)requestUrl successBlock:(GB_SucceedBlock)successBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    self = [super init];
    if (self)
    {
        successBlock_ = [successBlock copy];//分配两个内存地址 防止successBlock_值得改变影响到successBlock
        errorBlock_ = [errorBlock copy];
        
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //设置相关的请求头
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
        manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
        
        [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 if (successBlock)
                 {
                     successBlock_((NSDictionary*)responseObject);
                 }
             }
         
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {  
                 if (error)
                 {
                     errorBlock_(error);
                 }
             }];

    }
    return self;
}
/**
 *  封装的get请求
 *
 *  @param requestUrl     请求的链接
 *  @param type           请求的类型
 *  @param successBlock   请求成功回调
 *  @param errorBlock     请求失败回调
 */
#pragma mark --- 区分接口类型 
+ (id)GetRequestType:(NSString *)type Url:(NSString *)requestUrl successBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithGetTypeRequest:type Url:requestUrl successBlock:successPBlock errorBlock:errorBlock];
}
- (id)initWithGetTypeRequest:(NSString *)type Url:(NSString *)requestUrl successBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    self = [super init];
    if (self)
    {
        successPBlock_ = [successPBlock copy];//分配两个内存地址 防止successBlock_值得改变影响到successBlock
        errorBlock_ = [errorBlock copy];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
        manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
        
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [manager GET:requestUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 if (successPBlock)
                 {
                    successPBlock_((NSDictionary*)responseObject, type);
                 }
             }
         
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
                 if (errorBlock)
                 {
                     errorBlock_(error);
                 }
                 
             }];
    }
    return self;
}
#pragma mark --- POST请求

/**
 *  封装的POST请求
 *
 *  @param requestUrl    请求的链接
 *  @param paramDic      上传的参数
 *  @param successBlock  请求成功回调
 *  @param errorBlock    请求失败回调
 */
#pragma mark --- 不区分接口类型
+ (id)PostRequest:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successBlock:(GB_SucceedBlock )successBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithPostRequest:requestUrl dicData:paramDic successBlock:successBlock errorBlock:errorBlock];
}
- (id)initWithPostRequest:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successBlock:(GB_SucceedBlock )successBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    self = [super init];
    if (self)
    {
        successBlock_ = [successBlock copy];//分配两个内存地址 防止successBlock_值得改变影响到successBlock
        errorBlock_ = [errorBlock copy];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        
        manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
        manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
        
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [manager POST:requestUrl parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (successBlock)
            {
                successBlock_((NSDictionary*)responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (errorBlock)
            {
                errorBlock_(error);
            }
        }];

    }
    return self;
}
#pragma mark --- 带区分接口类型
+ (id)PostRequestType:(NSString *)type Url:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successPBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithPostTypeRequest:type Url:requestUrl dicData:paramDic successPBlock:successPBlock errorBlock:errorBlock];
}
- (id)initWithPostTypeRequest:(NSString *)type Url:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successPBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    self = [super init];
    if (self)
    {
        successPBlock_ = [successPBlock copy];//分配两个内存地址 防止successBlock_值得改变影响到successBlock
        errorBlock_ = [errorBlock copy];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        
        manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
        manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
        
        requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [manager POST:requestUrl parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (successPBlock)
            {
                successPBlock_((NSDictionary*)responseObject, type);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (errorBlock)
            {
                errorBlock_(error);
            }
        }];
        
    }
    return self;
}
#pragma mark --- DOWNLOAD
/**
 *  下载
 *
 *  @param URLString       请求的链接
 *  @param progress        进度的回调
 *  @param destination     返回URL的回调
 *  @param downLoadSuccess 发送成功的回调
 *  @param failure         发送失败的回调
 */
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString progress:(GB_Progress)progress destination:(GB_Destination)destination downLoadSuccess:(GB_DownLoadSuccess)downLoadSuccess errorBlock:(GB_ErrorBlock)errorBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress)
        {
            progress(downloadProgress); // HDLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (destination)
        {
            return destination(targetPath, response);
        }
        else
        {
            return nil;
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error)
        {
            errorBlock(error);
        }
        else
        {
            downLoadSuccess(response, filePath);
        }
    }];
    
    // 开始启动任务
    [task resume];
    
    return task;
}
@end
