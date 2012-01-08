//
//  PlayersSectionController.m
//  Dominoes
//
//  Created by Ben Tesch on 1/6/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "PlayersSectionController.h"

@implementation PlayersSectionController

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *cellIdentifier = @"PlayerCell";
	
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UITextField *inputField;
    
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        inputField = [[UITextField alloc] initWithFrame:CGRectMake(120,12,185,30)];
        inputField.textColor = [UIColor colorWithRed:51.0f/255.0f green:82.0f/255.0f blue:115.0f/255.0f alpha:1];
        inputField.adjustsFontSizeToFitWidth = YES;
        [cell addSubview:inputField];
	}
    inputField.keyboardType = UIKeyboardTypeDefault;
    inputField.returnKeyType = UIReturnKeyDone;
    
	NSString* rowLabel = [NSString stringWithFormat:@"Player %i", indexPath.row+1];
	cell.textLabel.text = rowLabel;
    inputField.placeholder = rowLabel;
    inputField.delegate = self;
	
	return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Players";
}

@end
