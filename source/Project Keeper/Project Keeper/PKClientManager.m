//
//  PKClientManager.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/17/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKClientManager.h"
#import "PKClient.h"

@implementation PKClientManager

- (NSArray *)getClientList {
    
    // Load data from some url.
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://91.250.82.77:8081/3ssdemo/prj/json/clients.php"]];
    
    // Converting received data into array.
    NSDictionary *clientListDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *arrayOfClients= [clientListDictionary objectForKey:@"clients"];
    
    // Converting each array object into object of PKClient class.
    NSMutableArray * arrayOfPKClients = [NSMutableArray new];
    NSInteger objectCount = [arrayOfClients count];
    for (int i = 0; i < objectCount; i++) {
        id newObject = [arrayOfClients objectAtIndex:i];
        PKClient *newClient = [self createNewClientFromDictionary:newObject];
        [arrayOfPKClients addObject:newClient];
    }
    return [arrayOfPKClients copy];
}

- (PKClient *)createNewClientFromDictionary:(NSDictionary *)client {
    
    PKClient *newClient = [[PKClient alloc] init];
    
    newClient.clientName = [client objectForKey:@"name"];
    newClient.clientId = [[client objectForKey:@"id"] integerValue];
    newClient.clientDescription = [client objectForKey:@"description"];
    newClient.clientURL = [NSURL URLWithString:[client objectForKey:@"url"]];
    newClient.clientLocation = [client objectForKey:@"location"];
    newClient.clientImageURL = [NSURL URLWithString:[[client objectForKey:@"image"] objectForKey:@"url"]];
    
    return newClient;
}


@end
