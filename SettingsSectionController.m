//
//  SettingsSectionController.m
//  Dominoes
//
//  Created by Ben Tesch on 1/6/12.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "SettingsSectionController.h"

@implementation SettingsSectionController

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = @"SettingCell";
	
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Surface";
		cell.detailTextLabel.text = @"Park bench";
	} else if (indexPath.row == 1) {
		cell.textLabel.text = @"Play to score";
		cell.detailTextLabel.text = @"500";
	} else if (indexPath.row == 2) {
		cell.textLabel.text = @"Title";
		cell.detailTextLabel.text = @"First to 500";
	} else if (indexPath.row == 3) {
        cell.textLabel.text = @"Save as defaults";
        cell.detailTextLabel.text = @"Yes";
    }
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Settings";
}

@end
