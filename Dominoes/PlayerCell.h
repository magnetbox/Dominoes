//
//  PlayerCell.h
//  Dominoes
//
//  Created by j-btesch on 12/8/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell {
    UIView *bgColorView;
    UILabel *nameLabel;
    UILabel *scoreLabel;
    UIProgressView *progressBar;
}

@property(nonatomic,retain)UIView *bgColorView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *scoreLabel;
@property(nonatomic,retain)UIProgressView *progressBar;

@end
