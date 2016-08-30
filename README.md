# GBNetWorking
基于AFNetworking3.0，将调取网络封装在block中，便于用户回调查看。基本的功能支持GET、POST、Download。
### 不区分接口类型 
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
###
[我的博客](http://blog.csdn.net/normanv)
