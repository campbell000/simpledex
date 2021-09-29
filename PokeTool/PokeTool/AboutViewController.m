//
//  AboutViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 8/31/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "AboutViewController.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initContactButton];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}


- (void) initContactButton
{
    [ViewUtil formatButton:self.contactButton];
    [self.contactButton addTarget:self action:@selector(emailAlex)forControlEvents:UIControlEventTouchUpInside];
}

- (void) emailAlex
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Iphone App Feedback"];
        [mail setMessageBody:@"Put your comment or suggestions here:" isHTML:NO];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"ac.simpledex@gmail.com", nil];
        [mail setToRecipients:toRecipients];
        
        [self presentViewController:mail animated:YES completion:nil];
    }
    else
    {
        [ViewUtil createAlert:@"Sorry, your apple device isn't configured to send emails" withTitle:@"Email Whited Out..." withButtonText:@"Understood"];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result)
        [ViewUtil createAlert:@"We appreciate your feedback!" withTitle:@"Thanks!" withButtonText:@"Done"];

    if (error)
    {
        [ViewUtil createAlert:@"Hm, something went wrong with sending that email. Check your internet connection and try again." withTitle:@"Email was not very effective..." withButtonText:@"Understood"];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
