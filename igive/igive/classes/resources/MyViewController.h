//
//  MyViewController.h
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)pullButtonDragged:(id)sender;
- (IBAction)closeButtonPressed:(id)sender;

@end

@protocol MyViewControllerDelegate <NSObject>

@optional

- (void) viewDragged;
- (void) viewClosed;

@end

@interface MyViewController ()

    @property (nonatomic, retain) IBOutlet id<MyViewControllerDelegate>delegate;


@end