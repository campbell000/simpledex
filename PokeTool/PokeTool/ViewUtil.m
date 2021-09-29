//
//  ViewUtil.m
//  PokeTool
//
//  Created by Alex Campbell on 7/12/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//
//
// This class contains methods that are performed multiple times
// throughout the app.
//
//

#import "ViewUtil.h"


@implementation ViewUtil


+ (void) formatNavigator: (UINavigationController*) navController
{
    //Add Stylized White text to nav bar
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [navController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    //Make nav bar blue
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        navController.navigationBar.barTintColor = [ViewUtil customColorRed:16 green:73 blue:158];
        navController.navigationBar.tintColor = [ViewUtil customColorRed:255 green:255 blue:255];
    }
    else
    {
        navController.navigationBar.tintColor = [ViewUtil customColorRed:16 green:73 blue:158];
    }
}

+ (void) formatTableView: (UITableView*) tableView
{
    tableView.sectionFooterHeight = 4;
    tableView.sectionHeaderHeight = 0;
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.opaque = NO;
    tableView.backgroundView = nil;
}

+ (void) formatTableCell: (UITableViewCell*) cell
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        cell.layer.borderColor = [ViewUtil customColorRed:16 green:73 blue:158].CGColor;
        cell.layer.borderWidth = 2;
    }
    [cell.layer setCornerRadius:10.0];
    [cell.layer setMasksToBounds:YES];
}

+ (void) formatImage: (UIImageView*) image
{
    image.layer.borderColor = [ViewUtil customColorRed:16 green:73 blue:158].CGColor;
    image.layer.borderWidth = 2.0;
    [image.layer setMasksToBounds:YES];
    [image.layer setCornerRadius:3.0];
}

+ (void) formatImage: (UIImageView*) image withColor: (UIColor*)color
{
    image.layer.borderColor = color.CGColor;
    image.layer.borderWidth = 2.0;
    [image.layer setMasksToBounds:YES];
    [image.layer setCornerRadius:3.0];
}

+ (void) formatButton: (UIButton*) image withColor: (UIColor*)color
{
    image.layer.borderColor = color.CGColor;
    image.layer.borderWidth = 2.0;
    [image.layer setMasksToBounds:YES];
    [image.layer setCornerRadius:3.0];
}

+ (void) formatBox: (UIView*) box withBorderColor: (UIColor*)color
{
    box.layer.borderColor = color.CGColor;
    box.layer.borderWidth = 3;
    [box.layer setCornerRadius:10.0];
}

+ (void) formatBox: (UIView*) box
{
    box.layer.borderColor = [ViewUtil customColorRed:16 green:73 blue:158].CGColor;
    box.layer.borderWidth = 2.5;
    [box.layer setCornerRadius:10.0];
    
}

+ (void) formatButton: (UIButton*) button
{
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = .5;
    [button.layer setCornerRadius:10.0];
}

+ (void) formatText: (UILabel*) text
{
    text.layer.shadowColor = [[UIColor blackColor] CGColor];
    text.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    text.layer.shadowOpacity = 1.0f;
    text.layer.shadowRadius = 1.0f;
}

+ (UIColor*) customColorRed: (int) red green: (int)green blue: (int) blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue: blue/255.0 alpha: 1.0];
}

+ (void) createAlert: (NSString*) text withTitle: (NSString*) title withButtonText: (NSString*) buttonText
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:text
                                                   delegate:nil
                                          cancelButtonTitle:buttonText
                                          otherButtonTitles:nil];
    [alert show];
}

@end
