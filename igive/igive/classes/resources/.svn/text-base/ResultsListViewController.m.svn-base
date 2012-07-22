//
//  MyViewController.m
//  igive
//
//  Created by Francesco Mattia on 7/21/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "ResultsListViewController.h"
#import "CharityCategory.h"
#import "UIView+Extensions.h"
#import "UIColor+RGB.h"

typedef enum {
    
    kTableForCategories = 0,
    kTableForCharities = 1
    
} kTableFor;



@interface ResultsListViewController ()

@end

@implementation ResultsListViewController

    @synthesize delegate;


    @synthesize selectedCategory = _selectedCategory;
    @synthesize selectedCountry = _selectedCountry;
    @synthesize selectedCharity = _selectedCharity;
    @synthesize displayMode = _displayMode;



    BOOL shown = NO;
    BOOL categoriesShown = NO;

    - (void) setSelectedCountry:(Country *)selectedCountry
    {
        if (selectedCountry == nil) {
            _resultSetCharities = [Charity all];
            _selectedCountry = nil;
        } else {
            if ([selectedCountry.uid isEqualToString:_selectedCountry.uid]) return;
            _selectedCountry = selectedCountry;
            _resultSetCharities = [Charity allInCountry:_selectedCountry.uid];
        }
        [_tableViewCharities reloadData];
    }

    - (void) setSelectedCategory:(Category *)selectedCategory
    {
        if (selectedCategory == nil) {
            _resultSetCharities = [Charity all];
            _selectedCategory = nil;
        } else {                    
            if ([selectedCategory.uid isEqualToString:_selectedCategory.uid]) return;
            _selectedCategory = selectedCategory;
            _resultSetCharities = [CharityCategory allForCategory:_selectedCategory.uid];
        }
        [_tableViewCharities reloadData];
    }

    - (void) setDisplayMode:(kShowTypes)displayMode
    {
        _displayMode = displayMode;
        switch (_displayMode) {
            
            case kShowCategories: {
                _resultSetCategories = [Category all];
                break;
            }
                
            case kShowCountries: {
                _resultSetCategories = [Country all];
                break;
            }
                
        }
        [_tableViewCategories reloadData];
        
    }

    - (void) setSelectedCharity:(Charity *)selectedCharity
    {
        if (selectedCharity == _selectedCharity) return;
        _selectedCharity = selectedCharity;
        if ([delegate respondsToSelector:@selector(charitySelected:)]) {
            [delegate charitySelected:_selectedCharity];
        }
    }

    - (id) init
    {
        self = [super initWithNibName:@"ResultsListViewController" bundle:nil];
        if (self) {
            _resultSetCategories = [Category all];
            _resultSetCharities = [Charity all];
        }
        return self;
    }

    - (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    }

    - (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
    {
        
        if([searchText isEqualToString:@""] || searchText== nil){
            if (_selectedCategory == nil) {
                _resultSetCharities = [Charity all];
            } else {
                _resultSetCharities = _selectedCategory.charities;
            }
            [searchBar endEditing:YES];
        } else {
            _resultSetCharities = [Charity allWithTitle:searchText];
        }
        
        [_tableViewCharities reloadData];
        
    }

    - (void) searchBarCancelButtonClicked:(UISearchBar *) searchBar
    {
        [searchBar resignFirstResponder];
    }

    - (BOOL) textFieldShouldClear:(UITextField *)textField
    {
        [self performSelector:@selector(searchBarCancelButtonClicked:) withObject:_searchBar afterDelay: 0.1];
        return YES;
    }

    - (void) keyboardWillShow:(NSNotification *)notification
    {
        if (categoriesShown) {
            [self categoriesButtonPressed:nil];
        }
        _keyboardShown = YES;
    }

    - (void) keyboardWillHide:(NSNotification *)notification
    {
        _keyboardShown = NO;
    }

    - (void) viewDidLoad
    {
        [super viewDidLoad];
        
        _keyboardShown = NO;
        _displayMode = kShowCategories;
        
        for (UIView *view in _searchBar.subviews){
            if ([view isKindOfClass: [UITextField class]]) {
                UITextField *textField = (UITextField *)view;
                textField.delegate = self;
                break;
            }
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }

    - (void) segmentChanged:(id)sender
    {
        UISegmentedControl *_control = (UISegmentedControl *)sender;
        self.displayMode = (kShowTypes)_control.selectedSegmentIndex;
        
    }

    - (void) viewDidUnload
    {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
        [super viewDidUnload];
    }

    - (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

    - (IBAction) pullButtonDragged:(id)sender
    {
        
        if (shown) {
            if (!categoriesShown) {
                if (_keyboardShown) {
                    [_searchBar endEditing:YES];
                }
                shown = NO;
                [delegate viewClosed];
                [UIView beginAnimations:nil context:NULL]; // arguments are optional
                _arrowImageView.transform = CGAffineTransformMakeRotation(0);
                [UIView commitAnimations];
            }
        } else {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_tableViewCharities scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            shown = YES;
            [delegate viewDragged];
            [UIView beginAnimations:nil context:NULL]; // arguments are optional
            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
            [UIView commitAnimations];
        }
        
    }

    - (IBAction) categoriesButtonPressed:(id)sender {
        if (!_keyboardShown) {
            if (shown) {
                if (categoriesShown) {
                    [UIView animateWithDuration:0.5 animations:^{
                        _viewParentFrame.frame = CGRectMake(-231, 0, _viewParentFrame.frame.size.width, _viewParentFrame.frame.size.height);
                        _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
                        categoriesShown = NO;
                    }];
                } else {
                    [UIView animateWithDuration:0.5 animations:^{
                        _viewParentFrame.frame = CGRectMake(0, 0, _viewParentFrame.frame.size.width, _viewParentFrame.frame.size.height);
                        _arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI / 2.0);
                        categoriesShown = YES;
                    }];
                }
            }  else {
                [self pullButtonDragged:nil];
            }
        }
    }

    - (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        switch ((kTableFor)tableView.tag) {
            case kTableForCategories: {
                return _resultSetCategories.count + 1;
                break;
            }
            case kTableForCharities: {
                return _resultSetCharities.count;
                break;
            }
            default:
                break;
        }
        return 0;
    }

    - (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        switch ((kTableFor)tableView.tag) {
         
            case kTableForCategories: {
                if (indexPath.row == 0) {
                    self.selectedCategory = nil;
                    self.selectedCountry = nil;
                } else {
                    switch (_displayMode) {
                        case kShowCategories: {
                            Category *_category = (Category*) [_resultSetCategories objectAtIndex:(indexPath.row-1)];
                            self.selectedCategory = _category;
                            break;
                        }
                        case kShowCountries: {
                            Country *_country = (Country*) [_resultSetCategories objectAtIndex:(indexPath.row-1)];
                            self.selectedCountry = _country;
                            break;
                        }
                    }
                }
                break;
            }
                
            case kTableForCharities: {
                self.selectedCharity = (Charity *) [_resultSetCharities objectAtIndex:indexPath.row];
                break;
            }
                
            default: {
                break;
            }
                
        }
    }

    - (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *_cell = nil;
        
        switch ((kTableFor)tableView.tag) {
                
            case kTableForCategories: {
                
                _cell = [tableView dequeueReusableCellWithIdentifier:@"cellCategoryCell"];
                
                UILabel *_labelCategory = nil;
                UILabel *_labelNumberOfCharities = nil;
                UIView *_viewCategoryColor = nil;                
                UIImageView *_filterIndicator = nil;

                Category *_category = nil;
                Country *_country = nil;
                
                if (indexPath.row > 0) {
                    switch (_displayMode) {
                        case kShowCategories: {
                            _category = (Category *)[_resultSetCategories objectAtIndex:(indexPath.row - 1)];
                            break;
                        }
                        case kShowCountries: {
                            _country = (Country *)[_resultSetCategories objectAtIndex:(indexPath.row - 1)];
                            break;
                        }
                    }
                }
                
                if (!_cell) {
                    
                    _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellCategoryCell"];
                                        
                    _cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    _cell.backgroundColor = [UIColor colorWithRGBA:240 g:240 b:240 a:255];
                                        
                    _labelCategory = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 25.0f, tableView.frame.size.width-50.0f, 20.0f)];
                    _labelCategory.tag = 1;
                    
                    _labelCategory.font = [UIFont boldSystemFontOfSize:18.0f];
                    _labelCategory.textColor = [UIColor blackColor];
                    _labelCategory.backgroundColor = [UIColor clearColor];

                    [_cell.contentView addSubview:_labelCategory];
                    
                    _filterIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50.0f, 25.0f, 39.0f, 18.0f)];
                    _filterIndicator.tag = 4;
                    _filterIndicator.image = [UIImage imageNamed:@"filter_indicator.png"];
                    _filterIndicator.backgroundColor = [UIColor clearColor];
                    
                    [_cell.contentView addSubview:_filterIndicator];                    
                    
                    _labelNumberOfCharities = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50.0f, 25.0f, 39.0f, 18.0f)];
                    _labelNumberOfCharities.tag = 2;
                    _labelNumberOfCharities.textAlignment = UITextAlignmentCenter;
                    
                    _labelNumberOfCharities.font = [UIFont boldSystemFontOfSize:12.0f];
                    _labelNumberOfCharities.textColor = [UIColor darkGrayColor];
                    _labelNumberOfCharities.backgroundColor = [UIColor clearColor];

                    [_cell.contentView addSubview:_labelNumberOfCharities];
                    
                    _viewCategoryColor = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 3.0f, tableView.rowHeight)];
                    _viewCategoryColor.tag = 3;
                                        
                    [_cell.contentView addSubview:_viewCategoryColor];
                    
                } else {

                    _labelCategory = (UILabel *)[_cell viewWithTag:1];
                    _labelNumberOfCharities = (UILabel *)[_cell viewWithTag:2];
                    _viewCategoryColor = (UIView *)[_cell viewWithTag:3];

                }
                
                if (indexPath.row == 0) {
                    _labelCategory.text = @"ALL";
                    _labelNumberOfCharities.text = [NSString stringWithFormat:@"%d",[Charity all].count];
                } else {
                    
                    switch (_displayMode) {
                            
                        case kShowCategories: {
                            _viewCategoryColor.backgroundColor = [UIColor colorWithHexString:_category.color];
                            _labelCategory.text = _category.title;
                            _labelNumberOfCharities.text = [NSString stringWithFormat:@"%d",_category.charities.count];
                            break;
                        }
                            
                        case kShowCountries: {
                            _viewCategoryColor.backgroundColor = [UIColor clearColor];
                            _labelCategory.text = _country.title;
                            _labelNumberOfCharities.text = [NSString stringWithFormat:@"%d",_country.charities.count];
                            break;
                        }
                            
                    }
                }
                
                break;
            }

        
            case kTableForCharities: {
                
                _cell = [tableView dequeueReusableCellWithIdentifier:@"cellCharityCell"];
                
                UILabel *_labelCharity = nil;
                UILabel *_labelDescription = nil;
                
                UIImageView *_imageIsFavourite = nil;
                UIImageView *_backgroundImage = nil;

                Charity *_charity = (Charity *)[_resultSetCharities objectAtIndex:indexPath.row];
                
                if (!_cell) {
                    
                    _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellCharityCell"];
                    
                    _cell.selectionStyle = UITableViewCellSelectionStyleGray;

                    _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, tableView.rowHeight)];
                    _backgroundImage.image = [UIImage imageNamed:@"cell_bg.png"];
                    
                    [_cell.contentView addSubview:_backgroundImage];

                    _labelCharity = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 12.0f, tableView.frame.size.width-50.0f, 20.0f)];
                    _labelCharity.tag = 1;

                    _labelCharity.font = [UIFont boldSystemFontOfSize:20.0f];
                    _labelCharity.textColor = [UIColor blackColor];
                    _labelCharity.backgroundColor = [UIColor clearColor];

                    [_cell.contentView addSubview:_labelCharity];

                    _labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 35.0f, tableView.frame.size.width-50.0f, 20.0f)];
                    _labelDescription.tag = 2;

                    _labelDescription.font = [UIFont systemFontOfSize:14.0f];
                    _labelDescription.textColor = [UIColor darkGrayColor];
                    _labelDescription.backgroundColor = [UIColor clearColor];

                    [_cell.contentView addSubview:_labelDescription];
                    
//                    [_cell.contentView addSubview:_imageIsFavourite];
                    
                } else {
                    
                    _labelCharity = (UILabel *)[_cell viewWithTag:1];
                    _labelDescription = (UILabel *)[_cell viewWithTag:2];
                    
                }
                
                _labelCharity.text = _charity.title;
                _labelDescription.text = _charity.information.uppercaseString;
                
                break;
            }        
                
        }
                
        return _cell;
    }

    - (void) viewWillAppear:(BOOL)animated
    {
        [super viewWillAppear:animated];
    }

    - (void) viewDidAppear:(BOOL)animated
    {
        [super viewDidAppear:animated];
    }

@end
