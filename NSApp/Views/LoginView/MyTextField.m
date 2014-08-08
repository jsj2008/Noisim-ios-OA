//
//  MyTextField.m
//  NSApp
//
//  Created by DongCai on 8/7/14.
//  Copyright (c) 2014 ___NoisimStudio___. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10.0f, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10.0f, bounds.origin.y, bounds.size.width, bounds.size.height);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
