//
//  PKRelatedVideoPlayerViewController.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/24/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKRelatedVideoPlayerViewController.h"

@interface PKRelatedVideoPlayerViewController ()

@end

@implementation PKRelatedVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    self.moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:self.movieURLToBePlayed];
    [self.moviePlayer.view setFrame:CGRectMake(0, 0, 300, 200)];
    [self.view addSubview:self.moviePlayer.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
