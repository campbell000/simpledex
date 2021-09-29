//
//  EvoCell.h
//  PokeTool
//
//  Created by Alex Campbell on 7/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

#define CELL_HEIGHT 97
@interface EvoCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView* fromPokemon;

@property (nonatomic, weak) IBOutlet UIImageView* toPokemon;

@property (nonatomic, weak) IBOutlet UILabel *triggerOne;

@property (nonatomic, weak) IBOutlet UILabel *triggerTwo;

@property (nonatomic, weak) IBOutlet UILabel *triggerThree;

@property (nonatomic, weak) IBOutlet UILabel *fromLabel;
@property (nonatomic, weak) IBOutlet UILabel *toLabel;

+ (int) getHeight;
- (void) formatCell: (Pokemon*) from andTo: (Pokemon*)to;

@end
