//
//  PKRelatedVideoPlayerViewController.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/24/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PKRelatedVideoPlayerViewController : UIViewController

@property (strong, nonatomic) MPMoviePlayerViewController *moviePlayer;
@property (strong, nonatomic) NSURL *movieURLToBePlayed;

@end
