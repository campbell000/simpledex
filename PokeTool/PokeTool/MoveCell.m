//
//  MoveCell.m
//  PokeTool
//
//  Created by Alex Campbell on 1/10/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "MoveCell.h"
#import "MoveDatabase.h"

@implementation MoveCell
@synthesize nameLabel = _nameLabel;
@synthesize typeIcon = _typeIcon;
@synthesize attackClassIcon = _attackClassIcon;
@synthesize powerLabel = _powerLabel;
@synthesize accuracyLabel = _accuracyLabel;
@synthesize ppLabel = _ppLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) formatCell: (Move*) move
{
    //Assign cell a hidden ID
    self.move = move;
    
    //Insert move info into cell
    self.nameLabel.text = [move getFormattedName];
    
    self.powerLabel.text = [move getFormattedPower];
    
    self.accuracyLabel.text = [move getFormattedAccuracy];
    
    self.ppLabel.text = [move getFormattedPP];
    
    
    //Add images to cell
    MoveDatabase* moveDatabase  = [MoveDatabase getMoveDatabase];
    self.typeIcon.image = [moveDatabase getTypeImage:move];
    
    self.attackClassIcon.image = [moveDatabase getDamageClassImage:move ];
}

@end
