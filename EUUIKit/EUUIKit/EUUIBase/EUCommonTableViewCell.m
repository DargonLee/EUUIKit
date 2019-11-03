//
//  UUCommonTableViewCell.m
//  Mos
//
//  Created by wjr on 2019/5/27.
//  Copyright © 2019 UUSafe. All rights reserved.
//

#import "EUCommonTableViewCell.h"

@implementation EUCommonTableViewCellLayoutInfo
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.isShowCheckBox = NO;
        self.isShowIcon = NO;
        self.isShowRIcon = NO;
        self.isShowDetail = NO;
        self.isLayoutOnce = YES;
        self.checkBoxImageSize = CGSizeMake(44, 44);
        self.iconImageSize = CGSizeMake(44, 44);
        self.riconImageSize = CGSizeMake(44, 44);
        self.lDis = 16;
        self.rDis = 16;
        self.enableicon = NO;
        self.enableRicon = NO;
        self.enableCheckBox = NO;
    }
    return self;
}
@end


@interface EUCommonTableViewCell()
@property(nonatomic,strong) EUCommonTableViewCellLayoutInfo* layout;
@property(nonatomic,strong) NSIndexPath* indexPath;
@property(nonatomic,strong) UIView* checkBoxTapView;
@property(nonatomic,strong) UIView* iconTapView;
@property(nonatomic,strong) UIView* riconTapView;
@property(nonatomic,assign) BOOL isLayout;
//协议委托者
@property(nonatomic,weak) id<EUCommonTableViewCellDelegate> delegate;
@end

@implementation EUCommonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.isLayout = NO;
        self.checkBoxImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.riconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.contentLabelView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLabelView.font = [UIFont systemFontOfSize:17];
        self.contentLabelView.textAlignment = NSTextAlignmentLeft;
        self.contentLabelView.lineBreakMode = NSLineBreakByCharWrapping;
        
        self.detailLabelView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.detailLabelView.textAlignment = NSTextAlignmentRight;
        self.detailLabelView.font = [UIFont systemFontOfSize:17];
        self.detailLabelView.lineBreakMode = NSLineBreakByCharWrapping;
        
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomLine.backgroundColor = [UIColor lightGrayColor];
        
        self.checkBoxTapView = [[UIView alloc] initWithFrame:CGRectZero];
        self.checkBoxTapView.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCheckBox)];
        tap.numberOfTapsRequired = 1;
        [self.checkBoxTapView addGestureRecognizer:tap];
        
        self.iconTapView = [[UIView alloc] initWithFrame:CGRectZero];
        self.iconTapView.userInteractionEnabled = YES;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIcon)];
        tap.numberOfTapsRequired = 1;
        [self.iconTapView addGestureRecognizer:tap];
        
        self.riconTapView = [[UIView alloc] initWithFrame:CGRectZero];
        self.riconTapView.userInteractionEnabled = YES;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRIcon)];
        tap.numberOfTapsRequired = 1;
        [self.riconTapView addGestureRecognizer:tap];
        
        
        [self.contentView addSubview:self.checkBoxTapView];
        [self.contentView addSubview:self.iconTapView];
        [self.contentView addSubview:self.riconTapView];
        
        [self.contentView addSubview:self.checkBoxImageView];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.riconImageView];
        [self.contentView addSubview:self.contentLabelView];
        [self.contentView addSubview:self.detailLabelView];
        [self.contentView addSubview:self.bottomLine];
        
//        self.contentLabelView.backgroundColor = [UIColor redColor];
//        self.detailLabelView.backgroundColor = [UIColor orangeColor];
//        self.riconImageView.backgroundColor = [UIColor redColor];
//        self.iconImageView.backgroundColor = [UIColor redColor];
//        self.checkBoxImageView.backgroundColor = [UIColor redColor];
//        self.riconTapView.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLayoutInfo:(EUCommonTableViewCellLayoutInfo*)layout indexPath:(NSIndexPath*)indexPath delegate:(id<EUCommonTableViewCellDelegate>)delegate
{
    self.layout = layout;
    self.indexPath = indexPath;
    self.delegate = delegate;
}

-(void)layoutFrame
{
    //只布局一次，适用于所有cell都一样的情况
    if (self.layout.isLayoutOnce && self.isLayout)
        return;
    
    self.isLayout = YES;
    CGSize viewSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
    float dis = 10;
    CGRect rect;
    //checkBox
    if (self.layout.isShowCheckBox)
    {
        rect = CGRectMake(self.layout.lDis, (viewSize.height - self.layout.checkBoxImageSize.height) / 2, self.layout.checkBoxImageSize.width, self.layout.checkBoxImageSize.height);
        [self.checkBoxImageView setFrame:rect];
        
        rect.origin.x = 0;
        rect.origin.y = 0;
        rect.size.width = self.layout.lDis + self.layout.checkBoxImageSize.width;
        rect.size.height = viewSize.height;
        [self.checkBoxTapView setFrame:rect];
    }
    else
    {
        [self.checkBoxImageView setFrame:CGRectZero];
        [self.checkBoxTapView setFrame:CGRectZero];
    }
    
    //icon
    if (self.layout.isShowIcon)
    {
        if (self.layout.isShowCheckBox)
            rect.origin.x = self.checkBoxImageView.frame.origin.x + self.checkBoxImageView.frame.size.width + dis;
        else
            rect.origin.x = self.layout.lDis;       
        
        rect.origin.y = (viewSize.height - self.layout.iconImageSize.height) / 2;
        rect.size = self.layout.iconImageSize;
        [self.iconImageView setFrame:rect];
        
        rect.origin.y = 0;
        rect.size.width += dis;
        rect.size.height = viewSize.height;
        [self.iconTapView setFrame:rect];
    }
    else
    {
        [self.iconImageView setFrame:CGRectZero];
        [self.iconTapView setFrame:CGRectZero];
    }
    
    //ricon
    if (self.layout.isShowRIcon)
    {
        rect.origin.x = viewSize.width - self.layout.rDis - self.layout.riconImageSize.width;
        rect.origin.y = (viewSize.height - self.layout.riconImageSize.height) / 2;
        rect.size = self.layout.riconImageSize;
        [self.riconImageView setFrame:rect];
        
        rect.origin.y = 0;
        rect.size.width += self.layout.rDis;
        rect.size.height = viewSize.height;
        [self.riconTapView setFrame:rect];
    }
    else
    {
        [self.riconImageView setFrame:CGRectZero];
        [self.riconTapView setFrame:CGRectZero];
    }
    
    //计算文本区域
    float x = self.layout.lDis;
    float maxWidth = viewSize.width;
    if (self.layout.isShowCheckBox)
        x += self.layout.checkBoxImageSize.width + dis;
    
    if (self.layout.isShowIcon)
        x += self.layout.iconImageSize.width + dis;
    
    if (self.layout.isShowRIcon)
        maxWidth -= (self.layout.rDis + self.layout.riconImageSize.width + dis);
    else
        maxWidth -= self.layout.rDis;
    
    maxWidth -= x;
    
    
    if (self.layout.isShowDetail)
    {
        //文字
        CGSize size = [self.contentLabelView sizeThatFits:CGSizeMake(maxWidth, viewSize.height)];
        size.width = ceilf(size.width);
        rect.origin.x = x;
        rect.origin.y = 0;
        rect.size.width = size.width;
        rect.size.height = viewSize.height;
        [self.contentLabelView setFrame:rect];
        
        //右侧文字
        size = [self.detailLabelView sizeThatFits:CGSizeMake(maxWidth, viewSize.height)];
        size.width = ceilf(size.width);
        rect.origin.x = x + (maxWidth - size.width);
        rect.origin.y = 0;
        rect.size.width = size.width;
        rect.size.height = viewSize.height;
        [self.detailLabelView setFrame:rect];
    }
    else
    {
        rect.origin.x = x;
        rect.origin.y = 0;
        rect.size.width = maxWidth;
        rect.size.height = viewSize.height;
        [self.contentLabelView setFrame:rect];
        [self.detailLabelView setFrame:CGRectZero];
    }
    
    //底部bottomline
    rect.origin.x = self.layout.lDis;
    rect.origin.y = viewSize.height - 1;
    rect.size.width = viewSize.width - self.layout.lDis;
    rect.size.height = 1;
    [self.bottomLine setFrame:rect];
    
    if (self.layout.enableicon)
        self.iconTapView.userInteractionEnabled = YES;
    else
        self.iconTapView.userInteractionEnabled = NO;
    
    if (self.layout.enableRicon)
        self.riconTapView.userInteractionEnabled = YES;
    else
        self.riconTapView.userInteractionEnabled = NO;
    
    if (self.layout.enableCheckBox)
        self.checkBoxTapView.userInteractionEnabled = YES;
    else
        self.checkBoxTapView.userInteractionEnabled = NO;
   
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutFrame];
}

-(void)clickCheckBox
{
    if ([self.delegate respondsToSelector:@selector(clickCheckBox:)])
    {
        [self.delegate clickCheckBox:self.indexPath];
    }
}


-(void)clickIcon
{
    if ([self.delegate respondsToSelector:@selector(clickIcon:)])
    {
        [self.delegate clickIcon:self.indexPath];
    }
}

-(void)clickRIcon
{
    if ([self.delegate respondsToSelector:@selector(clickRIcon:)])
    {
        [self.delegate clickRIcon:self.indexPath];
    }
}

@end
