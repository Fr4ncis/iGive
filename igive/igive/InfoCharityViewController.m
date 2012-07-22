//
//  InfoCharityViewController.m
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "InfoCharityViewController.h"
#import "DonateViewController.h"
#import "DDPageControl.h"

@interface InfoCharityViewController ()

@end

@implementation InfoCharityViewController
    
    @synthesize selectedCharity=_selectedCharity;
    @synthesize imagesPage;
    @synthesize donateViewController;

    - (void) setSelectedCharity:(Charity *)selectedCharity
    {
        _selectedCharity = selectedCharity;
    }

    - (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (IBAction) goBack:(id)sender
    {
		[self.navigationController popViewControllerAnimated:YES];
    }

    - (void) viewDidLoad
    {
        
        [super viewDidLoad];
        
        // Do any additional setup after loading the view.
        
        donateViewController = [[DonateViewController alloc] init];
        donateViewController.delegate = self;
                
        //((UIScrollView*)[[imagesPage subviews]objectAtIndex:0]).contentSize = CGSizeMake(10*110, 35);
        
    }

    - (IBAction) changeImage:(id)sender
    {
        [_fullImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%d_full.jpeg",((UIButton*)sender).tag]]];
    }

    - (void) viewDidUnload
    {
        
        [self setImagesPage:nil];
        [super viewDidUnload];
        // Release any retained subviews of the main view.

    }

    - (void) viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];
        
        UIView *dvcView = donateViewController.view;
        dvcView.frame = CGRectMake(0, 460, dvcView.frame.size.width, dvcView.frame.size.height);
        
        [self.view addSubview:donateViewController.view];

        scrollView.contentSize = [[[scrollView subviews] objectAtIndex:0] size];
        
        pageControl.numberOfPages = 2;
        pageControl.onColor = [UIColor blackColor];
        pageControl.offColor = [UIColor lightGrayColor];
        pageControl.indicatorDiameter = 10.0;
        
        [titleLabel setText:_selectedCharity.title];
        [locationLabel setText:_selectedCharity.country.title];
        [informationLabel setText:_selectedCharity.information];
        [amountDonatedLabel setText:[_selectedCharity.amount_todate stringValue]];
        [problemLabel setText:_selectedCharity.problem];
        [solutionLabel setText:_selectedCharity.solution];
        
        [affectedLabel setText:[NSString stringWithFormat:@"%.0f",_selectedCharity.affected_total.floatValue]];

        UIView *thumbnailsView = [[[[imagesPage subviews] objectAtIndex:1] subviews] objectAtIndex:0];

        for (int i = 1; i < 10; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(5+(i-1)*65, 7, 60, 40);
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpeg", i]] forState:UIControlStateNormal];
            [button setTag:i];
            
            [button addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
            
            [thumbnailsView addSubview:button];
            
        }
        
    }

    - (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

    - (IBAction) donateButtonPressed:(id)sender
    {

        if (_donateVisible) return;
        
        _donateVisible = YES;

        donateViewController.selectedCharity = _selectedCharity;

        UIView *dvcView = donateViewController.view;
        dvcView.frame = CGRectMake(0, 460, dvcView.frame.size.width, dvcView.frame.size.height);

        [UIView animateWithDuration:0.5 animations:^{
            dvcView.frame = CGRectMake(0, 460-235, dvcView.frame.size.width, dvcView.frame.size.height);
        }];

    }

    - (void) dialogClosed
    {

        if (!_donateVisible) return;
        
        _donateVisible = NO;
        
        UIView *dvcView = donateViewController.view;

        [UIView animateWithDuration:0.5 animations:^{
            dvcView.frame = CGRectMake(0, 460, dvcView.frame.size.width, dvcView.frame.size.height);
        }];
        
    }

    - (void) scrollViewDidScroll:(UIScrollView *)_scrollView
    {
        [pageControl setCurrentPage:round(_scrollView.contentOffset.x / 320.0)];
    }

@end
