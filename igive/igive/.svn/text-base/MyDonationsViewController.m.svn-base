//
//  MyDonationsViewController.m
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "MyDonationsViewController.h"
#import "Donation.h"
#import "NSDate+Extensions.h"

typedef enum
{
    kCharityTag = 1,
    kCharityAmount = 2,
    kCharityAffected = 3,
    kDate = 4
} CellViewTag;

@interface MyDonationsViewController ()

@end

@implementation MyDonationsViewController

    - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        myDonations = [Donation all];
    }

    - (void)viewDidUnload
    {
        [super viewDidUnload];
        // Release any retained subviews of the main view.
    }

    - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        UILabel *charityLabel = (UILabel*)[cell viewWithTag:kCharityTag];
        UILabel *amountLabel = (UILabel*)[cell viewWithTag:kCharityAmount];
        //UILabel *affectedLabel = (UILabel*)[cell viewWithTag:kCharityAffected];
        UILabel *dateLabel = (UILabel*)[cell viewWithTag:kDate];

        Donation *cellDonation = [myDonations objectAtIndex:[indexPath row]];
        [charityLabel setText:cellDonation.charity.title];
        [amountLabel setText:[NSString stringWithFormat:@"€%@",cellDonation.amount]];
        //[affectedLabel setText:[cellDonation.affected_count stringValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM"];
        [dateLabel setText:[formatter stringFromDate:cellDonation.date_created]];

        return cell;
    }

    - (IBAction) goBack:(id)sender
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [myDonations count];
    }

@end
