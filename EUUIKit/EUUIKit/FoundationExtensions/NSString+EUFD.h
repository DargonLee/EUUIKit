//
//  NSString+EUFD.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/13.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EUFD)
/**
 去掉整段文字内的所有空白字符（包括换行符）
 */
@property(readonly, copy) NSString *trimAllWhiteSpace;


/**
 获取md5码
 */
@property(readonly, copy) NSString *md5;

/**
 用正则表达式匹配字符串，将匹配到的第一个结果返回，大小写不敏感
 
 @param pattern 正则表达式
 @return 匹配到的第一个结果，如果没有匹配成功则返回 nil
 */
- (NSString *)stringMatchedByPattern:(NSString *)pattern;


@end

@interface NSString (EUFD_Regex)

/**
 密码正则

 @return 正则
 */
+ (NSString *)passwordRegex;

/**
 手机号码正则

 @return 正则
 */
+ (NSString *)phoneRegex;

/**
 邮箱正则

 @return 正则
 */
+ (NSString *)emailRegex;

/**
 用户名正则

 @return 正则
 */
+ (NSString *)usernameRegex;

/**
 验证码正则

 @return 正则
 */
+ (NSString *)verificationCodeRegex;

/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)isMobileNumberClassification;
/**
 *  手机号有效性
 */
- (BOOL)isMobileNumber;

/**
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)isValidTaxNo;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;



/**
 *  判断字符串是否为空
 */
-(BOOL)isBlank;

/**
 *  MD5加密
 */
-(NSString *)md5String;

/**
 *  计算相应字体下指定宽度的字符串高度
 */
- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width;



/**
 *  JSON字符传转化成字典
 *
 *  @return 返回字典
 */
- (NSDictionary *)jsonStringToDictionary;

/**
 *  取出HTML
 *
 *  @return 返回字符串
 */
-(NSString *)htmlToString;




/**
 *  字符串加密为base64
 *
 *  @return 返回String
 */
-(NSString *)base64StringFromText;

/**
 *  加密字符串解析
 *
 *  @return 返回解析后的字符串
 */
- (NSString *)textFromBase64String;
/**
 *  将字符串转化为NSURL
 *
 *  @return  NSURL地址
 */
-(NSURL *)macUrl;
/**
 *  将资源字符串转化为图片资源
 *
 *  @return  图片
 */
-(UIImage *)macImage;

@end

NS_ASSUME_NONNULL_END
