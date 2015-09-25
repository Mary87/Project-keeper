//
//  PKProjectDetailsViewController.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/14/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKProjectDetailsViewController.h"
#import "PKProjectsManager.h"
#import "PKClientManager.h"
#import "PKAttachmentManager.h"
#import "PKMyCustomCollectionViewCell.h"
#import "PKRelatedProjectsCollectionViewCell.h"
#import "PKHeaderRelatedProjectsCollection.h"
#import "PKMoviesCollectionViewCell.h"
#import "PKRelatedVideoPlayerViewController.h"

@interface PKProjectDetailsViewController ()

@end

@implementation PKProjectDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Loading information about client to display client name for a project.
    PKClientManager *newClientManager = [[PKClientManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *clients = [newClientManager getClientList];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.arrayOfPKClients = clients;
            [self configureViewWithProjectData];
            });
        });
    
    // Loading attachment files for project.
    PKAttachmentManager *newAttachmentManager = [[PKAttachmentManager alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *attachments = [newAttachmentManager getAttachmentListForProjectWithId:self.detailedProject.projectId];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.arrayOfAttachments = attachments;
            [self separateAttechmentsBetweenSections];
            [self.imagesCollectionView reloadData];
            [self.moviesCollectionView reloadData];
            });
    });
}


- (void)configureViewWithProjectData {
    if (self.detailedProject) {
        self.projectName.text = self.detailedProject.projectName;
        self.projectDescription.text = self.detailedProject.projectDescription;
        self.solutionTypes.text = self.detailedProject.projectSolutionTypes;
        self.technologies.text = self.detailedProject.projectTechnologies;
        self.supportedScreens.text = self.detailedProject.projectSupportedScreens;
        self.year.text =  [NSString stringWithFormat:@"%i", self.detailedProject.projectYear];
        
        // Getting client name for Id.
        [self getClientNameForClientWithId:self.detailedProject.projectClientId];
        
        
        // Geting image from URL.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: self.detailedProject.projectImageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.projectImage.image = [[UIImage alloc] initWithData:imageData];
            });
        });
        
        // Hidding RELATED PROJECTS SECTION if there is no related projects.
        if (self.detailedProject.projectRelatedProjects.count == 0) {
            self.relatedProjectsSectionViewHeight.constant = 0;
        }
        
        // Configuring title of the navigation bar with project name.
        self.title = self.detailedProject.projectName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** The method to display client name on detail page on the basis of client's id.
 @param ClientId Id of the client for a particular project displayed on the Detail page.
 @return Name of a client to which the project belong to.
 */
- (void)getClientNameForClientWithId:(NSInteger)clientId{
    NSInteger objectCount = [self.arrayOfPKClients count];
        for (int i = 0; i < objectCount; i++) {
            PKClient *client = [self.arrayOfPKClients objectAtIndex:i];
            if (client.clientId ==  clientId) {
                self.clientName.text = client.clientName;
            }
        }
    }

- (void)getArrayOfRelatedProjects {
    
    NSMutableArray *mutableArrayOfRelatedProjects = [NSMutableArray new];
    NSInteger relatedProjectCount = self.detailedProject.projectRelatedProjects.count;
    
    NSInteger projectsCount = [self.arrayOfPKProjects count];
    
    if (relatedProjectCount != 0) {
        for (int i = 0; i < relatedProjectCount; i++) {
            NSInteger relatedProjectId = [[self.detailedProject.projectRelatedProjects objectAtIndex:i] integerValue];
            for (int j = 0; j < projectsCount; j++) {
                PKProject *newProject = [self.arrayOfPKProjects objectAtIndex:j];
                if (newProject.projectId == relatedProjectId) {
                    [mutableArrayOfRelatedProjects addObject:newProject];
                }
            }
        }
        self.arrayOfRelatedProjects = [mutableArrayOfRelatedProjects copy];
    }
}

- (IBAction)openURL {
    [[UIApplication sharedApplication] openURL:self.detailedProject.projectURL];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.relatedProjectsCollectionView) {
        return self.detailedProject.projectRelatedProjects.count;
    }
    if (collectionView == self.imagesCollectionView) {
        return self.arrayOfImages.count;
    }
    else if (collectionView == self.moviesCollectionView) {
        return self.arrayOfMovies.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Filling attacments collection with attached images.
    if (collectionView == self.imagesCollectionView) {
        PKMyCustomCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"attachmentsCollectionViewPrototypeCell" forIndexPath:indexPath];
        PKAttachment *newAttachment = [self.arrayOfImages objectAtIndex:indexPath.row];
        [collectionViewCell updateCVCellWithAttachment:newAttachment];
        return collectionViewCell;
    }
    // Filling related projects collection view with data about related projects.
    if (collectionView == self.relatedProjectsCollectionView) {
        PKRelatedProjectsCollectionViewCell *relatatedProjectsCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"relatedProjectsCollectionViewPrototypeCell" forIndexPath:indexPath];
        [self getArrayOfRelatedProjects];
        PKProject *relatedProject = [self.arrayOfRelatedProjects objectAtIndex:indexPath.row];
        [relatatedProjectsCollectionViewCell updateCVCellWithRelatedProject:relatedProject];
        return relatatedProjectsCollectionViewCell;
    }
    // Filling movies collection with items.
    if (collectionView == self.moviesCollectionView) {
        PKMoviesCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moviesCollectionViewCell" forIndexPath:indexPath];
        return collectionViewCell;        
    }
    else return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.relatedProjectsCollectionView) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PKProjectDetailsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"project_details"];
        vc.detailedProject = [self.arrayOfRelatedProjects objectAtIndex:indexPath.row];
        vc.arrayOfPKProjects = self.arrayOfPKProjects;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (collectionView == self.moviesCollectionView) {
        PKAttachment *tappedMovie = [self.arrayOfMovies objectAtIndex:indexPath.row];
        MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:tappedMovie.attachmentURL];
        [self presentMoviePlayerViewControllerAnimated:playerVC];
    }
}

-(void)separateAttechmentsBetweenSections {
    NSMutableArray *arrayOfImages = [NSMutableArray new];
    NSMutableArray *arrayOfMovies = [NSMutableArray new];
    NSMutableArray *arrayOfPdfs = [NSMutableArray new];
    for (int i = 0; i < self.arrayOfAttachments.count; i++) {
        PKAttachment *attachment = [self.arrayOfAttachments objectAtIndex:i];
        if ([attachment.attachmentType isEqual:@"image"]) {
            [arrayOfImages addObject:self.arrayOfAttachments[i]];
        }
        if ([attachment.attachmentType isEqual:@"movie"]) {
            [arrayOfMovies addObject:self.arrayOfAttachments[i]];
        }
        if ([attachment.attachmentType isEqual:@"pdf"]) {
            [arrayOfPdfs addObject:self.arrayOfAttachments[i]];
        }
    }
    self.arrayOfImages = [arrayOfImages copy];
    self.arrayOfMovies = [arrayOfMovies copy];
    self.arrayOfPdfs = [arrayOfPdfs copy];
    
    // Hidding view if collection doesn't contain items.
    if (self.arrayOfImages.count == 0) {
        self.attachedImagesSectionViewHeight.constant = 0;
    }
    if (self.arrayOfMovies.count == 0) {
        self.attachedMoviesSectionViewHeight.constant = 0;
    }
}



//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (collectionView == self.relatedProjectsCollectionView) {
//        PKHeaderRelatedProjectsCollection *header = nil;
//        if ([kind isEqual:UICollectionElementKindSectionHeader]) {
//            header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RelatedProjectsSectionHeader" forIndexPath:indexPath];
//            header.relatedProjectsSectionName.text = @"Related projects";
//        }
//        return header;
//    }
//    if (collectionView == self.attachmentCollectionView) {
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"AttachedImages" forIndexPath:indexPath];
//        return header;
//    }
//    return nil;
//}



@end
