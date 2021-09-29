//
//  MoveDetailController.h
//  PokeTool
//
//  Created by Alex Campbell on 1/13/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveDatabase.h"
#import "Move.h"

@interface MoveDetailController : UIViewController
{
    MoveDatabase* moveDatabase;
    Move* move;
}
@property (weak, nonatomic) IBOutlet UIView *statBox;

@property (weak, nonatomic) IBOutlet UIView *effectBox;
@property (weak, nonatomic) IBOutlet UIView *descBox;


- (void) setMove: (Move*) m;
- (void) formatCells;
@property (weak, nonatomic) IBOutlet UIImageView *classImageView;
@property (weak, nonatomic) IBOutlet UIImageView *textboxImageView;
@property (weak, nonatomic) IBOutlet UILabel *moveDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *ppLabel;
@property (weak, nonatomic) IBOutlet UILabel *effectLabel;

@end
