//
//  PokemonMovesetDatabase.h
//  PokeTool
//
//  Created by Alex Campbell on 6/6/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MOVESET_POKEMON_ID 0
#define MOVESET_MOVE_ID 2
#define MOVESET_LEARN_METHOD 3
#define MOVESET_LEVEL 4

@interface PokemonMovesetDatabase : NSObject

+ (NSArray*)searchForMovesetById: (int) pokemonID;

@end
