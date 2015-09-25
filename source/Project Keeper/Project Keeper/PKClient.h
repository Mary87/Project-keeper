//
//  PKClient.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/17/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKClient : NSObject

@property (nonatomic, assign)NSInteger clientId;
@property (nonatomic, strong)NSString *clientName;
@property (nonatomic, strong)NSString *clientDescription;
@property (nonatomic, strong)NSDictionary *clientLocation;
@property (nonatomic, strong)NSURL *clientURL;
@property (nonatomic, strong)NSURL *clientImageURL;

@end
