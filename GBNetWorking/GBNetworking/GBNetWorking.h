//
//  GBConnectURL.h
//  GBNetworking
//
//  Created by Garvey's on 16/6/17.
//  Copyright © 2016年 Garvey's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ _Nullable GB_SucceedBlock)(NSDictionary *_Nullable dictionary);

typedef void(^ _Nullable GB_Param_SucceedBlock)(NSDictionary * _Nullable dictionary, NSString *_Nonnull type);

typedef void(^ _Nullable GB_ErrorBlock)(NSError *_Nullable error);

typedef void (^_Nullable GB_Progress)(NSProgress * _Nullable progress);

typedef NSURL * _Nullable (^ _Nullable GB_Destination)(NSURL *targetPath, NSURLResponse *response);
typedef void (^ _Nullable GB_DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath);

@interface GBNetWorking : NSObject
{
    GB_SucceedBlock       successBlock_;//成功返回的Block
    GB_Param_SucceedBlock successPBlock_;//带类型区分成功返回的Block
    GB_ErrorBlock         errorBlock_;//失败返回的Block
    GB_Progress           progressBlock_;// 上传或者下载进度Block;
    GB_Destination        destinationBlock_; //返回URL的Block
    GB_DownLoadSuccess    downLoadBlock_;// 下载成功的Blcok
}
/**
 *  超时时间(默认20秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;
#pragma mark --- GET请求
/**
 *  封装的get请求
 *
 *  @param requestUrl     请求的链接
 *  @param successBlock   请求成功回调
 *  @param errorBlock     请求失败回调
 */
+ (id)GetRequest:(NSString *)requestUrl successBlock:(GB_SucceedBlock)successBlock errorBlock:(GB_ErrorBlock)errorBlock;
- (id)initWithGetRequest:(NSString *)requestUrl successBlock:(GB_SucceedBlock)successBlock errorBlock:(GB_ErrorBlock)errorBlock;

/**
 *  封装的get请求
 *
 *  @param requestUrl     请求的链接
 *  @param type           请求的类型
 *  @param successBlock   请求成功回调
 *  @param errorBlock     请求失败回调
 */
+ (id)GetRequestType:(NSString *)type Url:(NSString *)requestUrl successBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock;
- (id)initWithGetTypeRequest:(NSString *)type Url:(NSString *)requestUrl successBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock;

#pragma mark --- POST请求

/**
 *  封装的POST请求
 *
 *  @param requestUrl    请求的链接
 *  @param paramDic      上传的参数
 *  @param successBlock  请求成功回调
 *  @param errorBlock    请求失败回调
 */
+ (id)PostRequest:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successBlock:(GB_SucceedBlock )successBlock errorBlock:(GB_ErrorBlock)errorBlock;
- (id)initWithPostRequest:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successBlock:(GB_SucceedBlock )successBlock errorBlock:(GB_ErrorBlock)errorBlock;

/**
 *  封装的POST请求
 *
 *  @param requestUrl    请求的链接
 *  @param type           请求的类型
 *  @param paramDic      上传的参数
 *  @param successBlock  请求成功回调
 *  @param errorBlock    请求失败回调
 */
+ (id)PostRequestType:(NSString *)type Url:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successPBlock:(GB_Param_SucceedBlock )successPBlock errorBlock:(GB_ErrorBlock)errorBlock;
- (id)initWithPostTypeRequest:(NSString *)type Url:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successPBlock:(GB_Param_SucceedBlock )successPBlock errorBlock:(GB_ErrorBlock)errorBlock;
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
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString progress:(GB_Progress)progress destination:(GB_Destination)destination downLoadSuccess:(GB_DownLoadSuccess)downLoadSuccess errorBlock:(GB_ErrorBlock)errorBlock;

NS_ASSUME_NONNULL_END

@end
