//
//  KeypadViewController.h
//  Dominoes
//
//  Created by j-btesch on 11/26/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeypadViewController : UIViewController {
    IBOutlet UILabel *display;
    //UIButton *button1;
}

@property (nonatomic, retain) UILabel *display;
- (void)buttonPressed:(id)sender;
- (void)undoLastEvent:(id)sender;
- (void)endTurn:(id)sender;
//- (UIButton*) button1;

@end
