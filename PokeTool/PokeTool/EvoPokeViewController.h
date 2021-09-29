//
//  EvoPokeViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 6/30/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "PokemonDatabase.h"

@interface EvoPokeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    Pokemon* pokemon;
    NSMutableArray* evolutions;
    Pokemon* seguePokemon;
    PokemonDatabase* db;
    Pokemon* targetPokemon;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

- (void) setPokemon: (Pokemon*) p;

- (void) setEvolutions: (NSMutableArray*) evos;

@end
