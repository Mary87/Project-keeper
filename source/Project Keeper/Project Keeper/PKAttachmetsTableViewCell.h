//
//  PKAttachmetsTableViewCell.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/24/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKAttachmetsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *attachmentTypeName;
@property (weak, nonatomic) IBOutlet UICollectionView *attachmentCollectionView;

@end
