//
//  PokemonDatabase.h
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#import "StatContainer.h"
#import "EvoTrigger.h"

#define MOVESET_POKEMON_ID 0
#define MOVESET_MOVE_ID 2
#define MOVESET_LEARN_METHOD 3
#define MOVESET_LEVEL 4


@interface PokemonDatabase : NSObject<NSCoding>
{
    NSMutableDictionary* pokemonDictionary;
    NSMutableDictionary* statDictionary;
    NSMutableDictionary* typeDictionary;
    NSMutableDictionary* pokemonTypeDictionary;
    NSMutableDictionary* evolutionDictionary;
    NSMutableDictionary* evoTriggerDictionary;
    NSMutableDictionary* learnedMoveDictionary;
    NSMutableDictionary* formDictionary;
    int numPokemon;
}

- (id) init;

- (NSString*) lookupType: (int) type;

- (NSMutableArray*) getPokemonTypes: (int) pokemonID;

- (int) binary_search: (NSMutableArray*)array WithKey: (int) key WithMin: (int)imin WithMax: (int)imax;

- (NSMutableDictionary*) pokemonDictionary;

- (StatContainer*) getStats: (int) pokemonID;

+ (PokemonDatabase*) getPokemonDatabase;

- (void) createTypeDict;

- (Pokemon*) getPreviousEvolvedPokemon: (Pokemon*)pokemon;

- (EvoTrigger*) getEvoTrigger: (int) pokemonID;

- (NSMutableArray*) getAllEvolutions: (Pokemon*) pokemon;

+ (void) initSingleton;

- (int) numPokemon;

- (Pokemon*) getPokemon: (int) num;

- (int) lookupTypeNumber: (NSString*) typeString;

- (void) setNumPokemon: (int) num;

@end
