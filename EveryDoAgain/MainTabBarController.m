//
//  MainTabBarController.m
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-21.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import "MainTabBarController.h"
#import "TodoTableViewController.h"


@interface MainTabBarController ()

@end


@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.delegate = self;

	// Load data model for initial tab
	[self loadDataModel:((UINavigationController*)self.viewControllers.firstObject).topViewController];
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


#pragma mark <UITabBarControllerDelegate>


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

	[self loadDataModel:((UINavigationController*)viewController).topViewController];
}


#pragma mark Helpers


- (void)loadDataModel:(UIViewController*)viewController {
	
	if([viewController isKindOfClass:[TodoTableViewController class]]) {
		
		// Inject MOC into todo table view controller
		TodoTableViewController* todoTableViewController = (TodoTableViewController*)viewController;
		todoTableViewController.managedObjectContext = self.managedObjectContext;
	}
}


@end
