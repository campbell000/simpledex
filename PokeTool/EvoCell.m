//
//  EvoCell.m
//  PokeTool
//
//  Created by Alex Campbell on 7/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "EvoCell.h"
#import "ViewUtil.h"
#import "PokemonDatabase.h"
#import "EvoTrigger.h"

@implementation EvoCell
@synthesize fromPokemon;
@synthesize toPokemon;
@synthesize triggerOne;
@synthesize triggerTwo;
@synthesize triggerThree;
@synthesize fromLabel;
@synthesize toLabel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (int) getHeight
{
    return CELL_HEIGHT;
}

- (void) formatCell: (Pokemon*) from andTo: (Pokemon*)to
{
    NSLog(@"HERE YO");
    self.fromPokemon.image = [from getArtwork];
    self.toPokemon.image = [to getArtwork];
    
    //Get array of all the evo triggers and their description
    PokemonDatabase* db = [PokemonDatabase getPokemonDatabase];
    EvoTrigger* evoTrigger = [db getEvoTrigger:to.num];
    NSArray* triggerDescs = [evoTrigger getAllEvoTriggers];
    
    //Fill in the labels with the evo trigger descriptions, even if they are empty strings.
    self.triggerOne.text = triggerDescs[2];
    self.triggerTwo.text = triggerDescs[1];
    self.triggerThree.text = triggerDescs[0];
    self.fromLabel.text = from.name;
    self.toLabel.text = to.name;
    
    [ViewUtil formatImage: self.fromPokemon];
    [ViewUtil formatImage: self.toPokemon];
}

@end
