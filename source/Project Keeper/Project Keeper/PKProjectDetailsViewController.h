//
//  PKProjectDetailsViewController.h
//  Project Keeper
//
//  Created by Mary Zelenska on 9/14/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKProject.h"
#import "PKClient.h"
#import "PKAttachment.h"

@interface PKProjectDetailsViewController : UIViewController <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) PKProject *detailedProject;
@property (strong, nonatomic) PKProject *tappedRelatedProject;
@property (strong, nonatomic) NSURL *tappedMovieURL;
@property (strong, nonatomic) NSArray *arrayOfPKClients;
@property (strong, nonatomic) NSArray *arrayOfAttachments;
@property (strong, nonatomic) NSArray *arrayOfImages;
@property (strong, nonatomic) NSArray *arrayOfMovies;
@property (strong, nonatomic) NSArray *arrayOfPdfs;
@property (strong, nonatomic) NSArray *arrayOfPKProjects;
@property (strong, nonatomic) NSArray *arrayOfRelatedProjects;

@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *clientName;
@property (weak, nonatomic) IBOutlet UIImageView *projectImage;
@property (weak, nonatomic) IBOutlet UILabel *projectDescription;
@property (weak, nonatomic) IBOutlet UILabel *solutionTypes;
@property (weak, nonatomic) IBOutlet UILabel *technologies;
@property (weak, nonatomic) IBOutlet UILabel *supportedScreens;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *relatedProjectsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *relatedProjectsSectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attachedImagesSectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attachedMoviesSectionViewHeight;

- (IBAction)openURL;




@end

