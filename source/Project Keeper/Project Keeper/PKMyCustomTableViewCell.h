//
//  PKMyCustomTableViewCell.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/14/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKProject.h"

@interface PKMyCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTechnologiesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UIView *viewForImage;
@property (nonatomic, strong) NSURL *expectedImageURL;

/**
 This method updates a cell of the table view with the project name, technologies and project image.
 @param project Project for which the information should be loaded.
 */
- (void)updateCellWithProject:(PKProject *)project;

@end
