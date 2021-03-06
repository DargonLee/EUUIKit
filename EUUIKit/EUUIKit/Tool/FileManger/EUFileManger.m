//
//  EUFileManger.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUFileManger.h"

@implementation EUFileManger

/// 把对象归档存到沙盒里
+ (void)saveObject:(id)object byFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [NSKeyedArchiver archiveRootObject:object toFile:path];
    
}
/// 通过文件名从沙盒中找到归档的对象
+ (id)getObjectByFileName:(NSString*)fileName
{
    
    NSString *path  = [self appendFilePath:fileName];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

// 根据文件名删除沙盒中的 plist 文件
+ (void)removeFileByFileName:(NSString*)fileName
{
    NSString *path  = [self appendFilePath:fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/// 拼接文件路径
+ (NSString*)appendFilePath:(NSString*)fileName
{
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *file = [NSString stringWithFormat:@"%@/%@.archiver",documentsPath,fileName];
    
    return file;
}

+ (EUFile *)scanRelatedFilePath:(NSString *)relatedFilePath
                 maxTreeLevel:(NSInteger)maxTreeLevel
{
    
    EUFile *file = nil;
    
    // Get the real file path.
    NSString *filePath = [EUFileManger theRealFilePath:relatedFilePath];
    
    // Check file exist.
    BOOL isDirectory = NO;
    BOOL isExist     = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    // If file exist, create file.
    if (isExist) {
        
        file = [EUFileManger cerateFileWithFilePath:filePath isDirectory:isDirectory];
        
        if (file.isDirectory) {
            
            [EUFileManger scanDir:file.filePath rootFile:file maxScanLevel:(maxTreeLevel <= 0 ? 0 : maxTreeLevel)];
        }
    }
    
    return file;
}

+ (BOOL)fileExistWithRealFilePath:(NSString *)theRealFilePath
{
    BOOL isDirectory = NO;
    BOOL isExist     = [[NSFileManager defaultManager] fileExistsAtPath:theRealFilePath isDirectory:&isDirectory];
    
    return isExist;
}

+ (NSString *)bundleFileWithName:(NSString *)name {
    
    return [[NSBundle mainBundle] pathForResource:name ofType:nil];
}

+ (EUFile *)cerateFileWithFilePath:(NSString *)filePath isDirectory:(BOOL)isDirectory
{
    EUFile *file        = [[EUFile alloc] init];
    file.filePath     = filePath;
    file.fileName     = [filePath lastPathComponent];
    file.isDirectory  = isDirectory;
    file.level        = 0;
    file.fileUrl      = [[NSURL alloc] initFileURLWithPath:filePath isDirectory:isDirectory];
    
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    file.attributes   = dic;
    
    NSArray *componentsStrings = [file.fileName componentsSeparatedByString:@"."];
    if (componentsStrings.count >= 2) {
        
        NSString *lastString   = componentsStrings.lastObject;
        file.name              = [file.fileName substringWithRange:NSMakeRange(0, file.fileName.length - lastString.length - 1)];
        file.filenameExtension = lastString;
        
    } else {
        
        file.name = file.fileName;
    }
    
    if ([file.fileName characterAtIndex:0] == '.') {
        
        file.isHiden = YES;
    }
    
    return file;
}

+ (void)scanDir:(NSString *)dirPath rootFile:(EUFile *)rootFile maxScanLevel:(NSInteger)maxLevel
{
    
    if (maxLevel <= rootFile.level) {
        
        return;
    }
    
    NSFileManager *localFileManager = [[NSFileManager alloc] init];
    NSArray       *array            = [localFileManager contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *relatedPath in array) {
        
        NSString *fullPath = [rootFile.filePath stringByAppendingPathComponent:relatedPath];
        
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDirectory];
        
        EUFile *file = [EUFileManger cerateFileWithFilePath:fullPath isDirectory:isDirectory];
        file.level = rootFile.level + 1;
        
        if (file.isDirectory) {
            
            [EUFileManger scanDir:file.filePath rootFile:file maxScanLevel:maxLevel];
        }
        
        [rootFile.subFiles addObject:file];
    }
}

+ (NSString *)theRealFilePath:(NSString *)relatedFilePath
{
    NSString *rootPath = nil;
    
    if (relatedFilePath.length) {
        
        if ([relatedFilePath characterAtIndex:0] == '~') {
            
            rootPath = [relatedFilePath stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:NSHomeDirectory()];
            
        } else if ([relatedFilePath characterAtIndex:0] == '-') {
            
            rootPath = [relatedFilePath stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[NSBundle mainBundle] bundlePath]];
            
        } else {
            
            rootPath = nil;
        }
        
    } else {
        
        rootPath = NSHomeDirectory();
    }
    
    return rootPath;
}

@end
