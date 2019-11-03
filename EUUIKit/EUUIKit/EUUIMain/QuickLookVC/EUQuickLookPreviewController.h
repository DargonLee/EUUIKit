//
//  EUQuickLookPreviewController.h
//  EUUIKit
//
//  Created by Harlan on 2019/11/3.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EUQuickLookPreviewController : UIViewController

// 预览文件URL
@property (strong, nonatomic) NSURL *previewItemURL;
// 是否以present方式展现
@property (nonatomic) BOOL isPresent;
//文件名
@property(nonatomic,copy) NSString* titleString;

//打开文件
- (void)openFile:(NSString*)filePath;
//打开文件
- (void)openFile:(NSString*)filePath title:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
