//
//  UIView+Extensions.m
//  igive
//
//  Created by Samuel Colak on 12/14/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)


	- (UIView *) findFirstResponder { 
		
		if (self.isFirstResponder) { return self; } 
		
		for (UIView *subView in self.subviews) { 
			UIView *firstResponder = [subView findFirstResponder]; 
			if (firstResponder != nil) { return firstResponder; } 
		} 
		
		return nil; 
		
	} 

	- (UIView *) findPrevResponder {
		
		UIView *parent = [self superview];
		NSArray *views = [parent subviews];
		
		if (views.count > 0) {
			
			NSInteger counter = 0;
			
			while (counter < views.count) {
				if ([views objectAtIndex:counter] == self) {
					if (counter > 0) {
						UIView *prevobject = [views objectAtIndex:(counter-1)];
						if ([prevobject canBecomeFirstResponder]) {
							return prevobject;					
						}
					} else {
						return nil;
					}
				}			
				counter++;
			}
		}
		
		return nil;
		
	}

	- (UIView *) findNextResponder {
		
		UIView *parent = [self superview];
		NSArray *views = [parent subviews];
		
		if (views.count > 0) {
			
			NSInteger counter = 0;
			
			while (counter < views.count) {
				if ([views objectAtIndex:counter] == self) {
					if (counter < (views.count-1)) {
						UIView *nextobject = [views objectAtIndex:(counter+1)];
						if ([nextobject canBecomeFirstResponder]) {
							return nextobject;					
						}
					}
				}			
				counter++;
			}
		}
		
		return nil;
		
	}

@end
