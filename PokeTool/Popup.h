//
//  Popup.h
//  PokeTool
//
//  Created by Alex Campbell on 1/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

@interface Popup : UIView {
    UIView *content;
    UIButton *closeButton;
}
- (id)initWithFrame:(CGRect)frame AndImage: (NSString*) imageName;

- (void) close;
@end