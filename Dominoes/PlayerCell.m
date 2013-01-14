//
//  PlayerCell.m
//  Dominoes
//
//  Created by j-btesch on 12/8/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "PlayerCell.h"
#import "PlayerProgress.h"

@implementation PlayerCell

@synthesize bgColorView, nameLabel, scoreLabel, progressBar;

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    nameLabel.frame = CGRectMake(boundsX+16, 16, 170, 25);
    scoreLabel.frame = CGRectMake(self.contentView.bounds.size.width-136, 4, 120, 50);
    progressBar.frame = CGRectMake(boundsX, contentRect.size.height-6, contentRect.size.width, 6);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        self.selectedBackgroundView = bgColorView;
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.font = [UIFont boldSystemFontOfSize:24.0];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.adjustsFontSizeToFitWidth = NO;
        nameLabel.lineBreakMode = UILineBreakModeTailTruncation;
        
        scoreLabel = [[UILabel alloc]init];
        scoreLabel.textAlignment = UITextAlignmentRight;
        scoreLabel.font = [UIFont boldSystemFontOfSize:48.0];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.adjustsFontSizeToFitWidth = NO;
        
        progressBar = [[PlayerProgress alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        //[self.contentView addSubview:bgColorView];
        [self.contentView addSubview:nameLabel];
        [self.contentView addSubview:scoreLabel];
        [self.contentView addSubview:progressBar];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
