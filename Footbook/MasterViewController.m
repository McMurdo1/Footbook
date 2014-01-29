//
//  MasterViewController.m
//  Footbook
//
//  Created by Matthew Graham on 1/29/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import "MasterViewController.h"
@import CoreData;
#import "DetailViewController.h"
#import "Friend.h"
#import "Comment.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *feetName;
    NSArray *friendsArray;
    
    
    IBOutlet UITableView *feetTableView;
}

@end

@implementation MasterViewController
@synthesize managedObjectContext;
@synthesize fetchedResultsController;

- (void)viewDidLoad
{
    feetTableView.backgroundColor = [UIColor colorWithRed:0.13f green:0.14f blue:0.15f alpha:1.00f];
    
    fetchedResultsController.delegate = self;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"First Run"]) // Check if this is the initial app load
    {
        // First run; call initial load function
        [self initialLoad];
        [userDefaults setObject:[NSDate date] forKey:@"First Run"];
        [userDefaults synchronize];
    }
    [self reload];
}

-(void)initialLoad
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/3/friends.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        
        Friend *friend;
        feetName = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        for (NSString *item in feetName)
        {
            friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:managedObjectContext];
            friend.name = item;
            friend.numFeet = [NSNumber numberWithInt:(arc4random_uniform(1000))];
            friend.shoeSize = [NSNumber numberWithInt:(arc4random_uniform(1000))];
            [managedObjectContext save:nil];
        }
        [feetTableView reloadData];
    }];
}

-(void)reload
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    friendsArray = [managedObjectContext executeFetchRequest:request error:nil];
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Anything"];
    [fetchedResultsController performFetch:nil];
    [feetTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *friend = [friendsArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.shoeSize.description;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return friendsArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
}
@end
