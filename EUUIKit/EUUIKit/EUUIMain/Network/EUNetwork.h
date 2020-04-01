//
//  EUNetwork.h
//  EUUIKit
//
//  Created by Harlans on 2020/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SuccessHandler)(NSDictionary * _Nullable responseObject);
typedef void (^FailureHandler)(NSError *_Nonnull error);

@interface EUNetwork : NSObject

+ (void)GET:(NSString *)url params:(NSDictionary *)params
    success:(SuccessHandler)success
    failure:(FailureHandler)failure;


+ (void)POST:(NSString *)url params:(NSDictionary *)params
     success:(SuccessHandler)success
     failure:(FailureHandler)failure;

@end

NS_ASSUME_NONNULL_END
