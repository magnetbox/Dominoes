//
//  KeypadButton.m
//  Dominoes
//
//  Created by j-btesch on 1/13/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import "KeypadButton.h"

@implementation KeypadButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setHighlighted:(BOOL)highlighted {
    
    if(highlighted) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    }
    [super setHighlighted:highlighted];
}

@end
