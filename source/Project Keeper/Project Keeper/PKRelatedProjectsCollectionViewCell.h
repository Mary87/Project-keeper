//
//  PKRelatedProjectsCollectionViewCell.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/23/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKProject.h"

@interface PKRelatedProjectsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)NSURL *expectedRelatedProjectImageURL;
@property (weak, nonatomic) IBOutlet UIImageView *relatedProjectImage;
@property (weak, nonatomic) IBOutlet UILabel *relatedProjectName;

- (void)updateCVCellWithRelatedProject:(PKProject *)relatedProject;

@end
