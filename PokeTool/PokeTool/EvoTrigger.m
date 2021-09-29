//
//  EvoTrigger.m
//  PokeTool
//
//  Created by Alex Campbell on 1/7/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "EvoTrigger.h"
#import "MoveDatabase.h"
#import "Move.h"
#import "PokemonDatabase.h"

@implementation EvoTrigger

- (id) init
{
    triggers = [[NSArray alloc] init];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self->triggers forKey:@"triggers"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self->triggers = [decoder decodeObjectForKey:@"triggers"];
    }
    return self;
}

+ (EvoTrigger*) createEvoTrigger: (NSArray*) trigs
{
    EvoTrigger* trigger = [[EvoTrigger alloc] init];
    [trigger setTriggers: trigs];
    return trigger;
}

- (int) getEvoTrigger: (int) type
{
    return [[triggers objectAtIndex:type]intValue];
}

- (NSString*) toString
{
    NSString* minLevel = [self addMinLevelInfo];
    NSString* item = [self addItemEvoInfo];
    NSString* emotional = [self addEmotionalInfo];
    NSString* trade = [self addTradeInfo];
    NSString* time = [self addTimeInfo];
    NSString* held = [self addHeldItemInfo];
    NSString* location = [self addLocation];
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@%@", minLevel, item, emotional, trade, held, time, location];
}

- (NSString*) addMinLevelInfo
{
    NSString* string = @"";
    //Pokemon evolves at a minimum level
    if ([self getEvoTrigger: MINIMUM_LEVEL] != 0)
        string = [NSString stringWithFormat:@"Lvl %@", [triggers objectAtIndex: MINIMUM_LEVEL]];
    
    return string;
}

- (NSString*) addEmotionalInfo
{
    NSString* string = @"";
    
    if ([self getEvoTrigger: MINIMUM_AFFECTION] != 0)
        string = [NSString stringWithFormat:@"Affection"];
    else if ([self getEvoTrigger: MINIMUM_BEAUTY] != 0)
        string = [NSString stringWithFormat:@"Beauty"];
    else if ([self getEvoTrigger: MINIMUM_HAPPINESS] != 0)
        string = [NSString stringWithFormat:@"Happiness"];
    
    return string;
}

- (NSString*) addItemEvoInfo
{
    NSString* string = @"";
    
    if ([self getEvoTrigger:EVOLUTION_TRIGGER_ID] == USE_ITEM)
    {
        NSString* stone;
        int itemID = [[triggers objectAtIndex:TRIGGER_ITEM_ID]intValue];
        switch (itemID)
        {
            case LEAF_STONE:
                stone = @"Leaf";
                break;
            case FIRE_STONE:
                stone = @"Fire";
                break;
            case MOON_STONE:
                stone = @"Moon";
                break;
            case WATER_STONE:
                stone = @"Water";
                break;
            case THUNDER_STONE:
                stone = @"Thunder";
                break;
            case SHINY_STONE:
                stone = @"Shiny";
                break;
            case DUSK_STONE:
                stone = @"Dusk";
                break;
            case DAWN_STONE:
                stone = @"Dawn";
                break;
            case OVAL_STONE:
                stone = @"Oval";
                break;
            case SUN_STONE:
                stone = @"Sun";
                break;
        }
        string = [NSString stringWithFormat:@"%@ Stone",stone];
    }
    return string;
}

- (NSString*) addTradeInfo
{
    NSString* string = @"";
    if ([[triggers objectAtIndex: EVOLUTION_TRIGGER_ID]intValue] == TRADE)
        string = @"Trade";
    return string;
}

- (NSString*) addTimeInfo
{
    if ([[triggers objectAtIndex:TIME_OF_DAY]length] > 0)
        return [NSString stringWithFormat:@" (%@)",[triggers objectAtIndex:TIME_OF_DAY]];
    else
        return @"";
}

- (NSString*) addLocation
{
    NSString* string = @"";
    int locationID = [[triggers objectAtIndex:LOCATION_ID] intValue];
    switch(locationID)
    {
        case ETERNA_FORREST:
            string = @"at Eterna Forrest";
            break;
        case MT_CORONET:
            string = @"at Mt. Coronet";
            break;
        case SINNOH_ROUTE_TWO_SEVENTEEN:
            string = @"at Sinnoh Rt.17";
            break;
        case CHARGESTONE_CAVE:
            string = @"at Chargestone Cave";
            break;
        case PINWHEEL_FORREST:
            string = @"at Pinwheel Forrest";
            break;
        case TWIST_MOUNTAIN:
            string = @"at Twist Mountain";
            break;
        case KALOS_ROUTE_THIRTEEN:
            string = @"at Kalos Rt.13";
            break;
        case KALOS_ROUTE_TWENTY:
            string = @"at Kalos Rt.20";
            break;
        case FROST_CAVERN:
            string = @"at Frost Cavern";
            break;
    }
    
    return string;
}

/*For now, I am hard coding this in because it seems too time-consuming to take in the item.csv file and parse it when I am only using 17 items. I may change my mind in the future.*/
- (NSString*) addHeldItemInfo
{
    NSString* string = @"";
    int heldItemID = [[triggers objectAtIndex:HELD_ITEM_ID]intValue];
    switch (heldItemID)
    {
            
        case OVAL:
            string = @"OvalStone";
            break;
        case KINGS_ROCK:
            string = @"KingsRock";
            break;
        case METAL_COAT:
            string = @"MetalCoat";
            break;
        case DRAGON_SCALE:
            string = @"DragonScale";
            break;
        case UPGRADE:
            string = @"Upgrade";
            break;
        case DEEPSEA_TOOTH:
            string = @"DeepseaTooth";
            break;
        case DEEPSEA_SCALE:
            string = @"DeepseaScale";
            break;
        case RAZOR_CLAW:
            string = @"RazorClaw";
            break;
        case PROTECTOR:
            string = @"Protector";
            break;
        case ELECTIRIZER:
            string = @"Electirizer";
            break;
        case MAGMARIZER:
            string = @"Magmarizer";
            break;
        case DUBIOUS_DISC:
            string = @"DubiousDisc";
            break;
        case RAZOR_FANG:
            string = @"RazorFang";
            break;
        case REAPER_CLOTH:
            string = @"ReaperCloth";
            break;
        case PRISM_SCALE:
            string = @"PrismScale";
            break;
        case SATCHET:
            string = @"Satchet";
            break;
        case WHIPPED_DREAM:
            string = @"WhippedDream";
            break;
    }
    
    return string;
}

- (NSString*) getGender
{
    NSString* gender = @"";
    int genderID = [[triggers objectAtIndex:GENDER_ID]intValue];
    if (genderID == 1)
        gender = @"Female";
    else if (genderID == 2)
        gender = @"Male";
    
    return gender;
}

- (NSString*) getMinLevel
{
    NSString* level = @"";
    if (![[triggers objectAtIndex:MINIMUM_LEVEL] isEqualToString:@""])
    {
        NSString* l = [triggers objectAtIndex:MINIMUM_LEVEL];
        level = [NSString stringWithFormat:@"Level %@", l];
    }
    return level;
}

- (NSString*) getUsedItem
{
    NSString* string = @"";
    
    if ([self getEvoTrigger:EVOLUTION_TRIGGER_ID] == USE_ITEM)
    {
        NSString* stone;
        int itemID = [[triggers objectAtIndex:TRIGGER_ITEM_ID]intValue];
        switch (itemID)
        {
            case LEAF_STONE:
                stone = @"Leaf";
                break;
            case FIRE_STONE:
                stone = @"Fire";
                break;
            case MOON_STONE:
                stone = @"Moon";
                break;
            case WATER_STONE:
                stone = @"Water";
                break;
            case THUNDER_STONE:
                stone = @"Thunder";
                break;
            case SHINY_STONE:
                stone = @"Shiny";
                break;
            case DUSK_STONE:
                stone = @"Dusk";
                break;
            case DAWN_STONE:
                stone = @"Dawn";
                break;
            case OVAL_STONE:
                stone = @"Oval";
                break;
            case SUN_STONE:
                stone = @"Sun";
                break;
        }
        string = [NSString stringWithFormat:@"%@ Stone",stone];
    }
    return string;

}

- (NSString*) getLocation
{
    NSString* string = @"";
    int locationID = [[triggers objectAtIndex:LOCATION_ID] intValue];
    switch(locationID)
    {
        case ETERNA_FORREST:
            string = @"Eterna Forrest";
            break;
        case MT_CORONET:
            string = @"Mt. Coronet";
            break;
        case SINNOH_ROUTE_TWO_SEVENTEEN:
            string = @"Sinnoh Rt.17";
            break;
        case CHARGESTONE_CAVE:
            string = @"Chargestone Cave";
            break;
        case PINWHEEL_FORREST:
            string = @"Pinwheel Forrest";
            break;
        case TWIST_MOUNTAIN:
            string = @"Twist Mountain";
            break;
        case KALOS_ROUTE_THIRTEEN:
            string = @"Kalos Rt.13";
            break;
        case KALOS_ROUTE_TWENTY:
            string = @"Kalos Rt20";
            break;
        case FROST_CAVERN:
            string = @"Frost Cavern";
            break;
    }
    
    if (![string isEqualToString:@""])
    {
        string = [NSString stringWithFormat:@"At %@",string];
    }
    
    return string;
}

- (NSString*) getHeldItem
{
    NSString* string = @"";
    int heldItemID = [[triggers objectAtIndex:HELD_ITEM_ID]intValue];
    switch (heldItemID)
    {
            
        case OVAL:
            string = @"OvalStone";
            break;
        case KINGS_ROCK:
            string = @"KingsRock";
            break;
        case METAL_COAT:
            string = @"MetalCoat";
            break;
        case DRAGON_SCALE:
            string = @"DragonScale";
            break;
        case UPGRADE:
            string = @"Upgrade";
            break;
        case DEEPSEA_TOOTH:
            string = @"DeepseaTooth";
            break;
        case DEEPSEA_SCALE:
            string = @"DeepseaScale";
            break;
        case RAZOR_CLAW:
            string = @"RazorClaw";
            break;
        case PROTECTOR:
            string = @"Protector";
            break;
        case ELECTIRIZER:
            string = @"Electirizer";
            break;
        case MAGMARIZER:
            string = @"Magmarizer";
            break;
        case DUBIOUS_DISC:
            string = @"DubiousDisc";
            break;
        case RAZOR_FANG:
            string = @"RazorFang";
            break;
        case REAPER_CLOTH:
            string = @"ReaperCloth";
            break;
        case PRISM_SCALE:
            string = @"PrismScale";
            break;
        case SATCHET:
            string = @"Satchet";
            break;
        case WHIPPED_DREAM:
            string = @"WhippedDream";
            break;
    }
    
    
    if (![string isEqualToString:@""])
    {
        string = [NSString stringWithFormat:@"Holding %@",string];
    }
    return string;
}

- (NSString*) getTimeOfDay
{
    if ([[triggers objectAtIndex:TIME_OF_DAY]length] > 0)
        return [NSString stringWithFormat:@"%@ Time",[[triggers objectAtIndex:TIME_OF_DAY]capitalizedString]];
    else
        return @"";
}

- (NSString*) getKnownMove
{
    NSString* moveName = @"";
    MoveDatabase* db = [MoveDatabase getMoveDatabase];
    int moveID = [[triggers objectAtIndex:KNOWN_MOVE_ID]intValue];
    
    if (moveID > 0)
    {
        NSString* move = [[db getMoveById:moveID]getFormattedName];
        moveName = [NSString stringWithFormat:@"Knows %@", move];
    }

    
    return moveName;
}

- (NSString*) getKnownMoveType
{
    PokemonDatabase* pokeDatabase = [PokemonDatabase getPokemonDatabase];
    
    NSString* typeStr = @"";
    int type = [[triggers objectAtIndex:KNOWN_MOVE_TYPE_ID]intValue];
    
    if (type > 0)
    {
        NSString* typeName = [pokeDatabase lookupType: type];
        typeStr = [NSString stringWithFormat:@"%@-type Move", typeName];
    }
    
    return typeStr;

}

- (NSString*) getEmotions
{
    NSString* string = @"";
    
    if ([self getEvoTrigger: MINIMUM_AFFECTION] != 0)
        string = [NSString stringWithFormat:@"Affection"];
    else if ([self getEvoTrigger: MINIMUM_BEAUTY] != 0)
        string = [NSString stringWithFormat:@"Beauty"];
    else if ([self getEvoTrigger: MINIMUM_HAPPINESS] != 0)
        string = [NSString stringWithFormat:@"Happiness"];
    
    return string;
}

- (NSString*) getRelativeStats
{
    NSString* statRelationship = @"";
    
    //This is needed because the int value of an empty string is 0, which makes every pokemon satisfy the third condition.
    NSString* statString = [triggers objectAtIndex:RELATIVE_PHYSICAL_STATS];
    int relativeStats = [[triggers objectAtIndex:RELATIVE_PHYSICAL_STATS]intValue];
    
    if (relativeStats == 1)
        statRelationship = @"Attack > Defense";
    else if (relativeStats == -1)
        statRelationship = @"Defense > Attack";
    else if ([statString isEqualToString:@"0"])
        statRelationship = @"Defense == Attack";
    
    return statRelationship;
}

- (NSString*) getPartySpecies
{
    PokemonDatabase* db = [PokemonDatabase getPokemonDatabase];
    NSString* name = @"";
    int pokemonID = [[triggers objectAtIndex:PARTY_SPECIES_ID]intValue];
    
    if (pokemonID > 0)
    {
        NSString* poke = [db getPokemon:pokemonID].name;
        name = [NSString stringWithFormat:@"%@ in Party", poke];
    }
    
    return name;
}

- (NSString*) getPartyType
{
    PokemonDatabase* db = [PokemonDatabase getPokemonDatabase];
    NSString* type = @"";
    int typeID = [[triggers objectAtIndex:PARTY_TYPE_ID]intValue];
    
    if (typeID > 0)
    {
        NSString* type = [db lookupType:typeID];
        type = [NSString stringWithFormat:@"Party type: %@",type];
    }
    
    return type;
}

- (NSString*) needsTrade
{
    NSString* string = @"";
    if ([[triggers objectAtIndex: EVOLUTION_TRIGGER_ID]intValue] == TRADE)
        string = @"Trade";
    
    return string;
}

- (NSString*) needsRain
{
    NSString* string = @"";
    if ([[triggers objectAtIndex: NEEDS_OVERWORLD_RAIN]intValue] == 1)
        string = @"While Raining";
    
    return string;
}

- (NSString*) needsUpsideDown
{
    NSString* string = @"";
    if ([[triggers objectAtIndex: TURN_UPSIDE_DOWN]intValue] == 1)
        string = @"Turn Upside Down";
    
    return string;
}

- (NSString*) getHappiness
{
    NSString* string = @"";
    
    if ([self getEvoTrigger: MINIMUM_HAPPINESS] != 0)
        string = [NSString stringWithFormat:@"Happiness"];
    
    return string;
}

- (NSString*) getBeauty
{
    NSString* string = @"";
    
    if ([self getEvoTrigger: MINIMUM_BEAUTY] != 0)
        string = [NSString stringWithFormat:@"Beauty"];
    
    return string;
}

- (NSString*) getAffection
{
    NSString* string = @"";
    
    if ([self getEvoTrigger: MINIMUM_AFFECTION] != 0)
        string = [NSString stringWithFormat:@"Affection"];
    
    return string;
}

- (void) setTriggers: (NSArray*) trigs
{
    triggers = trigs;
}

/*
 * There's got to be a way to improve this, but I can't think of
 * any right now :/
 */
- (NSArray*) getAllEvoTriggers
{
    NSString* str1 = @"";
    NSString* str2 = @"";
    NSString* str3 = @"";
    NSMutableArray* evoTriggers = [NSMutableArray arrayWithObjects:str1, str2, str3, nil];
    int index = 0;
    
    //Get all string values of the evolution triggers.
    NSArray* evoTriggerStrings = [NSArray arrayWithObjects:[self getAffection],[self getBeauty],[self getGender],[self getHappiness],[self getHeldItem],[self getKnownMove],[self getKnownMoveType],[self getLocation],[self getMinLevel],[self getPartySpecies],[self getPartyType],[self getRelativeStats],[self getTimeOfDay],[self getUsedItem],[self needsRain],[self needsTrade],[self needsUpsideDown],nil];
    
    for (int i = 0; i < [evoTriggerStrings count]; i++)
    {
        NSString* evoTriggerStr = [evoTriggerStrings objectAtIndex:i];
        
        if (![evoTriggerStr isEqualToString:@""])
        {
            evoTriggers[index] = evoTriggerStr;
            index++;
            
            if (index > 2)
                break;
        }
    }

    NSArray* array = [NSArray arrayWithObjects:evoTriggers[0], evoTriggers[1], evoTriggers[2], nil];
    
    return array;
}

@end
