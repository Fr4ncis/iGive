//
//  MyViewController.h
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Charity.h"
#import "Category.h"
#import "Country.h"

typedef enum {
    kShowCategories = 0,
    kShowCountries = 1
} kShowTypes;

@interface ResultsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate> {

    IBOutlet UITableView            *_tableViewCategories;
    IBOutlet UITableView            *_tableViewCharities;
    IBOutlet UIView                 *_viewParentFrame;
    IBOutlet UISearchBar            *_searchBar;
    IBOutlet UIImageView            *_arrowImageView;
    IBOutlet UISegmentedControl     *_segmentControl;
    
@private
    
    NSArray     *_resultSetCategories;
    NSArray     *_resultSetCharities;
    BOOL        _keyboardShown;
    
    kShowTypes  _displayMode;
    
}

    @property (nonatomic, retain, setter = setSelectedCategory:) IBOutlet Category* selectedCategory;
    @property (nonatomic, retain, setter = setSelectedCountry:) IBOutlet Country* selectedCountry;

    @property (nonatomic, retain, setter = setSelectedCharity:) IBOutlet Charity* selectedCharity;
    @property (nonatomic, assign, setter = setDisplayMode:) kShowTypes displayMode;

    - (IBAction) pullButtonDragged:(id)sender;
    - (IBAction) categoriesButtonPressed:(id)sender;

    - (IBAction) segmentChanged:(id)sender;

@end

@protocol ResultsListViewControllerDelegate <NSObject>

@optional

    - (void) charitySelected:(Charity *)charity;
    - (void) viewDragged;
    - (void) viewClosed;

@end

@interface ResultsListViewController ()

    @property (nonatomic, retain) IBOutlet id<ResultsListViewControllerDelegate>delegate;

@end