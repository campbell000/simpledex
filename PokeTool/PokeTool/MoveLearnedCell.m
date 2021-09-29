//
//  MoveLearnedCell.m
//  PokeTool
//
//  Created by Alex Campbell on 6/7/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "MoveLearnedCell.h"

@implementation MoveLearnedCell

@synthesize moveName = _moveName;
@synthesize level = _level;

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

@end
