//
//  PKGAttachmentManager.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/21/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKAttachmentManager.h"
#import "PKAttachment.h"

@implementation PKAttachmentManager

- (NSArray *)getAttachmentListForProjectWithId:(int)projectId {
    
    // Preparing URL for loading data using project Id.
    NSString *stringURL = [NSString stringWithFormat:@"http://91.250.82.77:8081/3ssdemo/prj/json/galleryAssets.php?projectId=%d", projectId];
  
    // Load data from some url.
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:stringURL]];
    
    // Converting received data into array.
    NSDictionary *attachmentsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *arrayOfAttachments = [attachmentsDictionary objectForKey:@"assets"];
    
    // Converting each array object into object of PKProject class.
    NSMutableArray * arrayOfPKAttachments = [NSMutableArray new];
    NSInteger objectCount = [arrayOfAttachments count];
    for (int i = 0; i < objectCount; i++) {
        id newObject = [arrayOfAttachments objectAtIndex:i];
        PKAttachment *newAttachment = [self createNewAttachmentFromDictionary:newObject];
        [arrayOfPKAttachments addObject:newAttachment];
    }
    return [arrayOfPKAttachments copy];
}


- (PKAttachment *)createNewAttachmentFromDictionary:(NSDictionary *)attachment {
    
    PKAttachment *newAttachment = [PKAttachment new];
    newAttachment.lastModifiedDate = [attachment objectForKey:@"lastModified"];
    
    NSString *escapedString = [[attachment objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    newAttachment.attachmentURL = [NSURL URLWithString:escapedString];
    
    newAttachment.attachmentType = [attachment objectForKey:@"type"];
    
    return newAttachment;
}
                                       
@end