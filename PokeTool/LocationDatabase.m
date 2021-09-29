//
//  LocationDatabase.m
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "LocationDatabase.h"
#import "Location.h"
#import "Version.h"
#import "PokemonEncounter.h"
#import "Encounter.h"
#import "PokemonDatabase.h"
#import "LocationArea.h"

@implementation LocationDatabase

//Singleton variable that is to be used in all of the views
static LocationDatabase* singletonLocationDatabase = Nil;

- (id) init
{
    locationDictionary = [[NSMutableDictionary alloc] init];
    [self initLocationDictionary];
    
    versionDictionary = [[NSMutableDictionary alloc] init];
    [self initVersions];
    
    locationAreaDictionary = [[NSMutableDictionary alloc] init];
    [self initLocationAreaDictionary];
    
    encountersPerPokemon = [[NSMutableDictionary alloc] init];
    [self initEncounters];
    
    return self;
}

/*
 + (void) initSingleton
{
    singletonLocationDatabase = [[LocationDatabase alloc]init];
}
 */

+ (void) initSingleton
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"SerializedLocationDatabase" ofType:@"txt"];
    singletonLocationDatabase = [NSKeyedUnarchiver unarchiveObjectWithFile:strPath];
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self->locationDictionary forKey:@"locationDictionary"];
    [encoder encodeObject:self->versionDictionary forKey:@"versionDictionary"];
    [encoder encodeObject:self->locationAreaDictionary forKey:@"locationAreaDictionary"];
    [encoder encodeObject:self->encountersPerPokemon forKey:@"encountersPerPokemon"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self->locationDictionary = [[decoder decodeObjectForKey:@"locationDictionary"]mutableCopy ];
        self->versionDictionary = [[decoder decodeObjectForKey:@"versionDictionary"]mutableCopy];
        self->locationAreaDictionary= [[decoder decodeObjectForKey:@"locationAreaDictionary"]mutableCopy];
        self->encountersPerPokemon= [[decoder decodeObjectForKey:@"encountersPerPokemon"]mutableCopy];
    }
    return self;
}

+ (LocationDatabase*) getLocationDatabase
{
    //If the instance gets deleted by memory management or whatever, we need to initialize it again
    if (singletonLocationDatabase == Nil)
    {
        NSLog(@"had to create");
        singletonLocationDatabase = [[LocationDatabase alloc]init];
    }
    return singletonLocationDatabase;
}

- (void) initLocationDictionary
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each pokemon
    for(int i = 1; i < [array count]; i++)
    {
        NSString* location = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [location componentsSeparatedByString:@","];
        
        //Get data for location, create location object
        int locID = [[items objectAtIndex:0]intValue];
        int regionID = [[items objectAtIndex:1]intValue];
        NSString* str = [items objectAtIndex:2];
        
        Location* newLoc = [Location initWithId:locID andRegion:regionID andName:str];
        
        [locationDictionary setObject:newLoc forKey:@(locID)];
    }
}

- (void) initLocationAreaDictionary
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"location_areas" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each pokemon
    for(int i = 1; i < [array count]; i++)
    {
        NSString* location = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [location componentsSeparatedByString:@","];
        
        //Get data for location, create location object
        int locAreaID = [[items objectAtIndex:0]intValue];
        int locID = [[items objectAtIndex:1]intValue];
        int gameID = [[items objectAtIndex:2]intValue];
        NSString* str = @"";
        
        if ([items count] > 3)
        {
            str = [items objectAtIndex:3];
        }
        
        LocationArea* newLoc = [LocationArea initLocationArea:locAreaID withLocID:locID withGameID:gameID withDescriptor:str];
        
        [locationAreaDictionary setObject:newLoc forKey:@(locAreaID)];
    }
}

- (NSMutableDictionary*) locationAreaDictionary
{
    return locationAreaDictionary;
}

/**
 encounters have Location_Area IDs. THis correlates to very first column in the "location_areas.csv" file. The location id in THAT file points to an actual location. FUCK
 */

- (void) initEncounters
{
    PokemonDatabase* pokemonDatabase = [PokemonDatabase getPokemonDatabase];
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"encounters" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each pokemon
    for(int i = 1; i < [array count]; i++)
    {
        //Parse line into array
        NSString* encounter = [array objectAtIndex: i];
        NSArray *items = [encounter componentsSeparatedByString:@","];
        
        //Extract encounter data
        int version = [[items objectAtIndex:1]intValue];
        int locationAreaID = [[items objectAtIndex:2]intValue];
        int pokemonID = [[items objectAtIndex:4]intValue];
        int min = [[items objectAtIndex:5]intValue];
        int max = [[items objectAtIndex:6]intValue];
        
        //Get the location area from the encounter, and use the location area to get the general location.
        LocationArea* locArea = [self.locationAreaDictionary objectForKey:@(locationAreaID)];
        NSString* descriptor = [locArea getFormattedName];
        
        int locationID = [locArea getLocationID];
        
        Location* loc = [self.locationDictionary objectForKey:@(locationID)];
        Version* ver = [self.versionDictionary objectForKey:@(version)];
        Pokemon* p = [pokemonDatabase getPokemon:pokemonID];
                
        Encounter* newEncounter = [Encounter initWithLocation:loc andVersion:ver andMinLevel:min andMaxLevel:max andDescriptor:descriptor];
        
        //Add New encounter to list of encounters per pokemon, if one exists for the specific pokemon.
        PokemonEncounter* pokemonEncounter = [self.encountersPerPokemon objectForKey:@(p.num)];
        if (pokemonEncounter == nil)
        {
            pokemonEncounter = [PokemonEncounter initWithPokemon:p];
            [self.encountersPerPokemon setObject:pokemonEncounter forKey:@(pokemonID)];
        }
        
        [pokemonEncounter addEncounter:newEncounter];
        
    }
}

- (void) initVersions
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"versions" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each pokemon
    for(int i = 1; i < [array count]; i++)
    {
        NSString* version = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [version componentsSeparatedByString:@","];
        
        //Get data for location, create location object
        int locID = [[items objectAtIndex:0]intValue];
        int groupID = [[items objectAtIndex:1]intValue];
        NSString* str = [items objectAtIndex:2];
        
        Version* newVersion = [Version initVersionWithID:locID andGroupID:groupID andName:str];
        
        [versionDictionary setObject:newVersion forKey:@(locID)];
    }
}

- (NSMutableDictionary*) locationDictionary
{
    return locationDictionary;
}

- (NSMutableDictionary*) versionDictionary
{
    return versionDictionary;
}

- (NSMutableDictionary*) encountersPerPokemon
{
    return encountersPerPokemon;
}

- (PokemonEncounter*) getAllLocationsForPokemon: (Pokemon*) pokemon
{
    return [self.encountersPerPokemon objectForKey:@(pokemon.num)];
}

- (NSMutableArray*) getEncountersFor: (Pokemon*) p inVersion: (Version*) v
{
    PokemonEncounter* encounters = [self.encountersPerPokemon objectForKey:@(p.num)];
    NSMutableArray* encountersInVersion = [encounters getEncountersForVersion: v];
    
    return encountersInVersion;
}

- (NSMutableDictionary*) getAllVersions
{
    return self.versionDictionary;
}

- (Version*) getVersionById: (int) versionID
{
    return [self.versionDictionary objectForKey:@(versionID)];
}

- (NSMutableArray*) getEmptyVersionsForPokemon: (Pokemon*) p
{
    NSMutableArray* emptyVersions = [[NSMutableArray alloc]init];
    PokemonEncounter* encounters = [self.encountersPerPokemon objectForKey:@(p.num)];
    NSArray* versions = [self.versionDictionary allValues];
    
    for (int i = 0; i < [versions count]; i++)
    {
        Version* v = [versions objectAtIndex:i];
        if ([[self getEncountersFor:p inVersion:v]count] == 0)
            [emptyVersions addObject:v];
    }
    return emptyVersions;
}

@end
