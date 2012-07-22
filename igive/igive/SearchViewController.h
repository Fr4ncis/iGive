//
//  SearchViewController.h
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsListViewController.h"

#import "Charity.h"

@class ResultsListViewController;

@interface SearchViewController : UIViewController <UIGestureRecognizerDelegate, ResultsListViewControllerDelegate> {
    IBOutlet UILabel *totalDonatorsLabel;
    IBOutlet UILabel *totalAmoutLabel;
    
@private
    
    Charity *_selectedCharity;
    
}

    @property (nonatomic, strong) ResultsListViewController *searchResultsController;
- (IBAction)myDonationsButtonPressed:(id)sender;

@end
