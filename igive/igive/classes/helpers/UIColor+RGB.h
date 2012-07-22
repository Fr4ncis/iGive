//
//  UIColor+RGB.h
//  im-at-home.com
//
//  Created by Samuel Colak on 10/19/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSVColor : NSObject

    @property (nonatomic, assign) CGFloat hue;
    @property (nonatomic, assign) CGFloat saturation;
    @property (nonatomic, assign) CGFloat brightness;

@end

@interface UIColor (Extensions)

    - (CGFloat) r;
    - (CGFloat) g;
    - (CGFloat) b;
    - (CGFloat) alpha;

    - (NSInteger) intValue;

    - (NSString *) hexStringFromColor;

    + (UIColor *) colorWithHexString: (NSString *) stringToConvert;
    + (UIColor *) colorWithRGBA:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(NSInteger)a;
    + (UIColor *) colorWithInt:(NSInteger)color;
    + (UIColor *) fromCGColor:(CGColorRef) color;

    + (HSVColor*) HSVfromRGB:(UIColor*)color;
    - (HSVColor*) toHSV;

@end
