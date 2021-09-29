//
//  PokemonEncounter.m
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//
//  Contains information about all of the places where a specific pokemon can be found.

#import "PokemonEncounter.h"

@implementation PokemonEncounter

+ (id) initWithPokemon: (Pokemon*) pokemon
{
    PokemonEncounter* pe = [PokemonEncounter alloc];
    pe.encounters = [[NSMutableDictionary alloc] init];
    return pe;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.encounters forKey:@"encounters"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        NSMutableDictionary* d = [decoder decodeObjectForKey:@"encounters"];
        [self setEncounters:d];
    }
    return self;
}


- (void) addEncounter: (Encounter*) e
{
    //Encounters are indexed in the dictionary by Version ID. REMEMBER THAT!
    NSMutableArray* encountersForRegion = [self.encounters objectForKey:@([[e version]versionID])];
    
    //If an array doesn't already exist for the region of the encounter, make one.
    if (encountersForRegion == nil)
    {
        int versionID = [[e version] versionID];
        
        encountersForRegion = [[NSMutableArray alloc]init];
        [self.encounters setObject:encountersForRegion forKey:@(versionID)];
    }
    
    [self addOrUpdateEncounter:e];
}


//This method is designed to condense the number of locations found. The csv file has an entry for EACH LEVEL that a pokemon can be found at. So, instead, this method will update the min/max levels if the location for the encounter has already been added. If not, then the encounter will be added.
- (void) addOrUpdateEncounter: (Encounter*) e
{
    NSMutableArray* encountersForRegion = [self.encounters objectForKey:@([[e version]versionID])];
    BOOL found = NO;
    for (int i = 0; i < [encountersForRegion count]; i++)
    {
        Encounter* currEncounter = [encountersForRegion objectAtIndex:i];
        if ([e.location.name isEqualToString:currEncounter.location.name])
        {
            if (e.minLevel < currEncounter.minLevel)
                currEncounter.minLevel = e.minLevel;
            
            if (e.maxLevel > currEncounter.maxLevel)
                currEncounter.maxLevel = e.maxLevel;
            
            found = YES;
            break;
        }
    }
    
    if (found == NO)
        [encountersForRegion addObject:e];
}

- (NSMutableDictionary*) getEncountersSortedByVersion
{
    return self.encounters;
}

- (NSMutableArray*) getEncountersForVersion: (Version*) v
{
    return [self.encounters objectForKey:@(v.versionID)];
}

@end
