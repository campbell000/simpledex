//
//  MoveLearnedViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 6/7/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Move.h"

@interface MoveLearnedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* moveset;
    Move* moveToSend;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

- (void) setMoveset: (NSArray*) moves;

@end
