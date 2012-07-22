//
//  DonateViewController.m
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "DonateViewController.h"
#import "Charity.h"
#import "Country.h"
#import "Donation.h"
#import "AppController.h"
#import "UIViewController+Extensions.h"

@interface DonateViewController ()

@end

@implementation DonateViewController
    
    @synthesize delegate;
    @synthesize selectedCharity=_selectedCharity;

    - (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void) viewDidLoad
    {
        [super viewDidLoad];
        [amountLabel setText:[NSString stringWithFormat:@"€%1.0f", round(donationSlider.value)]];
        
        // Do any additional setup after loading the view.
    }


    - (void) viewWillAppear:(BOOL)animated
    {

        [super viewWillAppear:animated];
        
    }

    - (void) viewDidUnload
    {
        [super viewDidUnload];
        // Release any retained subviews of the main view.
    }

    - (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

    - (void) smsMessageSent
    {
        [Donation new:@"Title" uid_charity:_selectedCharity.uid amount:donationSlider.value reference:@"ref" affected:0.0f];
        [delegate dialogClosed];
    }

    - (void) smsMessageCancelled
    {
        [delegate dialogClosed];
    }

    - (IBAction) close:(id)sender
    {
        if ([delegate respondsToSelector:@selector(dialogClosed)]) {
            [delegate dialogClosed];
        }
    }

    - (IBAction) sendSmsButtonPressed:(id)sender {

        if (_selectedCharity)
        {
            NSString *myId = [AppController sharedInstance].myId;
            NSString *smsString = [NSString stringWithFormat:@"%@#%@#%1.0f", _selectedCharity.uid, myId, round(donationSlider.value)];
            Country *country = [Country withId:_selectedCharity.countrycode];
            if (country)
            {
                [self sendSMS:smsString recipientList:[NSArray arrayWithObjects:country.smscode, nil]];
            }
        }
        
    }

    - (IBAction) donationAmountChanged:(id)sender {
        donationSlider.value = round(donationSlider.value);
        NSLog(@"%1.0f", round(donationSlider.value));
        [amountLabel setText:[NSString stringWithFormat:@"€%1.0f", round(donationSlider.value)]];
    }

@end
