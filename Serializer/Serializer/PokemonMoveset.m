//
//  PokemonMoveset.m
//  PokeTool
//
//  Created by Alex Campbell on 6/4/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "PokemonMoveset.h"

@implementation PokemonMoveset

- (Move*) getMove
{
    return move;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self->move forKey:@"move"];
    [encoder encodeInt: self->minLevel forKey:@"minLevel"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self->move = [decoder decodeObjectForKey:@"stats"];
        self->minLevel = [decoder decodeIntForKey:@"minLevel"];
    }
    return self;
}

- (int) getLevel
{
    return minLevel;
}

- (void) setLevel: (int) level
{
    minLevel = level;
}

- (void) setMove: (Move*) m
{
    move = m;
}

+ (PokemonMoveset*) createMoveset: (Move*) m withLevel: (int)level
{
    PokemonMoveset* moveset = [self alloc];
    [moveset setLevel: level];
    [moveset setMove: m];
    
    return moveset;
}

- (NSString*) toString
{
   NSString* s = [NSString stringWithFormat:@"%@ - Lvl. %d", [move getFormattedName], minLevel];
    
    return s;
}

- (NSComparisonResult)compare:(PokemonMoveset*) otherObject {
    return [@(self->minLevel) compare:@(otherObject->minLevel)];
}
@end
