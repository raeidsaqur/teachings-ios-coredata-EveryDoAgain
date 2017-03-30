//
//  MainTabBarController.h
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-21.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController <UITabBarControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
