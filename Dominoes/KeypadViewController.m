//
//  KeypadViewController.m
//  Dominoes
//
//  Created by j-btesch on 11/26/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "KeypadViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KeypadViewController ()
@end

@implementation KeypadViewController

@synthesize display;

-(id)setupDotStyle:(UIView*)dot{
    dot.layer.cornerRadius = 4;
    dot.backgroundColor = [UIColor colorWithRed:82.0f/255.0f green:92.0f/255.0f blue:105.0f/255.0f alpha:1.0f];
    dot.layer.shadowColor = [UIColor whiteColor].CGColor;
    dot.layer.shadowOpacity = 0.8;
    dot.layer.shadowRadius = 2;
    dot.layer.shadowOffset = CGSizeMake(0,2.0f);
    dot.layer.masksToBounds = NO;
    dot.clipsToBounds = YES;
    dot.userInteractionEnabled = NO;
    dot.exclusiveTouch = NO;
    return dot;
}

-(id)setupButtonStyle:(UIButton*)button{
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
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
    UIView *keypad = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-190.0f,self.view.frame.size.width,190.0f)];
    keypad.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [self.view addSubview:keypad];
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,10,50,50)];
    pointsLabel.backgroundColor = [UIColor clearColor];
    pointsLabel.text = @"Points to add:";
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont boldSystemFontOfSize:12.0];
    pointsLabel.numberOfLines = 0;
    [keypad addSubview:pointsLabel];
    
    display = [[UILabel alloc] initWithFrame:CGRectMake(75,10,500,50)];
    display.backgroundColor = [UIColor clearColor];
    display.text = @"0";
    display.textColor = [UIColor whiteColor];
    display.font = [UIFont boldSystemFontOfSize:34.0];
    [keypad addSubview:display];
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    undoButton.frame = CGRectMake(140,15,65,40);
    [undoButton setTitle:@"clear" forState:UIControlStateNormal];
    [self setupButtonStyle:undoButton];
    [undoButton addTarget:self.parentViewController action:@selector(clearDisplay) forControlEvents:UIControlEventTouchUpInside];
    [keypad addSubview:undoButton];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(215,15,65,40);
    [doneButton setTitle:@"done" forState:UIControlStateNormal];
    [self setupButtonStyle:doneButton];
    [doneButton addTarget:self.parentViewController action:@selector(endTurn:) forControlEvents:UIControlEventTouchUpInside];
    [keypad addSubview:doneButton];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(15,70,40,40);
    button1.titleLabel.hidden = YES;
    button1.tag = 1;
    [button1 addTarget:self.parentViewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setupButtonStyle:button1];
    [keypad addSubview:button1];
    
    UIView *dot1 = [[UIView alloc] initWithFrame:CGRectMake(16,16,8,8)];
    [self setupDotStyle:dot1];
    [button1 addSubview:dot1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(65,70,40,40);
    button2.tag = 2;
    [button2 addTarget:self.parentViewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self setupButtonStyle:button2];
    [keypad addSubview:button2];
    
    UIView *dot21 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot21];
    [button2 addSubview:dot21];
    UIView *dot22 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot22];
    [button2 addSubview:dot22];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(115,70,40,40);
    button3.tag = 3;
    [self setupButtonStyle:button3];
    [button3 addTarget:self.parentViewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [keypad addSubview:button3];
    
    UIView *dot31 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot31];
    [button3 addSubview:dot31];
    UIView *dot32 = [[UIView alloc] initWithFrame:CGRectMake(16,16,8,8)];
    [self setupDotStyle:dot32];
    [button3 addSubview:dot32];
    UIView *dot33 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot33];
    [button3 addSubview:dot33];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(165,70,40,40);
    button4.tag = 4;
    [self setupButtonStyle:button4];
    [button4 addTarget:self.parentViewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [keypad addSubview:button4];
    
    UIView *dot41 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot41];
    [button4 addSubview:dot41];
    UIView *dot42 = [[UIView alloc] initWithFrame:CGRectMake(26,6,8,8)];
    [self setupDotStyle:dot42];
    [button4 addSubview:dot42];
    UIView *dot43 = [[UIView alloc] initWithFrame:CGRectMake(6,26,8,8)];
    [self setupDotStyle:dot43];
    [button4 addSubview:dot43];
    UIView *dot44 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot44];
    [button4 addSubview:dot44];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(215,70,40,40);
    button5.tag = 5;
    [self setupButtonStyle:button5];
    [button5 addTarget:self.parentViewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [keypad addSubview:button5];
    
    UIView *dot51 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot51];
    [button5 addSubview:dot51];
    UIView *dot52 = [[UIView alloc] initWithFrame:CGRectMake(26,6,8,8)];
    [self setupDotStyle:dot52];
    [button5 addSubview:dot52];
    UIView *dot53 = [[UIView alloc] initWithFrame:CGRectMake(16,16,8,8)];
    [self setupDotStyle:dot53];
    [button5 addSubview:dot53];
    UIView *dot54 = [[UIView alloc] initWithFrame:CGRectMake(6,26,8,8)];
    [self setupDotStyle:dot54];
    [button5 addSubview:dot54];
    UIView *dot55 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot55];
    [button5 addSubview:dot55];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(265,70,40,40);
    button6.tag = 6;
    [self setupButtonStyle:button6];
    [button6 addTarget:self.parentViewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [keypad addSubview:button6];
    
    UIView *dot61 = [[UIView alloc] initWithFrame:CGRectMake(6,6,8,8)];
    [self setupDotStyle:dot61];
    [button6 addSubview:dot61];
    UIView *dot62 = [[UIView alloc] initWithFrame:CGRectMake(26,6,8,8)];
    [self setupDotStyle:dot62];
    [button6 addSubview:dot62];
    UIView *dot63 = [[UIView alloc] initWithFrame:CGRectMake(6,16,8,8)];
    [self setupDotStyle:dot63];
    [button6 addSubview:dot63];
    UIView *dot64 = [[UIView alloc] initWithFrame:CGRectMake(6,26,8,8)];
    [self setupDotStyle:dot64];
    [button6 addSubview:dot64];
    UIView *dot65 = [[UIView alloc] initWithFrame:CGRectMake(26,26,8,8)];
    [self setupDotStyle:dot65];
    [button6 addSubview:dot65];
    UIView *dot66 = [[UIView alloc] initWithFrame:CGRectMake(26,16,8,8)];
    [self setupDotStyle:dot66];
    [button6 addSubview:dot66];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self drawKeypad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
