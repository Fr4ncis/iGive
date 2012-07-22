//
//  SearchViewController.m
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsListViewController.h"
#import "InfoCharityViewController.h"
#import "Charity.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
    
    @synthesize searchResultsController;


    - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
        
        if ([segue.identifier isEqualToString:@"showCharityInfo"]) {
            InfoCharityViewController *_destinationSegue = (InfoCharityViewController*)segue.destinationViewController;
            _destinationSegue.selectedCharity = _selectedCharity;
        }
        
    }



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
        // Do any additional setup after loading the view.
        
        if (!searchResultsController) {
            searchResultsController = [[ResultsListViewController alloc] init];
            searchResultsController.delegate = self;
            searchResultsController.view.frame = CGRectMake(0, 460-(42+50), searchResultsController.view.frame.size.width, searchResultsController.view.frame.size.height);
            [self.view addSubview:searchResultsController.view];
        }
        
        [totalAmoutLabel setText:[NSString stringWithFormat:@"€%.0f",[Charity totalDonated]]];
        [totalDonatorsLabel setText:@"15"];
    }

    - (void) viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];
        self.navigationController.navigationBarHidden = YES;
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

    - (void) charitySelected:(Charity *)charity
    {
        _selectedCharity = charity;
        [self performSegueWithIdentifier:@"showCharityInfo" sender:self];
    }

    - (void) viewDragged
    {
        [UIView animateWithDuration:0.5 animations:^{
            searchResultsController.view.frame = CGRectMake(0, -(44), searchResultsController.view.frame.size.width, searchResultsController.view.frame.size.height);
        }];
    }

    - (void) viewClosed
    {
        [UIView animateWithDuration:0.5 animations:^{
            searchResultsController.view.frame = CGRectMake(0, 460-(42+50), 320, 510);
        }];
    }

    - (IBAction)myDonationsButtonPressed:(id)sender {
        [self performSegueWithIdentifier:@"myDonationsSegue" sender:self];
    }
@end
