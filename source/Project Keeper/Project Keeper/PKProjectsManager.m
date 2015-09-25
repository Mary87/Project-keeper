//
//  PKProjectsManager.m
//  Project Keeper
//
//  Created by Nevs12 on 9/15/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKProjectsManager.h"

@implementation PKProjectsManager

- (NSArray *)getProjectList {
    
    // Load data from some url.
    NSString *urlToLoadData = @"http://91.250.82.77:8081/3ssdemo/prj/json/projects.php";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlToLoadData]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *projectListData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // Converting received data into array.
    NSDictionary *projectListDictionary = [NSJSONSerialization JSONObjectWithData:projectListData options:NSJSONReadingMutableContainers error:nil];
    NSArray *arrayOfProjects = [projectListDictionary objectForKey:@"projects"];
    
    // Converting each array object into object of PKProject class.
    NSMutableArray * arrayOfPKProjects = [NSMutableArray new];
    NSInteger objectCount = [arrayOfProjects count];
    for (int i = 0; i < objectCount; i++) {
        id newObject = [arrayOfProjects objectAtIndex:i];
        [self createNewProjectFromDictionary:newObject];
        [arrayOfPKProjects addObject:[self createNewProjectFromDictionary:newObject]];
    }
    NSArray *finalArrayOfPKProjects = [NSArray arrayWithArray:arrayOfPKProjects];
    
    return finalArrayOfPKProjects;
}

- (NSArray *)getProjectListAsync {
    
    // Load data from some url.
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://91.250.82.77:8081/3ssdemo/prj/json/projects.php"]];
    
    // Converting received data into array.
    NSDictionary *projectListDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *arrayOfProjects = [projectListDictionary objectForKey:@"projects"];
        
    // Converting each array object into object of PKProject class.
    NSMutableArray * arrayOfPKProjects = [NSMutableArray new];
    NSInteger objectCount = [arrayOfProjects count];
    for (int i = 0; i < objectCount; i++) {
        id newObject = [arrayOfProjects objectAtIndex:i];
        PKProject *newProject = [self createNewProjectFromDictionary:newObject];
        [arrayOfPKProjects addObject:newProject];
    }
    return [arrayOfPKProjects copy];
}



/**
 This method createds new project object on the basis of the information which is hold in the dictionary.
 @param  dictionary Object of NSDictionary class which should be converted to PKProject class.
 @return Object of PKProject class.
 */
- (PKProject *)createNewProjectFromDictionary:(NSDictionary *)dictionary {
    // Creating of PKProject object from the Dictionary object.
    PKProject *newProject = [PKProject new];
    
    newProject.projectId = [[dictionary objectForKey:@"id"] integerValue];
    newProject.projectName = [dictionary objectForKey:@"name"];
    newProject.projectDescription = [dictionary objectForKey:@"description"];
    newProject.projectURL = [[NSURL alloc ] initWithString:[NSString stringWithFormat:@"http://%@", [dictionary objectForKey:@"url"]]];
    newProject.projectDeploymentLink = [dictionary objectForKey:@"deploymentLink"];
    newProject.projectDeepLink = [dictionary objectForKey:@"deepLink"];
    newProject.projectYear = [[dictionary objectForKey:@"year"] integerValue];
    newProject.projectOrder = [[dictionary objectForKey:@"order"] integerValue];
    newProject.projectClientId = [[dictionary objectForKey:@"clientId"] integerValue];
    newProject.projectSolutionTypes = [[[dictionary objectForKey:@"solutionTypes"] componentsJoinedByString:@", "] stringByAppendingString:@"."];
    newProject.projectTechnologies = [[[dictionary objectForKey:@"technologies"] componentsJoinedByString:@", "] stringByAppendingString:@"."];
    newProject.projectRelatedProjects = [dictionary objectForKey:@"relatedProjects"];
    newProject.projectTeamMembers = [dictionary objectForKey:@"teamMembers"];
    newProject.projectImageURL = [NSURL URLWithString:[[dictionary objectForKey:@"image"] objectForKey:@"url"]];
    newProject.projectSupportedScreens = [[[dictionary objectForKey:@"supportedScreens"] componentsJoinedByString:@", "] stringByAppendingString:@"."];
    
    return newProject;
}

@end
