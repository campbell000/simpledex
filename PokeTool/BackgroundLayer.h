//
//  BackgroundLayer.h
//  PokeTool
//
//  Created by Alex Campbell on 8/13/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BackgroundLayer : NSObject

+(CAGradientLayer*) greyGradient;
+(CAGradientLayer*) blueGradient;

@end