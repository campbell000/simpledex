//
//  EvoTrigger.h
//  PokeTool
//
//  Created by Alex Campbell on 1/7/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NUM_TRIGGERS 20

@interface EvoTrigger : NSObject<NSCoding>
{
    enum evoTriggerDetail{
        POKEMONID,
        EVOLVED_POKEMON_ID,
        EVOLUTION_TRIGGER_ID,
        TRIGGER_ITEM_ID,
        MINIMUM_LEVEL,
        GENDER_ID,
        LOCATION_ID,
        HELD_ITEM_ID,
        TIME_OF_DAY,
        KNOWN_MOVE_ID,
        KNOWN_MOVE_TYPE_ID,
        MINIMUM_HAPPINESS,
        MINIMUM_BEAUTY,
        MINIMUM_AFFECTION,
        RELATIVE_PHYSICAL_STATS,
        PARTY_SPECIES_ID,
        PARTY_TYPE_ID,
        TRADE_SPECIES_ID,
        NEEDS_OVERWORLD_RAIN,
        TURN_UPSIDE_DOWN
    };
    
    enum evoReasons{
        DUMMY,
        LEVEL_UP,
        TRADE,
        USE_ITEM,
        SHED
    };
    
    enum evoItemTriggers{
        SUN_STONE = 80,
        MOON_STONE = 81,
        FIRE_STONE = 82,
        THUNDER_STONE = 83,
        WATER_STONE = 84,
        LEAF_STONE = 85,
        SHINY_STONE = 107,
        DUSK_STONE = 108,
        DAWN_STONE = 109,
        OVAL_STONE = 110
    };
    
    enum evoHeldItems{
        OVAL = 110,
        KINGS_ROCK = 198,
        METAL_COAT = 210,
        DRAGON_SCALE = 212,
        UPGRADE = 229,
        DEEPSEA_TOOTH = 203,
        DEEPSEA_SCALE = 204,
        RAZOR_CLAW = 303,
        PROTECTOR = 298,
        ELECTIRIZER = 299,
        MAGMARIZER = 300,
        DUBIOUS_DISC = 301,
        RAZOR_FANG = 304,
        REAPER_CLOTH = 302,
        PRISM_SCALE = 580,
        SATCHET = 687,
        WHIPPED_DREAM = 686
    };
    
    enum evoLocations{
        ETERNA_FORREST = 8,
        MT_CORONET = 10,
        SINNOH_ROUTE_TWO_SEVENTEEN = 48,
        CHARGESTONE_CAVE = 379,
        PINWHEEL_FORREST = 375,
        TWIST_MOUNTAIN = 380,
        KALOS_ROUTE_THIRTEEN = 634,
        KALOS_ROUTE_TWENTY = 641,
        FROST_CAVERN = 608
    };
    
    NSArray* triggers;
}

+ (EvoTrigger*) createEvoTrigger: (NSArray*) trigs;

- (id) init;

- (int) getEvoTrigger: (int) type;

- (NSString*) toString;

- (void) setTriggers: (NSArray*) trigs;

- (NSString*) addLocation;

- (NSString*) getMinLevel;

- (NSString*) getGender;

- (NSString*) getLocation;

- (NSString*) getUsedItem;

- (NSString*) getHeldItem;

- (NSString*) getTimeOfDay;

- (NSString*) getKnownMove;

- (NSString*) getKnownMoveType;

- (NSString*) getRelativeStats;

- (NSString*) getPartySpecies;

- (NSString*) getPartyType;

- (NSString*) needsTrade;

- (NSString*) needsRain;

- (NSString*) needsUpsideDown;

- (NSString*) getEmotions;

- (NSString*) getHappiness;

- (NSString*) getBeauty;

- (NSString*) getAffection;

- (NSArray*) getAllEvoTriggers;
@end
