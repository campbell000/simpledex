//
//  MoveCell.h
//  PokeTool
//
//  Created by Alex Campbell on 1/10/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Move.h"

@interface MoveCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView*typeIcon;

@property (nonatomic, weak) IBOutlet UIImageView* attackClassIcon;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *powerLabel;

@property (nonatomic, weak) IBOutlet UILabel *accuracyLabel;

@property (nonatomic, weak) IBOutlet UILabel *ppLabel;

- (void) formatCell: (Move*) move;

@property Move* move;
@end
