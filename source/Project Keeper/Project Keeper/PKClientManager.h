//
//  PKClientManager.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/17/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKClientManager : NSObject

/**
 This method loads array of clients.
 @return Array of PKClient objects.
 */
- (NSArray *)getClientList;


@end
