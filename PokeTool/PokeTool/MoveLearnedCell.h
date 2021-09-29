//
//  MoveLearnedCell.h
//  PokeTool
//
//  Created by Alex Campbell on 6/7/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Move.h"

@interface MoveLearnedCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *moveName;
@property (nonatomic, weak) IBOutlet UILabel *level;
@property Move* move;

@end
