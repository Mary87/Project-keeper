//
//  PKAttachment.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/21/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKAttachment : NSObject

@property (nonatomic, strong)NSDate *lastModifiedDate;
@property (nonatomic, strong)NSURL *attachmentURL;
@property (nonatomic, strong)NSString *attachmentType;

@end
