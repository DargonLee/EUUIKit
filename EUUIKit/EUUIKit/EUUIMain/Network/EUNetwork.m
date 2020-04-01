//
//  EUNetwork.m
//  EUUIKit
//
//  Created by Harlans on 2020/4/1.
//

#import "EUNetwork.h"

#define kBaseUrl        @""

#define kAccess_tokenKey   @"access_token"
#define kContent_type      @"Content-Type"
#define kMessageKey        @"message"
#define kResultKey         @"result"

@implementation EUNetwork

#pragma mark---------------------------核心方法处理--------------------------------

+ (void)GET:(NSString *)url params:(NSDictionary *)params
    success:(SuccessHandler)success
    failure:(FailureHandler)failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *requestUrl = [NSURL URLWithString:[self formatUrl:url params:params]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            success(dict);
        }else {
            failure(error);
        }
    }];
    [dataTask resume];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params
     success:(SuccessHandler)success
     failure:(FailureHandler)failure
{
    NSURL *requestUrl = [NSURL URLWithString:[self formatUrl:url]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setValue:@"application/json" forHTTPHeaderField:kContent_type];
    [request setTimeoutInterval:10.0];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[self formatDicttoinary:params] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            success(dict);
        }else {
            failure(error);
        }
    }];
    [dataTask resume];
}

+ (NSString *)formatUrl:(NSString *)url params:(NSDictionary *)params
{
    NSString *paramsString = [self formatDicttoinary:params];
    return [NSString stringWithFormat:@"%@/%@?%@",kBaseUrl,url,paramsString];
}

+ (NSString *)formatDicttoinary:(NSDictionary *)dict
{
    NSMutableString *paramsString = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *temp = [NSString stringWithFormat:@"%@=%@",key,obj];
        [paramsString appendFormat:@"%@&",temp];
        //*stop = YES;
    }];
    [paramsString deleteCharactersInRange:NSMakeRange(paramsString.length - 1, 1)];
    return paramsString;
}

+ (NSString *)formatUrl:(NSString *)url
{
    return [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
}


@end
