//
//  KeypadView.m
//  Dominoes
//
//  Created by j-btesch on 12/30/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "KeypadView.h"
#import "KeypadButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation KeypadView

@synthesize display;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self drawKeypad];
    }
    return self;
}

-(id)setupDotsStyle:(UIView*)dots{
    dots.userInteractionEnabled = NO;
    dots.exclusiveTouch = NO;
    return dots;
}

-(id)setupDotStyle:(UIView*)dot{
    dot.layer.cornerRadius = 5;
    dot.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f];
    dot.layer.shadowColor = [UIColor whiteColor].CGColor;
    dot.layer.shadowOpacity = 0.8;
    dot.layer.shadowRadius = 2.5;
    dot.layer.shadowOffset = CGSizeMake(0,2.5f);
    dot.layer.masksToBounds = NO;
    dot.clipsToBounds = NO;
    dot.userInteractionEnabled = NO;
    dot.exclusiveTouch = NO;
    return dot;
}

-(id)setupButtonStyle:(UIButton*)button{
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:40.0];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(-6.0f, 0.0f, 0.0f, 0.0f)];
    [button setTitleColor:[UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0f alpha:0.8f] forState:UIControlStateNormal];
    [button.titleLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    button.layer.cornerRadius = 3;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOpacity = 0.7;
    button.layer.shadowRadius = 2;
    button.layer.shadowOffset = CGSizeMake(0,2.0f);
    button.layer.masksToBounds = NO;
    return button;
}

- (void)drawKeypad
{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,10,50,50)];
    pointsLabel.backgroundColor = [UIColor clearColor];
    pointsLabel.text = @"Points to add:";
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont boldSystemFontOfSize:12.0];
    pointsLabel.numberOfLines = 0;
    [self addSubview:pointsLabel];
    
    display = [[UILabel alloc] initWithFrame:CGRectMake(75,10,500,50)];
    display.backgroundColor = [UIColor clearColor];
    display.text = @"0";
    display.textColor = [UIColor whiteColor];
    display.font = [UIFont boldSystemFontOfSize:48.0];
    [self addSubview:display];
    
    KeypadButton *undoButton = [KeypadButton buttonWithType:UIButtonTypeCustom];
    undoButton.frame = CGRectMake(142,12,66,44);
    [undoButton setTitle:@"–" forState:UIControlStateNormal];
    [self setupButtonStyle:undoButton];
    [undoButton addTarget:self.superview action:@selector(undoMove) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:undoButton];
    
    KeypadButton *doneButton = [KeypadButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(216,12,66,44);
    [doneButton setTitle:@"+" forState:UIControlStateNormal];
    [self setupButtonStyle:doneButton];
    [doneButton addTarget:self.superview action:@selector(endTurn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneButton];
    
    KeypadButton *button1 = [KeypadButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(8,70,44,88);
    button1.titleLabel.hidden = YES;
    button1.tag = 1;
    [button1 addTarget:self.superview action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setupButtonStyle:button1];
    [self addSubview:button1];
    
    CGRect buttonCenter = CGRectMake(1,22,44,44);
    
    UIView *dot1s = [[UIView alloc] initWithFrame:buttonCenter];
    [self setupDotsStyle:dot1s];
    UIView *dot1 = [[UIView alloc] initWithFrame:CGRectMake(16,16,10,10)];
    [self setupDotStyle:dot1];
    [dot1s addSubview:dot1];
    [button1 addSubview:dot1s];
    
    KeypadButton *button2 = [KeypadButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(60,70,44,88);
    button2.tag = 2;
    [button2 addTarget:self.superview action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setupButtonStyle:button2];
    [self addSubview:button2];
    
    UIView *dot2s = [[UIView alloc] initWithFrame:buttonCenter];
    [self setupDotsStyle:dot2s];
    UIView *dot21 = [[UIView alloc] initWithFrame:CGRectMake(4,4,10,10)];
    [self setupDotStyle:dot21];
    [dot2s addSubview:dot21];
    UIView *dot22 = [[UIView alloc] initWithFrame:CGRectMake(28,28,10,10)];
    [self setupDotStyle:dot22];
    [dot2s addSubview:dot22];
    [button2 addSubview:dot2s];
    
    KeypadButton *button3 = [KeypadButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(112,70,44,88);
    button3.tag = 3;
    [self setupButtonStyle:button3];
    [button3 addTarget:self.superview action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
    
    UIView *dot3s = [[UIView alloc] initWithFrame:buttonCenter];
    [self setupDotsStyle:dot3s];
    UIView *dot31 = [[UIView alloc] initWithFrame:CGRectMake(4,4,10,10)];
    [self setupDotStyle:dot31];
    [dot3s addSubview:dot31];
    UIView *dot32 = [[UIView alloc] initWithFrame:CGRectMake(16,16,10,10)];
    [self setupDotStyle:dot32];
    [dot3s addSubview:dot32];
    UIView *dot33 = [[UIView alloc] initWithFrame:CGRectMake(28,28,10,10)];
    [self setupDotStyle:dot33];
    [dot3s addSubview:dot33];
    [button3 addSubview:dot3s];
    
    KeypadButton *button4 = [KeypadButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(164,70,44,88);
    button4.tag = 4;
    [self setupButtonStyle:button4];
    [button4 addTarget:self.superview action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button4];
    
    UIView *dot4s = [[UIView alloc] initWithFrame:buttonCenter];
    [self setupDotsStyle:dot4s];
    UIView *dot41 = [[UIView alloc] initWithFrame:CGRectMake(4,4,10,10)];
    [self setupDotStyle:dot41];
    [dot4s addSubview:dot41];
    UIView *dot42 = [[UIView alloc] initWithFrame:CGRectMake(28,4,10,10)];
    [self setupDotStyle:dot42];
    [dot4s addSubview:dot42];
    UIView *dot43 = [[UIView alloc] initWithFrame:CGRectMake(4,28,10,10)];
    [self setupDotStyle:dot43];
    [dot4s addSubview:dot43];
    UIView *dot44 = [[UIView alloc] initWithFrame:CGRectMake(28,28,10,10)];
    [self setupDotStyle:dot44];
    [dot4s addSubview:dot44];\
    [button4 addSubview:dot4s];
    
    KeypadButton *button5 = [KeypadButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(216,70,44,88);
    button5.tag = 5;
    [self setupButtonStyle:button5];
    [button5 addTarget:self.superview action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button5];
    
    UIView *dot5s = [[UIView alloc] initWithFrame:buttonCenter];
    [self setupDotsStyle:dot5s];
    UIView *dot51 = [[UIView alloc] initWithFrame:CGRectMake(4,4,10,10)];
    [self setupDotStyle:dot51];
    [dot5s addSubview:dot51];
    UIView *dot52 = [[UIView alloc] initWithFrame:CGRectMake(28,4,10,10)];
    [self setupDotStyle:dot52];
    [dot5s addSubview:dot52];
    UIView *dot53 = [[UIView alloc] initWithFrame:CGRectMake(16,16,10,10)];
    [self setupDotStyle:dot53];
    [dot5s addSubview:dot53];
    UIView *dot54 = [[UIView alloc] initWithFrame:CGRectMake(4,28,10,10)];
    [self setupDotStyle:dot54];
    [dot5s addSubview:dot54];
    UIView *dot55 = [[UIView alloc] initWithFrame:CGRectMake(28,28,10,10)];
    [self setupDotStyle:dot55];
    [dot5s addSubview:dot55];
    [button5 addSubview:dot5s];
    
    KeypadButton *button6 = [KeypadButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(268,70,44,88);
    button6.tag = 6;
    [self setupButtonStyle:button6];
    [button6 addTarget:self.superview action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button6];
    
    UIView *dot6s = [[UIView alloc] initWithFrame:buttonCenter];
    [self setupDotsStyle:dot6s];
    UIView *dot61 = [[UIView alloc] initWithFrame:CGRectMake(4,4,10,10)];
    [self setupDotStyle:dot61];
    [dot6s addSubview:dot61];
    UIView *dot62 = [[UIView alloc] initWithFrame:CGRectMake(28,4,10,10)];
    [self setupDotStyle:dot62];
    [dot6s addSubview:dot62];
    UIView *dot63 = [[UIView alloc] initWithFrame:CGRectMake(4,16,10,10)];
    [self setupDotStyle:dot63];
    [dot6s addSubview:dot63];
    UIView *dot64 = [[UIView alloc] initWithFrame:CGRectMake(4,28,10,10)];
    [self setupDotStyle:dot64];
    [dot6s addSubview:dot64];
    UIView *dot65 = [[UIView alloc] initWithFrame:CGRectMake(28,28,10,10)];
    [self setupDotStyle:dot65];
    [dot6s addSubview:dot65];
    UIView *dot66 = [[UIView alloc] initWithFrame:CGRectMake(28,16,10,10)];
    [self setupDotStyle:dot66];
    [dot6s addSubview:dot66];
    [button6 addSubview:dot6s];
    
}

@end
