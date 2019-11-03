//
//  UUCommonTableViewCell.h
//  Mos
//
//  Created by wjr on 2019/5/27.
//  Copyright © 2019 UUSafe. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol EUCommonTableViewCellDelegate <NSObject>
@optional
//点击CheckBox时调用
-(void)clickCheckBox:(NSIndexPath*)indexPath;
//点击右侧Icon时调用
-(void)clickRIcon:(NSIndexPath*)indexPath;
//点击左侧Icon时调用
-(void)clickIcon:(NSIndexPath*)indexPath;
@end


@interface EUCommonTableViewCellLayoutInfo : NSObject
//是否显示CheckBox
@property(nonatomic,assign) BOOL isShowCheckBox;
//是否显示图标
@property(nonatomic,assign) BOOL isShowIcon;
//是否显示右边图标
@property(nonatomic,assign) BOOL isShowRIcon;
//是否显示右侧文字
@property(nonatomic,assign) BOOL isShowDetail;
//checkbox image 图标大小
@property(nonatomic,assign) CGSize checkBoxImageSize;
//图标大小
@property(nonatomic,assign) CGSize iconImageSize;
//右边图标大小
@property(nonatomic,assign) CGSize riconImageSize;
//是否只布局一次
@property(nonatomic,assign) BOOL isLayoutOnce;
//内容距离左边的间距
@property(nonatomic,assign) float lDis;
//内容距离右边的间距
@property(nonatomic,assign) float rDis;
//右边图片是否可以点击
@property(nonatomic,assign) BOOL enableRicon;
//左边图片是否可以点击
@property(nonatomic,assign) BOOL enableicon;
//checkbox是否可以点击
@property(nonatomic,assign) BOOL enableCheckBox;

@end

/*
 *  @brief 主要用于单行文本 checkbox + icon + 左文本 + 右文本 + ricon
 *  @return
 */

@interface EUCommonTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView* checkBoxImageView;
@property(nonatomic,strong) UIImageView* iconImageView;
@property(nonatomic,strong) UILabel* contentLabelView;
@property(nonatomic,strong) UILabel* detailLabelView;
@property(nonatomic,strong) UIImageView* riconImageView;
@property(nonatomic,strong) UIView* bottomLine;

-(void)setLayoutInfo:(EUCommonTableViewCellLayoutInfo*)layout indexPath:(NSIndexPath*)indexPath delegate:(id<EUCommonTableViewCellDelegate>)delegate;
@end


