# GBNetWorking
基于AFNetworking3.0，将调取网络封装在block中，便于用户回调查看。基本的功能支持GET、POST、Download。
### 比如我们可以在多行文本框里输入一段代码,来一个Java版本的HelloWorld吧  
     ```Java
     + (id)GetRequest:(NSString *)requestUrl successBlock:(GB_SucceedBlock)successBlock errorBlock:(GB_ErrorBlock)errorBlock
     {
     return [[self alloc] initWithGetRequest:requestUrl successBlock:successBlock errorBlock:errorBlock];
     }
     ``` 
###

[我的博客](http://blog.csdn.net/normanv)
