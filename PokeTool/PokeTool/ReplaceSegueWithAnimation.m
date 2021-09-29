//
//  ReplaceSegueWithAnimation.m
//  PokeTool
//
//  Created by Alex Campbell on 9/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "ReplaceSegueWithAnimation.h"

@implementation ReplaceSegueWithAnimation

//This method overrides the default Segue behavior so that,
//when a segue is performed, the destination view replaces the
//previous view on the stack, instead of being pushed on top of it.
-(void)perform
{
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    UINavigationController *navigationController = sourceViewController.navigationController;
    
    // Pop to root view controller (animated) before pushing
    [navigationController popToRootViewControllerAnimated:NO ];
    [navigationController pushViewController:destinationController animated:YES];
}


@end
