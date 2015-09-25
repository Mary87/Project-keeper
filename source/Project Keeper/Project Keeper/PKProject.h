//
//  PKProject.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/15/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKProject : NSObject

@property (nonatomic, assign)int projectId;
@property (nonatomic, strong)NSString *projectName;
@property (nonatomic, strong)NSString *projectDescription;
@property (nonatomic, strong)NSURL *projectURL;
@property (nonatomic, strong)NSString *projectDeploymentLink;
@property (nonatomic, strong)NSString *projectDeepLink;
@property (nonatomic, assign)int projectYear;
@property (nonatomic, assign)int projectOrder;
@property (nonatomic, assign)int projectClientId;
@property (nonatomic, strong)NSString *projectSolutionTypes;
@property (nonatomic, strong)NSString *projectTechnologies;
@property (nonatomic, strong)NSArray *projectRelatedProjects;
@property (nonatomic, strong)NSArray *projectTeamMembers;
@property (nonatomic, strong)NSURL *projectImageURL;
@property (nonatomic, strong)NSString *projectSupportedScreens;

@end
