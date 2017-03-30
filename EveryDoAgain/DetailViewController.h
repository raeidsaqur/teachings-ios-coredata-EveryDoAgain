//
//  DetailViewController.h
//  EveryDoAgain
//
//  Created by RS on 2015-01-01.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"


#
# pragma mark - Interface
#

@interface DetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

#
# pragma mark Properties
#

@property (strong, nonatomic) Todo* todo;

#
# pragma mark Outlets
#
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *userPickerView;

@end

