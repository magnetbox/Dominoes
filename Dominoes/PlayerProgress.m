//
//  PlayerProgress.m
//  Dominoes
//
//  Created by j-btesch on 12/8/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "PlayerProgress.h"

@implementation PlayerProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSInteger maxWidth = rect.size.width;
    
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding to 0% and 100% respectively.
    NSInteger curWidth = floor([self progress] * maxWidth);
    
    CGContextAddRect(context, CGRectMake(rect.origin.x, rect.origin.y, curWidth, rect.size.height));
    CGContextSetRGBFillColor(context, 255.0f, 255.0f, 255.0f, 1.0f);
    CGContextFillPath(context);
}

@end
