//
//  UIColor+RGB.m
//  im-at-home.com
//
//  Created by Samuel Colak on 10/19/11.
//  Copyright (c) 2011 Im-At-Home BV. All rights reserved.
//

#import "UIColor+RGB.h"

#define MIN3(a,b,c)    (MIN(MIN(a,b),c))
#define MAX3(a,b,c)    (MAX(MAX(a,b),c))

@implementation HSVColor

    @synthesize hue;
    @synthesize saturation;
    @synthesize brightness;

    - (id) init
    {
        self = [super init];
        if (self) {
            hue = 0;
            saturation = 0;
            brightness = 0;
        }
        return self;
    }

@end

@implementation UIColor (Extensions)

    - (CGColorSpaceModel) colorSpaceModel  
    {  
        return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));  
    }  

    - (NSString *) colorSpaceString  
    {  
        switch ([self colorSpaceModel])  
        {  
            case kCGColorSpaceModelUnknown:  
                return @"kCGColorSpaceModelUnknown";  
            case kCGColorSpaceModelMonochrome:  
                return @"kCGColorSpaceModelMonochrome";  
            case kCGColorSpaceModelRGB:  
                return @"kCGColorSpaceModelRGB";  
            case kCGColorSpaceModelCMYK:  
                return @"kCGColorSpaceModelCMYK";  
            case kCGColorSpaceModelLab:  
                return @"kCGColorSpaceModelLab";  
            case kCGColorSpaceModelDeviceN:  
                return @"kCGColorSpaceModelDeviceN";  
            case kCGColorSpaceModelIndexed:  
                return @"kCGColorSpaceModelIndexed";  
            case kCGColorSpaceModelPattern:  
                return @"kCGColorSpaceModelPattern";  
            default:  
                return @"Not a valid color space";  
        }  
    }  

    - (BOOL) canProvideRGBComponents  
    {  
        return (([self colorSpaceModel] == kCGColorSpaceModelRGB) ||   
                ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));  
    }  

    - (CGFloat) r  
    {  
        NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");  
        const CGFloat *c = CGColorGetComponents(self.CGColor);  
        return c[0];  
    }  

    - (CGFloat) g  
    {  
        NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");  
        const CGFloat *c = CGColorGetComponents(self.CGColor);  
        if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];  
        return c[1];  
    }  

    - (CGFloat) b  
    {  
        NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use -red, -green, -blue");  
        const CGFloat *c = CGColorGetComponents(self.CGColor);  
        if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];  
        return c[2];  
    }  

    - (HSVColor *) toHSV
    {
        return [UIColor HSVfromRGB:self];
    }

    + (HSVColor*) HSVfromRGB:(UIColor*)color
    {
        
        HSVColor *hsv = [[HSVColor alloc] init];
        
        CGFloat rgb_min, rgb_max;
        
        rgb_min = MIN3(color.r, color.g, color.b);
        rgb_max = MAX3(color.r, color.g, color.b);
        
        if (rgb_max == rgb_min) {
            hsv.hue = 0;
        } else if (rgb_max == color.r) {
            hsv.hue = 60.0f * ((color.g - color.b) / (rgb_max - rgb_min));
            hsv.hue = fmodf(hsv.hue, 360.0f);
        } else if (rgb_max == color.g) {
            hsv.hue = 60.0f * ((color.b - color.r) / (rgb_max - rgb_min)) + 120.0f;
        } else if (rgb_max == color.b) {
            hsv.hue = 60.0f * ((color.r - color.g) / (rgb_max - rgb_min)) + 240.0f;
        }
        
        hsv.brightness = rgb_max;
        
        if (rgb_max == 0) {
            hsv.saturation = 0;
        } else {
            hsv.saturation = 1.0 - (rgb_min / rgb_max);
        }
        
        hsv.hue = (hsv.hue / 360.0f);
        
        return hsv;
        
    }

    - (CGFloat) alpha  
    {  
        const CGFloat *c = CGColorGetComponents(self.CGColor);  
        return c[CGColorGetNumberOfComponents(self.CGColor)-1];  
    } 

    - (NSInteger) intValue
    {
        return ((int)(self.alpha * 255) * 16777216) + ((int)(self.r * 255) * 65536) + ((int)(self.g * 255) * 256) + (int)(self.b * 255);
    }

    + (UIColor *) colorWithInt:(NSInteger)color
    {
        if (color == 0) return [UIColor clearColor];
        
        NSInteger _b = color & 255;
        NSInteger _g = color >> 8 & 255;
        NSInteger _r = color >> 16 & 255;
        NSInteger _a = color >> 24 & 255;
        
        return [self colorWithRGBA:_r g:_g b:_b a:_a];
    }

    + (UIColor *) colorWithRGBA:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(NSInteger)a
    {
        return [UIColor colorWithRed:((float) r / 255.0f)  
                               green:((float) g / 255.0f)  
                                blue:((float) b / 255.0f)  
                               alpha:((float) a / 255.0f)];  	
    }

    - (NSString *) hexStringFromColor  
    {  
        NSAssert (self.canProvideRGBComponents, @"Must be a RGB color to use hexStringFromColor");  
        
        CGFloat r, g, b;  
        r = self.r;  
        g = self.g;  
        b = self.b;  
        
        // Fix range if needed  
        if (r < 0.0f) r = 0.0f;  
        if (g < 0.0f) g = 0.0f;  
        if (b < 0.0f) b = 0.0f;  
        
        if (r > 1.0f) r = 1.0f;  
        if (g > 1.0f) g = 1.0f;  
        if (b > 1.0f) b = 1.0f;  
        
        // Convert to hex string between 0x00 and 0xFF  
        return [NSString stringWithFormat:@"%02X%02X%02X",  
                (int)(r * 255), (int)(g * 255), (int)(b * 255)];  
    } 

    + (UIColor *) colorWithHexString: (NSString *) stringToConvert  
    {  
        
        NSAssert (stringToConvert != nil, @"You must supply a string");
        
        NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
        
        // String should be 6 or 8 characters  
        if ([cString length] < 6) return [UIColor blackColor];  
        
        // strip 0X if it appears  
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];  
        
        if ([cString length] != 6) return [UIColor blackColor];  
        
        // Separate into r, g, b substrings  
        NSRange range;  
        range.location = 0;  
        range.length = 2;  
        NSString *rString = [cString substringWithRange:range];  
        
        range.location = 2;  
        NSString *gString = [cString substringWithRange:range];  
        
        range.location = 4;  
        NSString *bString = [cString substringWithRange:range];  
        
        // Scan values  
        unsigned int r, g, b;  
        [[NSScanner scannerWithString:rString] scanHexInt:&r];  
        [[NSScanner scannerWithString:gString] scanHexInt:&g];  
        [[NSScanner scannerWithString:bString] scanHexInt:&b];  
        
        return [UIColor colorWithRed:((float) r / 255.0f)  
                               green:((float) g / 255.0f)  
                                blue:((float) b / 255.0f)  
                               alpha:1.0f];  
    } 

    + (UIColor *) fromCGColor:(CGColorRef) color
    {
        const CGFloat *c = CGColorGetComponents(color);  				
        return [UIColor colorWithRed:c[0] green:c[1] blue:c[2] alpha:c[CGColorGetNumberOfComponents(color)-1]];
    }

@end
