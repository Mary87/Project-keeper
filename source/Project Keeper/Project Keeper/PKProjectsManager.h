//
//  PKProjectsManager.h
//  Project Keeper
//
//  Created by Nevs12 on 9/15/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKProject.h"

@interface PKProjectsManager : NSObject

/**
 This method loads array of projects.
 @return Array of PKProject objects.
 */
- (NSArray *)getProjectList;

/**
 This method loads array of projects asynchronously.
 @return Array of PKProject objects.
 */
- (NSArray *)getProjectListAsync;



@end
