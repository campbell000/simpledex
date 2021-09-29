//
//  PokemonDatabase.m
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import "PokemonDatabase.h"
#import "Pokemon.h"
#import "StatContainer.h"
#import "EvoTrigger.h"
#import "MoveDatabase.h"
#import "PokemonMoveset.h"

#define FORM_STARTS_ID 10000

@implementation PokemonDatabase

//Singleton variable that is to be used in all of the views
static PokemonDatabase* singletonPokemonDatabase = Nil;

- (id) init
{
    pokemonDictionary = [[NSMutableDictionary alloc]init];
    statDictionary = [[NSMutableDictionary alloc] init];
    typeDictionary = [[NSMutableDictionary alloc] init];
    pokemonTypeDictionary = [[NSMutableDictionary alloc] init];
    evolutionDictionary = [[NSMutableDictionary alloc] init];
    evoTriggerDictionary = [[NSMutableDictionary alloc] init];
    formDictionary = [[NSMutableDictionary alloc]init];
    numPokemon = 0;

    return self;
}

+ (void) initSingleton
{
    //singletonPokemonDatabase = [self createPokemonDatabase2:@"pokemon.csv"];
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"SerializedPokemonDatabase" ofType:@"txt"];
    singletonPokemonDatabase = [NSKeyedUnarchiver unarchiveObjectWithFile:strPath];
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self->pokemonDictionary forKey:@"pokemonDictionary"];
    [encoder encodeObject:self->statDictionary forKey:@"statDictionary"];
    [encoder encodeObject:self->typeDictionary forKey:@"typeDictionary"];
    [encoder encodeObject:self->pokemonTypeDictionary forKey:@"pokemonTypeDictionary"];
    [encoder encodeObject:self->evolutionDictionary forKey:@"evolutionDictionary"];
    [encoder encodeObject:self->evoTriggerDictionary forKey:@"evoTriggerDictionary"];
    [encoder encodeObject:self->formDictionary forKey:@"formDictionary"];
    [encoder encodeInt:self->numPokemon forKey:@"numPokemon"];
    [encoder encodeObject:self->learnedMoveDictionary forKey:@"learnedMoveDictionary"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self->pokemonDictionary = [[decoder decodeObjectForKey:@"pokemonDictionary"]mutableCopy ];
        self->statDictionary = [[decoder decodeObjectForKey:@"statDictionary"]mutableCopy];
        self->typeDictionary= [[decoder decodeObjectForKey:@"typeDictionary"]mutableCopy];
        self->pokemonTypeDictionary= [[decoder decodeObjectForKey:@"pokemonTypeDictionary"]mutableCopy];
        self->evolutionDictionary= [[decoder decodeObjectForKey:@"evolutionDictionary"]mutableCopy];
        self->evoTriggerDictionary= [[decoder decodeObjectForKey:@"evoTriggerDictionary"]mutableCopy];
        self->formDictionary= [[decoder decodeObjectForKey:@"formDictionary"]mutableCopy];
        self->numPokemon= [decoder decodeIntForKey:@"numPokemon"];
        self->learnedMoveDictionary= [[decoder decodeObjectForKey:@"learnedMoveDictionary"]mutableCopy];
    }
    return self;
}

- (NSMutableDictionary*) pokemonDictionary
{
    return pokemonDictionary;
}

- (void) setNumPokemon: (int) n
{
    numPokemon = n;
}

- (NSMutableDictionary*) formDictionary
{
    return formDictionary;
}

+ (PokemonDatabase*) getPokemonDatabase
{
    if (singletonPokemonDatabase == Nil)
    {
        NSLog(@"had to create");
        singletonPokemonDatabase = [PokemonDatabase createPokemonDatabase2:@"pokemon.csv"];
    }
    return singletonPokemonDatabase;
}

//This method creates an array of pokemon objects.
//IT SHOULD ONLY BE CALLED BY THE "getPokemonDatabase" function
+ (id) createPokemonDatabase2: (NSString*)filename
{
    PokemonDatabase* database = [[PokemonDatabase alloc] init];
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_new" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each pokemon
    for(int i = 1; i < [array count]; i++)
    {
        NSString* pokemon = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [pokemon componentsSeparatedByString:@","];
        
        //Get name and num of pokemon
        int num = [[items objectAtIndex: 0] intValue];
        int order_num = [[items objectAtIndex: 6] intValue];
        NSString* name = [[items objectAtIndex: 1] capitalizedString];
        int speciesID = [[items objectAtIndex: 2] intValue];
        
        //Get icon and hi-res artwork of pokemon
        UIImage* pokemonIcon =  nil; //[database getPokemonIcon:num];
    
        
        //Create object, store in database
        Pokemon* p = [Pokemon initWithNum: num AndName: name AndIcon: pokemonIcon AndOrderNum:order_num andSpeciesID:speciesID];
        
        /**
         * Pokemon forms start around 10000. If the pokemon's
         * number is less than 10000, then it is not a form, and
         * should be added to the pokemon dict. Else, add it to
         * an existing pokemon's form list
         */
        if (num > FORM_STARTS_ID)
        {
            Pokemon* existingPoke = [database getPokemon:speciesID];
            [existingPoke addForm: p];
            
            database.numPokemon--;
        }
        
        //We need to manually keep track of the number of pokemon because forms shouldn't count, even though they are listed as "pokemon" in the pokemon.csv file.
        database.numPokemon++;
        
        [database.pokemonDictionary setObject:p forKey:@(num)];
    }
    
    [database assignPokemonStats];
    [database createTypeDict];
    [database assignPokemonTypes];
    [database createEvolutionDictionary];
    [database createEvoTriggerDictionary];
    [database assignForms];
    
    return database;
}

- (void) assignForms
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_forms" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each form
    for(int i = 1; i < [array count]; i++)
    {
        NSString* form = [array objectAtIndex: i];
        NSArray *items = [form componentsSeparatedByString:@","];
        int speciesID = [[items objectAtIndex: 3] intValue];
        NSString* formName = [items objectAtIndex:2];
        
        Pokemon* base = [self getPokemon:speciesID];
        
        //If this is true, then the form does not have its own entry in the
        //pokemon csv. It can therefore be clones from its base pokemon.
        if (speciesID < 10000)
        {
            Pokemon* formClone = [base copy];
            formClone.formName = formName;
            
            [base addForm:formClone];
        }
        
        //This form can be considered a separate pokemon.
        else
        {
            base.formName = formName;
        }
    }
}

- (void) createLearnedMoveset
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_moves" ofType:@"csv"];
    NSLog(@"%@",strPath);
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < [array count]; i++)
    {
        NSString* moveString = [array objectAtIndex:i];
        NSArray *moveAttr = [moveString componentsSeparatedByString:@","];
        
        //Ignore move unless a pokemon learns it by leveling up
        int learnType = [[moveAttr objectAtIndex:MOVESET_LEARN_METHOD]intValue];
        if (learnType == 4)
        {
            //Gather attributes from line
            int pokemonID = [[moveAttr objectAtIndex: MOVESET_POKEMON_ID]intValue];
            int moveID = [[moveAttr objectAtIndex: MOVESET_MOVE_ID]intValue];
            int level = [[moveAttr objectAtIndex: MOVESET_LEVEL]intValue];
            
            //Get move object
            MoveDatabase* moveDatabase = [MoveDatabase getMoveDatabase];
            Move* move = [moveDatabase getMoveById:moveID];
            NSMutableArray* learnedMoveset;
            
            //Create move-level object
            PokemonMoveset* learnedMove = [PokemonMoveset createMoveset:move withLevel:level];
            
            //Check if array of moves already exists for the pokemon. If not, create one
            if ([learnedMoveDictionary objectForKey:@(pokemonID)] == nil)
            {
                learnedMoveset = [[NSMutableArray alloc] init];
                [learnedMoveset addObject:learnedMove];
                [learnedMoveDictionary setObject:learnedMoveset forKey:@(pokemonID)];
            }
            else
            {
                learnedMoveset = (NSMutableArray*)[learnedMoveDictionary objectForKey:@(pokemonID)];
                [learnedMoveset addObject:learnedMove];
            }
        }
    }
}

//Used by the getPokemonByNum. Shouldn't be called directly.
- (int) binary_search: (NSMutableArray*)array WithKey: (int) key WithMin: (int)min WithMax: (int)max
{
    if (max < min)
        return -1;
    else
    {
        int mid = (max + min) / 2;
        
        Pokemon* curr = [array objectAtIndex: mid];
        
        if (curr.num > (key))
            return [self binary_search: array WithKey: key WithMin: min WithMax: (mid - 1)];
        
        else if (curr.num < (key))
            return [self binary_search: array WithKey: key WithMin: (mid+1) WithMax: max];
        
        else
            return mid;
    }
}

//Creates the stat dictionary. Adding stats to Pokemon objects takes
//too long
- (void) assignPokemonStats
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_stats" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    StatContainer* statContainer = [StatContainer createStatContainer];
    int count = 0;
    
    for (int i = 1; i < [array count]; i++)
    {
        count++;
        NSString* line = [array objectAtIndex: i];
        
        //Parse line into array, get values
        NSArray *items = [line componentsSeparatedByString:@","];
        int pokemonID = [[items objectAtIndex:0]intValue];
        int statID = [[items objectAtIndex:1]intValue];
        int statValue = [[items objectAtIndex:2]intValue];
        int effortValue = [[items objectAtIndex:3]intValue];
        
        [statContainer addStat: statID WithValue:statValue];
        if (effortValue != 0)
        {
            [statContainer addEffortValue:effortValue OfType: statID];
        }

        if (count >= 6)
        {

            [statDictionary setObject:statContainer forKey:@(pokemonID)];
            statContainer = [StatContainer createStatContainer];
            count = 0;
        }
    }
}

- (StatContainer*) getStats: (int) pokemonID
{
    NSNumber* key = [NSNumber numberWithInt:pokemonID];
    return [statDictionary objectForKey:key];
}

- (void) createTypeDict
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"types" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //store each type, along with its id, in the dict
    for(int i = 1; i < [array count]; i++)
    {
        NSString* typeLine = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [typeLine componentsSeparatedByString:@","];
        NSNumber* ID = [NSNumber numberWithInt: [[items objectAtIndex:0] intValue]];
        NSString* type = [items objectAtIndex: 1];
        [typeDictionary setObject: type forKey:ID];
    }
}

- (NSString*) lookupType: (int) type
{
    NSNumber* typeID = [NSNumber numberWithInt: type];
    return [typeDictionary objectForKey: typeID];
}

- (int) lookupTypeNumber: (NSString*) typeString
{
    NSArray* types = [typeDictionary allKeysForObject:typeString];
    
    //Retry search for type number with a different capitalization if the first search fails
    if ([types count] < 1)
        types = [typeDictionary allKeysForObject:[typeString lowercaseString]];
    
    //Try again with the first letter capitalized
    if ([types count] < 1)
        types = [typeDictionary allKeysForObject:[[typeString lowercaseString]capitalizedString]];
    
    //giving up :(
    if ([types count] < 1)
        return -1;
    else
        return [types[0]intValue];
                 
}

- (NSMutableArray*) getPokemonTypes: (int) pokemonID
{
    NSNumber* ID = [NSNumber numberWithInt:pokemonID];
    return [pokemonTypeDictionary objectForKey:ID];
}

- (void) assignPokemonTypes
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_types" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    //Get array consisting of each line as a string.
    NSArray *array = [[NSArray alloc] init];
    array = [file componentsSeparatedByString:@"\n"];
    NSNumber* oldID = [NSNumber numberWithInt:0];
    NSNumber* notAssigned = [NSNumber numberWithInt: -1];
    NSMutableArray* typeArray = Nil;
    
    //store each type, along with its id, in the dict
    for(int i = 1; i < [array count]; i++)
    {
        NSString* pokemonType = [array objectAtIndex: i];
        NSArray *items = [pokemonType componentsSeparatedByString:@","];
        
        NSNumber* pokemonID = [NSNumber numberWithInt:[[items objectAtIndex:0]intValue]];
        NSNumber* typeID = [NSNumber numberWithInt:[[items objectAtIndex:1]intValue]];
        
        if (![oldID isEqual:pokemonID])
        {
            if (typeArray != Nil)
                [pokemonTypeDictionary setObject:typeArray forKey:oldID];
            
            oldID = pokemonID;
            typeArray = [[NSMutableArray alloc] initWithObjects: notAssigned, notAssigned, nil];
            [typeArray setObject:typeID atIndexedSubscript:0];
        }
        else
        {
            [typeArray setObject:typeID atIndexedSubscript:1];
        }
    }
}

- (void) createEvolutionDictionary
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_species" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //store each type, along with its id, in the dict
    for(int i = 1; i < [array count]; i++)
    {
        NSString* evoLine = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [evoLine componentsSeparatedByString:@","];
        NSNumber* idOfPokemon = [NSNumber numberWithInt:[[items objectAtIndex: 0]intValue]];
        NSNumber* evolvedFrom = [NSNumber numberWithInt:[[items objectAtIndex: 3]intValue]];
        
        if (![evolvedFrom isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            [evolutionDictionary setObject:evolvedFrom forKey:idOfPokemon];
        }
    }
}

- (Pokemon*) getPreviousEvolvedPokemon: (Pokemon*)pokemon
{
    NSNumber* lookup = [evolutionDictionary objectForKey:@(pokemon.num)];
    if (lookup != nil)
        return [self getPokemon: [lookup intValue]];
    else
        return Nil;
}

- (NSMutableArray*) getAllEvolutions:(Pokemon*) pokemon
{
    NSNumber* value = [NSNumber numberWithInt: pokemon.num];
    NSArray* result = [evolutionDictionary allKeysForObject:value];
    NSMutableArray* evos = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [result count]; i++)
    {
        NSLog(@"%@: %@", pokemon.name, [result objectAtIndex:i]);
    }
    
    for (int i = 0; i < [result count]; i++)
    {
        Pokemon* p = [self getPokemon:[[result objectAtIndex:i]intValue]];
        [evos addObject:p];
    }
    return evos;
}

- (void) createEvoTriggerDictionary
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"pokemon_evolution" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableArray* test = [[NSMutableArray alloc] init];
        
    //Get array consisting of each line as a string.
    NSArray *array = [file componentsSeparatedByString:@"\n"];
    
    //store each type, along with its id, in the dict
    for(int i = 1; i < [array count]; i++)
    {
        NSString* evoLine = [array objectAtIndex: i];
        
        //Parse line into array
        NSArray *items = [evoLine componentsSeparatedByString:@","];
        EvoTrigger* trigger = [EvoTrigger createEvoTrigger:items];
        
        NSNumber* pokemonID = [NSNumber numberWithInt:[[items objectAtIndex:EVOLVED_POKEMON_ID]intValue]];
        [evoTriggerDictionary setObject:trigger forKey:pokemonID];
        
        NSString* itemID = [items objectAtIndex:HELD_ITEM_ID];
        if (![test containsObject:itemID])
            [test addObject:itemID];
    }
}

- (EvoTrigger*) getEvoTrigger: (int) pokemonID
{
    NSNumber* key = [NSNumber numberWithInt: pokemonID];
    EvoTrigger* trigger = [evoTriggerDictionary objectForKey:key];
    return trigger;
}

- (int) numPokemon
{
    return numPokemon;
}

- (Pokemon*) getPokemon: (int) num
{
    return [self.pokemonDictionary objectForKey:@(num)];
}

- (UIImage*) getPokemonArtwork: (int) num
{
    NSString* strPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"a%d",num] ofType:@"png"];
    
    
    NSLog(@"Getting %@ with %d", strPath, num);
    UIImage* pokemonArtwork =  [UIImage imageWithContentsOfFile: strPath];
    return pokemonArtwork;
}

- (UIImage*) getPokemonArtwork: (int) num withForm: (NSString*) form
{
    NSString* strPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"a%d-%@",num, form] ofType:@"png"];
    
    NSLog(@"Getting %@ with %d and %@", strPath, num, form);

    UIImage* pokemonArtwork =  [UIImage imageWithContentsOfFile: strPath];
    return pokemonArtwork;
}

- (UIImage*) getPokemonIcon: (int) num
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",num] ofType:@"png"];
    UIImage* pokemonIcon =  [UIImage imageWithContentsOfFile: strPath];
    return pokemonIcon;
}

- (UIImage*) getDefaultArtwork
{
    NSString* strPath = [[NSBundle mainBundle] pathForResource:@"notfound" ofType:@"png"];
    UIImage* pokemonArtwork =  [UIImage imageWithContentsOfFile: strPath];
    return pokemonArtwork;
}

@end
