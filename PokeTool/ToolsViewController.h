//
//  ToolsViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 1/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Popup.h"
#import "FirstViewController.h"
#import <MessageUI/MessageUI.h>

@interface ToolsViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UIView *eeveeContainer;
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (strong, nonatomic) Popup *alert;
@property (weak, nonatomic) IBOutlet UIButton *NatureGuideButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *IvButton;
@property (weak, nonatomic) IBOutlet UIView *buttonBox;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;

- (CGSize) getVisibleSize;
@end
