//
//  UILabel+EUUI.m
//  EUUIKit
//
//  Created by Harlans on 2019/5/21.
//  Copyright © 2019 Harlans. All rights reserved.
//

#import "UILabel+EUUI.h"
#import "UIView+EUUI.h"

@implementation UILabel (EUUI)

- (CGRect)labelTextRect
{
    NSDictionary *dic = @{
                          NSFontAttributeName : self.font
                          };
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect;
}

- (CGFloat)labelTextHeight
{
    return [self labelTextRect].size.height + 3;
}

- (void)sizeToFitLabel
{
    self.height = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)].height;
}

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing
{
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [paragraphStyle setMinimumLineHeight:10];
    [paragraphStyle setMaximumLineHeight:20];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

@end
