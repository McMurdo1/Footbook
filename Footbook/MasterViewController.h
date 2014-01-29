//
//  MasterViewController.h
//  Footbook
//
//  Created by Matthew Graham on 1/29/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
