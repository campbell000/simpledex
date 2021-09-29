//
//  SecondViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveDatabase.h"

@interface SecondViewController : UIViewController
{
    MoveDatabase* moveDatabase;
    NSArray* searchResults;
    BOOL isFiltered;
    Move* moveToSend;
    int count;
}

@property (weak, nonatomic) IBOutlet UITableView *moveTableView;

@end
