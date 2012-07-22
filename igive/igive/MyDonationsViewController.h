//
//  MyDonationsViewController.h
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDonationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *myDonations;
}


    - (IBAction) goBack:(id)sender;

@end
