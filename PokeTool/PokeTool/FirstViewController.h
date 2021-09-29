//
//  FirstViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "PokemonDatabase.h"
#import "PokemonDetailViewController.h"
#import "IvCalcViewController.h"

#define DATABASE_MODE = 0;
#define IV_MODE = 0;
@interface FirstViewController : UIViewController 
{
    int currentMode;
    PokemonDatabase* pokemonDatabase;
    NSMutableDictionary* searchResults;
    BOOL isFiltered;
    IBOutlet UIView *myDescView;
    int numOfSelectedPokemon;
    UIPickerView* formPicker;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@end
