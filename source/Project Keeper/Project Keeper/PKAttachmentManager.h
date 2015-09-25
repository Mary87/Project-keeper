//
//  PKAtthachmentManager.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/21/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKAttachmentManager : NSObject

/**
 This method loads array of attachments for a paticular project on the basis of its Id.
 @return Array of attachmetns.
 @param projectId ID of a project for which attacment files should be returned.
 */
- (NSArray *)getAttachmentListForProjectWithId:(int)projectId;


@end
