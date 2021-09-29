//
//  PokemonMoveset.h
//  PokeTool
//
//  Created by Alex Campbell on 6/4/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Move.h"

@interface PokemonMoveset : NSObject<NSCoding>
{
    Move* move;
    int minLevel;
}


+ (PokemonMoveset*) createMoveset: (Move*) m withLevel: (int)level;

- (NSString*) toString;

- (int) getLevel;

- (Move*) getMove;

@end
