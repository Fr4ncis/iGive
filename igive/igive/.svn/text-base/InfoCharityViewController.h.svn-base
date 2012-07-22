//
//  InfoCharityViewController.h
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charity.h"
#import "DonateViewController.h"

@class DDPageControl;

@interface InfoCharityViewController : UIViewController <UIScrollViewDelegate, DonateViewControllerDelegate> {

    IBOutlet UIScrollView *scrollView;
    IBOutlet DDPageControl *pageControl;

    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UITextView *informationLabel;
    IBOutlet UILabel *amountDonatedLabel;
    IBOutlet UILabel *affectedLabel;
    IBOutlet UITextView *problemLabel;
    IBOutlet UITextView *solutionLabel;
    
    IBOutlet UIImageView *_charityLogo;
    IBOutlet UIImageView *_fullImage;

@private
    
    BOOL _donateVisible;
    
}

    @property (weak, nonatomic) IBOutlet UIView *imagesPage;

    @property (nonatomic, retain) DonateViewController *donateViewController;
    @property (nonatomic, retain, setter = setSelectedCharity:) Charity *selectedCharity;

    - (IBAction) donateButtonPressed:(id)sender;
    - (IBAction) goBack:(id)sender;

@end
