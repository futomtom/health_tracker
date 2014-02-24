//
//  GiftCardCell.m
//  CardWallet
//
//  Created by Cody Callahan on 11/15/12.
//  Copyright (c) 2012 RCM. All rights reserved.
//

#import "GiftCardCell.h"

@implementation GiftCardCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [_ImageV.layer setCornerRadius:(_ImageV.frame.size.height/2)];
    [_ImageV.layer setMasksToBounds:YES];
    [_ImageV setContentMode:UIViewContentModeScaleAspectFill];
    [_ImageV setClipsToBounds:YES];
}


@end
