//
//  EUFileManger.h
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EUFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface EUFileManger : NSObject

/**
 把对象归档存到沙盒里

 @param object 对象
 @param fileName 文件名
 */
+ (void)saveObject:(id)object byFileName:(NSString*)fileName;

/**
 通过文件名从沙盒中找到归档的对象

 @param fileName 文件名
 @return 文件
 */
+ (id)getObjectByFileName:(NSString*)fileName;

/**
 根据文件名删除沙盒中的 plist 文件

 @param fileName 文件名
 */
+ (void)removeFileByFileName:(NSString*)fileName;

/**
 *  Get the file at the related file path.
 *
 *  @param relatedFilePath Related file path, "~" means sandbox root, "-" means bundle file root.
 *  @param maxTreeLevel    Scan level.
 *
 *  @return File.
 */
+ (EUFile *)scanRelatedFilePath:(NSString *)relatedFilePath
                 maxTreeLevel:(NSInteger)maxTreeLevel;

/**
 *  Transform related file path to real file path.
 *
 *  @param relatedFilePath Related file path, "~" means sandbox root, "-" means bundle file root.
 *
 *  @return The real file path.
 */
+ (NSString *)theRealFilePath:(NSString *)relatedFilePath;

/**
 *  Get the bundle file path by the bundle file name.
 *
 *  @param name Bundle file name.
 *
 *  @return Bundle file path.
 */
+ (NSString *)bundleFileWithName:(NSString *)name;

/**
 *  To check the file at the given file path exist or not.
 *
 *  @param theRealFilePath The real file path.
 *
 *  @return Exist or not.
 */
+ (BOOL)fileExistWithRealFilePath:(NSString *)theRealFilePath;

@end

/**
 *  Transform related file path to real file path.
 *
 *  @param relatedFilePath Related file path, "~" means sandbox root, "-" means bundle file root.
 *
 *  @return The real file path.
 */
NS_INLINE NSString *filePath(NSString * relatedFilePath) {
    
    return [EUFileManger theRealFilePath:relatedFilePath];
}

/**
 *  To check the file at the given file path exist or not.
 *
 *  @param theRealFilePath The real file path.
 *
 *  @return Exist or not.
 */
NS_INLINE BOOL fileExistWithRealFilePath(NSString * theRealFilePath) {
    
    return [EUFileManger fileExistWithRealFilePath:theRealFilePath];
}

NS_ASSUME_NONNULL_END
