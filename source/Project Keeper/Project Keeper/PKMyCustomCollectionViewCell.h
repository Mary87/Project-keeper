//
//  PKMyCustomCollectionViewCell.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/21/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKAttachment.h"

@interface PKMyCustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *attachmentImage;
@property (nonatomic, strong) NSURL *expectedAttachmentURL;

- (void)updateCVCellWithAttachment:(PKAttachment *)attachment;

@end
