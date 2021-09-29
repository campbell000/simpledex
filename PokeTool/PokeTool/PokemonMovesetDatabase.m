//
//  PokemonMovesetDatabase.m
//  PokeTool
//
//  Created by Alex Campbell on 6/6/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "PokemonMovesetDatabase.h"
#import "PokemonMoveset.h"
#import "MoveDatabase.h"

@implementation PokemonMovesetDatabase


+ (NSArray*)searchForMovesetById: (int) pokemonID
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_moves_short" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* array = [file componentsSeparatedByString:@"\n"];
    NSMutableArray* moveset = [[NSMutableArray alloc] init];
    
    //Store the name and number of each pokemon
    for(int i = pokemonID; i < [array count]; i++)
    {
        NSString* moveString = [array objectAtIndex: i];
        NSArray *moveAttr = [moveString componentsSeparatedByString:@","];
        
        int currID = [[moveAttr objectAtIndex: MOVESET_POKEMON_ID]intValue];
        int level = [[moveAttr objectAtIndex: MOVESET_LEVEL]intValue];
        
        //Stop if we passed the pokemon
        if (currID > pokemonID)
            break;
        
        if (currID == pokemonID && level >= 1)
        {
            //Gather attributes from line

            int moveID = [[moveAttr objectAtIndex: MOVESET_MOVE_ID]intValue];
            
            //Get move object
            MoveDatabase* moveDatabase = [MoveDatabase getMoveDatabase];
            Move* move = [moveDatabase getMoveById:moveID];
            
            //Create move-level object
            PokemonMoveset* learnedMove = [PokemonMoveset createMoveset:move withLevel:level];
            [moveset addObject:learnedMove];
            
        }
    }
    
    NSArray* sortedMoves = [moveset sortedArrayUsingSelector:@selector(compare:)];
    return sortedMoves;
}

@end
