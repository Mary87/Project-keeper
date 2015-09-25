//
//  PKRelatedProjectsCollectionViewCell.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/23/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKRelatedProjectsCollectionViewCell.h"

@implementation PKRelatedProjectsCollectionViewCell

- (void)updateCVCellWithRelatedProject:(PKProject *)relatedProject {
    self.relatedProjectName.text = relatedProject.projectName;
    
    // Loading images for related projects.
    self.expectedRelatedProjectImageURL = relatedProject.projectImageURL;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: relatedProject.projectImageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([relatedProject.projectImageURL isEqual:self.expectedRelatedProjectImageURL]) {
                self.relatedProjectImage.image = [[UIImage alloc] initWithData:imageData];
            }
        });
    });
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.relatedProjectImage.image = nil;
}

@end
