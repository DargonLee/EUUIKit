//
//  EUFile.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUFile : NSObject


/**
 *  文件名称
 */
@property (nonatomic, strong) NSString  *fileName;

/**
 *  文件名
 */
@property (nonatomic, strong) NSString  *name;

/**
 *  文件扩展名
 */
@property (nonatomic, strong) NSString  *filenameExtension;

/**
 *  文件全路径
 */
@property (nonatomic, strong) NSString  *filePath;

/**
 *  文件Url
 */
@property (nonatomic, strong) NSURL     *fileUrl;

/**
 *  是否在目录中
 */
@property (nonatomic) BOOL       isDirectory;

/**
 *  是否隐藏文件
 */
@property (nonatomic) BOOL       isHiden;

/**
 *  文件树级别
 */
@property (nonatomic) NSInteger  level;

/**
 *  Attributes of the file.
 */
@property (nonatomic, strong) NSDictionary  *attributes;

/**
 *  子目录
 */
@property (nonatomic, strong) NSMutableArray  <EUFile *>  *subFiles;

/**
 *  所有子目录
 *
 *  @return Sub files array.
 */
- (NSArray <EUFile *> *)allFiles;

@end

NS_ASSUME_NONNULL_END
