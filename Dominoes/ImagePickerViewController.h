//
//  ImagePickerViewController.h
//  Dominoes
//
//  Created by j-btesch on 1/12/13.
//  Copyright (c) 2013 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerViewController : UIImagePickerController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    UIImagePickerController *picker;
}

@property (nonatomic, retain) UIImagePickerController *picker;

@end
