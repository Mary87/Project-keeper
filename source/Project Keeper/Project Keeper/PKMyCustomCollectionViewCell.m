//
//  PKMyCustomCollectionViewCell.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/21/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKMyCustomCollectionViewCell.h"

@implementation PKMyCustomCollectionViewCell

- (void)updateCVCellWithAttachment:(PKAttachment *)attachment {
    self.expectedAttachmentURL = attachment.attachmentURL;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: attachment.attachmentURL];
        // [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([attachment.attachmentURL isEqual:self.expectedAttachmentURL]) {
                self.attachmentImage.image = [[UIImage alloc] initWithData:imageData];
            }
        });
    });
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.attachmentImage.image = nil;
}


@end
