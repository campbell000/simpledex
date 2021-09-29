//
//  ToolsViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 1/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "ToolsViewController.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"
#import <MessageUI/MessageUI.h>

@interface ToolsViewController ()

@end

@implementation ToolsViewController
@synthesize NatureGuideButton;
@synthesize IvButton;
@synthesize aboutButton;
@synthesize typeButton;
@synthesize contactButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNatureButton];
    [self initIvButton];
    [self initTypeButton];
    [self initAboutButton];
    [self initContactButton];
    
    [ViewUtil formatBox:self.buttonBox withBorderColor:[UIColor blackColor]];
    [ViewUtil formatNavigator:self.navigationController];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    NSString* strPath = [[NSBundle mainBundle] pathForResource:@"PokemonResizeEevee" ofType:@"png"];
    UIImage* pokemonArtwork =  [UIImage imageWithContentsOfFile: strPath];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:pokemonArtwork];
    [self.buttonContainerView addSubview:backgroundView];
}

- (void) initAboutButton
{
    self.aboutButton.titleLabel.text = @"About";
    [ViewUtil formatButton:self.aboutButton];
    [self.aboutButton addTarget:self action:@selector(goToAbout)forControlEvents:UIControlEventTouchUpInside];
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
        NSArray *toRecipients = [NSArray arrayWithObjects:@"butt@butt.com", nil];
        [mail setToRecipients:toRecipients];
        
        [self presentViewController:mail animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                message:@"Sorry, your apple device isn't configured to send mail."
                delegate:nil
                cancelButtonTitle:@"Understood"
                otherButtonTitles:nil];
            [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks!"
                                                    message:@"We appreciate your feedback!"
                                                    delegate:nil
                                                    cancelButtonTitle:@"Done"
                                                    otherButtonTitles:nil];
        [alert show];
    }
    if (error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Hm, something went wrong with sending that email."
                                                    delegate:nil
                                                    cancelButtonTitle:@"Understood"
                                                    otherButtonTitles:nil];
        [alert show];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void) initNatureButton
{
    self.NatureGuideButton.titleLabel.text = @"Nature Guide";
    [ViewUtil formatButton:self.NatureGuideButton];
    
    [NatureGuideButton addTarget:self action:@selector(goToNatureGuide)forControlEvents:UIControlEventTouchUpInside];
}

- (void) initIvButton
{
    self.IvButton.titleLabel.text = @"IV Calculator";
    [ViewUtil formatButton:self.IvButton];
    
    [IvButton addTarget:self action:@selector(goToIVGuide)forControlEvents:UIControlEventTouchUpInside];
}

- (void) initTypeButton
{
    [ViewUtil formatButton:self.typeButton];
    
    [self.typeButton addTarget:self action:@selector(goToTypeGuide)forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"IvSegue"])
    {
        // Get reference to the destination view controller
        FirstViewController *vc = [segue destinationViewController];
        
        vc.title = @"Select pokemon";
    }
}

- (void) goToAbout
{
    [self performSegueWithIdentifier:@"AboutSegue" sender:Nil];
}

- (void)goToIVGuide
{
    [self performSegueWithIdentifier:@"IvSegue" sender:Nil];
}

-(void)goToNatureGuide
{
    CGSize visibleView = [self getVisibleSize];
    self.alert = [[Popup alloc] initWithFrame:CGRectMake(0, 0, visibleView.width, visibleView.height) AndImage: @"natures"];
                  
    [self.view addSubview:self.alert];
}

- (void) goToTypeGuide
{
    CGSize visibleView = [self getVisibleSize];
    self.alert = [[Popup alloc] initWithFrame:CGRectMake(0, 0, visibleView.width, visibleView.height) AndImage: @"chart"];
    
    [self.view addSubview:self.alert];
}

- (CGSize)getVisibleSize {
    CGSize result;
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        result.width = size.height;
        result.height = size.width;
    }
    else {
        result.width = size.width;
        result.height = size.height;
    }
    
    size = [[UIApplication sharedApplication] statusBarFrame].size;
    result.height -= MIN(size.width, size.height);
    
    if (self.navigationController != nil) {
        size = self.navigationController.navigationBar.frame.size;
        result.height -= MIN(size.width, size.height);
    }
    
    if (self.tabBarController != nil) {
        size = self.tabBarController.tabBar.frame.size;
        result.height -= MIN(size.width, size.height);
    }
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)statusBarFrameViewRect:(UIView*)view
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    CGRect statusBarWindowRect = [view.window convertRect:statusBarFrame fromWindow: nil];
    
    CGRect statusBarViewRect = [view convertRect:statusBarWindowRect fromView: nil];
    
    return statusBarViewRect;
}


@end
