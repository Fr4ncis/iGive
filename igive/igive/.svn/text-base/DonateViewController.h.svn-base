//
//  DonateViewController.h
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Charity;

@interface DonateViewController : UIViewController {

    IBOutlet UISlider *donationSlider;
    IBOutlet UILabel  *amountLabel;
    
}

    @property (nonatomic, retain, setter = setSelectedCharity:) Charity *selectedCharity;

    - (IBAction) sendSmsButtonPressed:(id)sender;
    - (IBAction) donationAmountChanged:(id)sender;
    - (IBAction) close:(id)sender;

@end

@protocol DonateViewControllerDelegate <NSObject>

@optional

    - (void) dialogClosed;

@end

@interface DonateViewController ()

    @property (nonatomic, retain) id<DonateViewControllerDelegate> delegate;

@end