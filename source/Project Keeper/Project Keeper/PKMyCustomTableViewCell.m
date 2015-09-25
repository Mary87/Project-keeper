//
//  PKMyCustomTableViewCell.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/14/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKMyCustomTableViewCell.h"

@implementation PKMyCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithProject:(PKProject *)project {
    self.expectedImageURL = project.projectImageURL;
    
    // Updates cell with the project name, technologoies and image of a particular project.
    self.projectNameLabel.text = project.projectName;
    self.projectTechnologiesLabel.text = project.projectTechnologies;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: project.projectImageURL];
        // [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([project.projectImageURL isEqual:self.expectedImageURL]) {
                self.projectImageView.image = [[UIImage alloc] initWithData:imageData];
            }
        });
    });
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.projectImageView.image = [UIImage imageNamed:@"television"];
}
@end
