//
//  EvoDetailViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 6/30/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "PokemonDatabase.h"

@interface EvoDetailViewController : UIViewController
{
    PokemonDatabase* db;
    Pokemon* fromPokemon;
    Pokemon* toPokemon;
}
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UIImageView *fromImage;
@property (weak, nonatomic) IBOutlet UILabel *useItem;
@property (weak, nonatomic) IBOutlet UILabel *holdItem;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *move;
@property (weak, nonatomic) IBOutlet UILabel *moveType;
@property (weak, nonatomic) IBOutlet UILabel *happiness;
@property (weak, nonatomic) IBOutlet UILabel *affection;
@property (weak, nonatomic) IBOutlet UILabel *beauty;
@property (weak, nonatomic) IBOutlet UILabel *stats;
@property (weak, nonatomic) IBOutlet UILabel *inParty;
@property (weak, nonatomic) IBOutlet UILabel *partyType;
@property (weak, nonatomic) IBOutlet UILabel *trade;
@property (weak, nonatomic) IBOutlet UILabel *rain;
@property (weak, nonatomic) IBOutlet UILabel *turn;






















@property (weak, nonatomic) IBOutlet UIImageView *toImage;

- (void) setFromPokemon: (Pokemon*) from andTo: (Pokemon*) to;
@end
