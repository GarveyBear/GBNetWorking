# GBNetWorking
基于AFNetworking3.0，将调取网络封装在block中，便于用户回调查看。基本的功能支持GET、POST、Download。

[我的博客](http://blog.csdn.net/normanv "Garvey Blog")

* 不区分接口 Get请求
* 区分接口   Get请求
* 不区分接口 Post请求
* 区分接口   Post请求
* Download请求

####AFNetWorking3.0导入【使用CocoaPods】####
```C
    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '8.0'
    pod 'AFNetworking', '~> 3.0'
```

###Get请求 不区分接口类型
```ObjectiveC 
+ (id)GetRequest:(NSString *)requestUrl successBlock:(GB_SucceedBlock)successBlock 
errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithGetRequest:requestUrl successBlock:successBlock errorBlock:errorBlock];
}
```
###

###Get请求 区分接口类型
```ObjectiveC 
+ (id)GetRequestType:(NSString *)type Url:(NSString *)requestUrl successBlock:(GB_Param_SucceedBlock)
 successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithGetTypeRequest:type Url:requestUrl successBlock:successPBlock 
    errorBlock:errorBlock];
}
```
###

###Post请求 不区分接口
```ObjectiveC 
+ (id)PostRequest:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successBlock:(GB_SucceedBlock )
 successBlock   errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithPostRequest:requestUrl dicData:paramDic 
    successBlock:successBlock errorBlock:errorBlock];
}
```
###

###Post请求 区分接口类型
```ObjectiveC 
+ (id)PostRequestType:(NSString *)type Url:(NSString *)requestUrl dicData:(NSDictionary *)
paramDic successPBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithPostTypeRequest:type Url:requestUrl dicData:paramDic 
    successPBlock:successPBlock errorBlock:errorBlock];
}
```
###

###Download请求
```ObjectiveC 
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString progress:(GB_Progress)progress
destination:(GB_Destination)destination 
downLoadSuccess:(GB_DownLoadSuccess)downLoadSuccess errorBlock:(GB_ErrorBlock)errorBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request 
    progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress)
        {
            progress(downloadProgress); 
            // HDLog(@"%lf", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
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
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, 
    NSError * _Nullable error) {
        
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
```
###
[回到顶部](#readme)
