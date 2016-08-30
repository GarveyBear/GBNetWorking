# GBNetWorking
基于AFNetworking3.0，将调取网络封装在block中，便于用户回调查看。基本的功能支持GET、POST、Download。

* 不区分接口 Get请求
* 区分接口   Get请求
* 不区分接口 Post请求
* 区分接口   Post请求
* Download接口 

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
+ (id)PostRequestType:(NSString *)type Url:(NSString *)requestUrl dicData:(NSDictionary *)paramDic successPBlock:(GB_Param_SucceedBlock)successPBlock errorBlock:(GB_ErrorBlock)errorBlock
{
    return [[self alloc] initWithPostTypeRequest:type Url:requestUrl dicData:paramDic successPBlock:successPBlock errorBlock:errorBlock];
}
```
###

[我的博客](http://blog.csdn.net/normanv "CSDN博客")
[回到顶部](#readme)
