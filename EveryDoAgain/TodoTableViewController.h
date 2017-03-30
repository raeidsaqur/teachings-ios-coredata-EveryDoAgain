//
//  MasterViewController.h
//  EveryDoAgain
//
//  Created by RS on 2015-01-01.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


#
# pragma mark - Interface
#

@interface TodoTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

#
# pragma mark Core Data Properties
#

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

