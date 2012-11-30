//
//  KeypadViewController.h
//  Dominoes
//
//  Created by j-btesch on 11/26/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeypadViewController : UIViewController {
    IBOutlet UITextField *display;
    IBOutlet UIButton *cbutton;
}

- (UIButton*) button2;
- (UIButton*) button3;
- (UIButton*) button4;
- (UIButton*) button5;
- (UIButton*) button6;
- (UIButton*) undoButton;
- (UIButton*) doneButton;
/*
- (void)buttonPressed:(id)sender;
- (void)clearDisplay;
*/

@end
