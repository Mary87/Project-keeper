//
//  PKProjectListTableViewController.m
//  Project Keeper
//
//  Created by Mary Zelenska on 9/14/15.
//  Copyright (c) 2015 3ss. All rights reserved.
//

#import "PKProjectListTableViewController.h"
#import "PKProjectsManager.h"
#import "PKProject.h"
#import "PKMyCustomTableViewCell.h"
#import "PKProjectDetailsViewController.h"


@interface PKProjectListTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *arrayOfSearchResults;


@end


@implementation PKProjectListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;

    self.arrayOfSearchResults = [NSMutableArray new];
    
    
    // Getting the list of projects from manager.
    
    PKProjectsManager *newManager = [PKProjectsManager new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *projects = [newManager getProjectListAsync];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.arrayOfProjects = projects;
            [self.tableView reloadData];
        });
    });
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)arrayToDisplay {
    if (self.searchController.active) {
        return self.arrayOfSearchResults;
    }
    return self.arrayOfProjects;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrayToDisplay] count];
}


#pragma mark - Table Design
#pragma -


// Methods to make the separation line having full width.

-(void)tableView:(UITableView *)tableView willDisplayCell:(PKMyCustomTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Displaying the content of each cell in the table.
    
    PKMyCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrototypeProjectCell" forIndexPath:indexPath];
    PKProject *pkProject = [[self arrayToDisplay] objectAtIndex:indexPath.row];
    
    [cell updateCellWithProject:pkProject];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// Method for passing tapped project to the segue using index path of the tapped row.

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetails"]) {
        
        // 1. Define index path of the tapped row.
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // 2. Find the object in arraw which corresponds to the index path of tapped row.
        PKProject *selectedProject = [[self arrayToDisplay] objectAtIndex:indexPath.row];
        
        // 3. Call of PKProjectDetailsViewController and setting his instance veriable with the selected project.
        [[segue destinationViewController] setDetailedProject:selectedProject];
        
        // 4. Call of PKProjectDetailsViewController and setting his instance veriable with the array of all projects.
        [[segue destinationViewController] setArrayOfPKProjects:self.arrayOfProjects];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = self.searchController.searchBar.text;
    [self.arrayOfSearchResults removeAllObjects];
    for (PKProject *tempPKProject in self.arrayOfProjects) {
        NSComparisonResult result = [tempPKProject.projectName compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [self.arrayOfSearchResults addObject:tempPKProject];
        }
    }
    [self.tableView reloadData];
}

@end
