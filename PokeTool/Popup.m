//
//  Popup.m
//  PokeTool
//
//  Created by Alex Campbell on 1/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "Popup.h"
#import <QuartzCore/QuartzCore.h>
@implementation Popup

- (id)initWithFrame:(CGRect)frame AndImage: (NSString*) imageName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        content = [[UIView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-5, frame.size.height-5)];
        content.layer.borderWidth = 3.0;
        content.clipsToBounds = NO;
        content.layer.cornerRadius = 15.0;
        [self addSubview:content];
        
        //Add image to popup
        NSString* strPath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        UIImage* image =  [UIImage imageWithContentsOfFile: strPath];
        UIImageView *pinMarkerView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:pinMarkerView];
        pinMarkerView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        //Add close button last, so it appears on top
        strPath = [[NSBundle mainBundle] pathForResource:@"closeButton" ofType:@"png"];
        UIImage* closeImage =  [UIImage imageWithContentsOfFile: strPath];

        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(0, 0, 20, 20);
        closeButton.layer.cornerRadius = 10;
        [closeButton setBackgroundImage:closeImage forState:UIControlStateNormal];
        [closeButton addTarget:self
                  action:@selector(close)
        forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:closeButton];
        

    }
    return self;
}

-(void) close
{
    [self removeFromSuperview];
}
@end