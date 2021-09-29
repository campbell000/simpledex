//
//  PokemonEncounter.h
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//
//  Contains information about all of the places where a specific pokemon can be found.

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#import "Version.h"
#import "Encounter.h"
@interface PokemonEncounter : NSObject<NSCoding>

@property Pokemon* pokemon;

//Indexed by Version ID, contains each element contains an array of encounters
@property NSMutableDictionary* encounters;

+ (id) initWithPokemon: (Pokemon*) pokemon;

- (void) addEncounter: (Encounter*) ecounter;

- (NSMutableDictionary*) getEncountersSortedByVersion;

- (NSMutableArray*) getEncountersForVersion: (Version*) v;


@end
