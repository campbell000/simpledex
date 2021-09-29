//
//  AboutViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 8/31/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ViewUtil.h"
#import "GradientButton.h"

@interface AboutViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet GradientButton *contactButton;


@end
