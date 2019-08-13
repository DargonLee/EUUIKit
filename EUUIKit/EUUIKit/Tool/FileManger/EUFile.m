//
//  EUFile.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/22.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "EUFile.h"

@implementation EUFile


- (instancetype)init
{
    if (self = [super init]) {
        
        self.subFiles = [NSMutableArray array];
    }
    return self;
}

- (NSArray <EUFile *> *)allFiles
{
    NSMutableArray *subFiles = [NSMutableArray array];
    
    [self rootFile:self array:subFiles];
    
    return subFiles;
}

- (void)rootFile:(EUFile *)file array:(NSMutableArray *)array
{
    for (EUFile *subFile in file.subFiles) {
        
        [array addObject:subFile];
        
        if (subFile.isDirectory) {
            
            [self rootFile:subFile array:array];
        }
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %p> isDirectory[%@] isHiden[%@] %@",
            [self class],
            self,
            (_isDirectory == YES ? @"Y" : @"N"),
            (_isHiden == YES ? @"Y" : @"N"),
            _fileName];
}

@end
