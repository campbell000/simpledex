//
//  LocationDatabase.h
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#import "PokemonEncounter.h"

@interface LocationDatabase : NSObject<NSCoding>
{
    //Indexed by Location ID
    NSMutableDictionary* locationDictionary;
    
    //Indexed by pokemon ID, points to array of locations.
    NSMutableDictionary* encountersPerPokemon;
    
    //Indexed by verion ID
    NSMutableDictionary* versionDictionary;
    
    //Indexed by Loation Area ID
    NSMutableDictionary* locationAreaDictionary;
}

- (PokemonEncounter*) getAllLocationsForPokemon: (Pokemon*) pokemon;

- (id) init;

- (NSMutableDictionary*) locationDictionary;

- (NSMutableDictionary*) versionDictionary;

- (NSMutableDictionary*) locationAreaDictionary;

- (NSMutableDictionary*) encountersPerPokemon;

- (NSMutableDictionary*) getAllVersions;

- (NSMutableArray*) getEncountersFor: (Pokemon*) p inVersion: (Version*) v;

+ (LocationDatabase*) getLocationDatabase;

- (Version*) getVersionById: (int) versionID;

- (NSMutableArray*) getEmptyVersionsForPokemon: (Pokemon*) p;

+ (void) initSingleton;
@end
