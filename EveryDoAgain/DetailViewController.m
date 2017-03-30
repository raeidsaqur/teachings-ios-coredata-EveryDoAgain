//
//  DetailViewController.m
//  EveryDoAgain
//
//  Created by RS on 2015-01-01.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import "DetailViewController.h"


#
# pragma mark - Interface
#


@interface DetailViewController ()

@end


#
# pragma mark - Implementation
#


@implementation DetailViewController


#
# pragma mark Accessors
#


- (void)setTodo:(Todo*)todo {
	
	if (_todo == todo) return;
		
	_todo = todo;

	[self configureView];
}


#
# pragma mark UIViewController
#


- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Do any additional setup after loading the view, typically from a nib.
	
	self.userPickerView.dataSource = self;
	self.userPickerView.delegate = self;
	
	[self configureView];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	
	// Dispose of any resources that can be recreated.
}


#
# pragma mark <UIPickerViewDataSource>
#


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 0;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 0;
}


#
# pragma mark Helpers
#


- (void)configureView {
	
	// Update the user interface for the detail item.
	
	if (!self.todo) return;

	self.titleLabel.text = self.todo.titleText;
	self.descriptionLabel.text = self.todo.descriptionText;
}


@end
