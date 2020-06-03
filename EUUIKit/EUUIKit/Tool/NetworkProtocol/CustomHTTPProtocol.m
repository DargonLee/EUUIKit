//
//  CustomHTTPProtocol.m
//  uurskchk
//
//  Created by Harlans on 2020/5/26.
//  Copyright © 2020 Harlans. All rights reserved.
//

#import "CustomHTTPProtocol.h"

@interface CustomHTTPProtocol()<NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

static NSString * const UU_URLProtocolHandledKey = @"UU_URLProtocolHandledKey";

@implementation CustomHTTPProtocol

/// 所有注册此Protocol的请求都会经过这个方法的判断
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    // 拦截请求
    NSString * scheme = [[request.URL scheme] lowercaseString];
    if ([scheme isEqual:@"http"] || [scheme isEqual:@"https"]) {
        return YES;
    }
    //看看是否已经处理过了，防止无限循环 根据业务来截取
    if ([NSURLProtocol propertyForKey: UU_URLProtocolHandledKey inRequest:request]) {
        return NO;
    }
    return NO;
}

/// 这个方法用来统一处理请求request 对象的，可以修改头信息，或者重定向
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    if ([request.HTTPMethod isEqualToString:@"POST"]) {
        NSMutableURLRequest *request_final = [self handlePostRequestBodyWithRequest:request];
        NSLog(@"%@", request_final);
    }
    return request;
}

/// 主要判断两个request是否相同，如果相同的话可以使用缓存数据，通常只需要调用父类的实现。
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

/// 在拦截到网络请求，并且对网络请求进行定制处理以后。我们需要将网络请求重新发送出去，就可以初始化一个NSURLProtocol对象了
- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id <NSURLProtocolClient>)client
{
    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
}

- (void)startLoading
{
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //标示该request已经处理过了，防止无限循环
    [NSURLProtocol setProperty:@(YES) forKey:UU_URLProtocolHandledKey inRequest:mutableReqeust];

    //这个enableDebug随便根据自己的需求了，可以直接拦截到数据返回本地的模拟数据，进行测试
    BOOL enableDebug = NO;
    if (enableDebug) {
        NSString *str = @"$$测试数据$$";
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        //MIMEType:@"image/png"
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:mutableReqeust.URL
                                                            MIMEType:@"text/plain"
                                               expectedContentLength:data.length
                                                    textEncodingName:nil];
        [self.client URLProtocol:self
              didReceiveResponse:response
              cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else {
        //使用NSURLSession继续把request发送出去
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:mainQueue];
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.request];
        [task resume];
    }
}

- (void)stopLoading
{
    [self.session invalidateAndCancel];
    self.session = nil;
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // 打印返回数据
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr) {
        NSLog(@"***截取数据***: %@", dataStr);
    }
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        [self.client URLProtocolDidFinishLoading:self];
    }
}

#pragma mark -
#pragma mark 处理POST请求相关POST  用HTTPBodyStream来处理BODY体
+ (NSMutableURLRequest *)handlePostRequestBodyWithRequest:(NSURLRequest *)request
{
    NSMutableURLRequest * req = [request mutableCopy];
    if ([request.HTTPMethod isEqualToString:@"POST"]) {
        if (!request.HTTPBody) {
            uint8_t d[1024] = {0};
            NSInputStream *stream = request.HTTPBodyStream;
            NSMutableData *data = [[NSMutableData alloc] init];
            [stream open];
            while ([stream hasBytesAvailable]) {
                NSInteger len = [stream read:d maxLength:1024];
                if (len > 0 && stream.streamError == nil) {
                    [data appendBytes:(void *)d length:len];
                }
            }
            req.HTTPBody = [data copy];
            [stream close];
        }
    }
    return req;
}

@end
