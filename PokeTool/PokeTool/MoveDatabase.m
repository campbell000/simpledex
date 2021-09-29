//
//  MoveDatabase.m
//  PokeTool
//
//  Created by Alex Campbell on 1/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "MoveDatabase.h"
#import "Move.h"
#import "PokemonDatabase.h"
#import "CHCSVParser.h"

@implementation MoveDatabase
static MoveDatabase* singletonMoveDatabase = Nil;

- (id) init
{
    moveDictionary = [[NSMutableDictionary alloc]init];
    moveProse = [[NSMutableDictionary alloc] init];
    effectProses = [[NSMutableDictionary alloc] init];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self->moveDictionary forKey:@"moveDictionary"];
    [encoder encodeObject:self->moveProse forKey:@"moveProse"];
    [encoder encodeObject:self->effectProses forKey:@"effectProses"];
    [encoder encodeObject:self->sortedKeys forKey:@"sortedKeys"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self->moveDictionary = [[decoder decodeObjectForKey:@"moveDictionary"]mutableCopy ];
        self->moveProse = [[decoder decodeObjectForKey:@"moveProse"]mutableCopy];
        self->effectProses= [[decoder decodeObjectForKey:@"effectProses"]mutableCopy];
        self->sortedKeys= [[decoder decodeObjectForKey:@"sortedKeys"]mutableCopy];
    }
    return self;
}

- (void) setMoveDictionary: (NSMutableDictionary*) m
{
    self.moveDictionary = [NSMutableDictionary dictionaryWithDictionary:m];
}

+ (void) initSingleton
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"SerializedMoveDatabase" ofType:@"txt"];
    singletonMoveDatabase = [NSKeyedUnarchiver unarchiveObjectWithFile:strPath];
}

+ (MoveDatabase *)getMoveDatabase
{
    if (singletonMoveDatabase == Nil)
    {
        singletonMoveDatabase = [self createMoveDatabase];
    }
    return singletonMoveDatabase;
}

+ (MoveDatabase*) createMoveDatabase
{
    MoveDatabase* moveDatabase = [[MoveDatabase alloc] init];
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"moves" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    //Get array consisting of each line as a string.
    NSArray *array = [[NSArray alloc] init];
    array = [file componentsSeparatedByString:@"\n"];
    
    //Store the name and number of each pokemon
    
    for(int i = 1; i < [array count]; i++)
    {
        NSString* move = [array objectAtIndex: i];
        
        NSArray* attributes = [move componentsSeparatedByString:@","];
        Move* m = [Move createMoveFromAttributeArray:attributes];
        [moveDatabase.moveDictionary setObject:m forKey:m.moveID];
    }
    
    [moveDatabase createMoveDescDictionary];
    [moveDatabase createEffectProseDictionary];
    
    moveDatabase.sortedKeys = [moveDatabase.moveDictionary keysSortedByValueUsingComparator: ^(id obj1, id obj2)
    {
        Move* m1 = (Move*) obj1;
        Move* m2 = (Move*) obj2;
        return [[m1 getFormattedName]compare: [m2 getFormattedName]];
    }];
    
    return moveDatabase;
}

- (void) setSortedKeys: (NSArray*)keys
{
    sortedKeys = keys;
}

- (NSArray*) sortedKeys
{
    return sortedKeys;
}

- (NSMutableDictionary*) moveDictionary
{
    return moveDictionary;
}

- (UIImage*) getTypeImage: (Move*) move
{
    PokemonDatabase* pokeDatabase = [PokemonDatabase getPokemonDatabase];
    NSString* type = [pokeDatabase lookupType: [move.typeID intValue]];

    UIImage* typeIcon =  [UIImage imageNamed: type];
    return typeIcon;
}

- (UIImage*) getDamageClassImage: (Move*) move
{
    UIImage* image = Nil;
    
    //Add physical/special label to cell
    NSString* imageName = Nil;
    if ([move.moveClass intValue] == 3)
        imageName = @"Special_Symbol";
    else if ([move.moveClass intValue] == 2)
        imageName = @"Physical_Symbol";
    
    if (imageName != Nil)
    {
        image =  [UIImage imageNamed: imageName];
    }
    
    return image;
    
}

- (void) createEffectProseDictionary
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"move_effect_prose" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    NSArray *rows = [NSArray arrayWithContentsOfCSVFile:strPath];
    for (int i = 1; i < [rows count]; i++)
    {
        NSArray* row = [rows objectAtIndex:i];
        
        NSNumber* effectID = [NSNumber numberWithInt:[[row objectAtIndex:0]intValue]];
        
        NSString* effectProse = [row objectAtIndex: 2];
        [effectProses setObject:effectProse forKey:effectID];
    }
    
}

/**
 * Right now, this algorithm does not add the most recent enlgish description. Instead, it just adds the first
 * english description that it sees. This could be most easily fixed by making adjustments to the csv file. 
 * It's difficult to do this through code because:
 *
 * 1. The "Most Recent" descriptions aren't necessarily all from the same generation. So I can't simply say, 
 *    get all english descriptions from gen 15.
 * 2. The most recent english descriptions aren't necessarily the bottom-most description for that move ID.
 **/
- (void) createMoveDescDictionary
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"move_flavor_text" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    NSArray *rows = [NSArray arrayWithContentsOfCSVFile:strPath];
    
    for (int i = 1; i < [rows count]; i++)
    {
        NSArray* row = [rows objectAtIndex:i];
        NSNumber* moveID = [NSNumber numberWithInt:[[row objectAtIndex:0]intValue]];
        
        NSNumber* langID = [NSNumber numberWithInt:[[row objectAtIndex:2]intValue]];
        
        NSString* prose = [row objectAtIndex:3];
        
        if ([langID intValue] == 9 && ([moveProse objectForKey:moveID] == nil))
        {
            [moveProse setObject:prose forKey:moveID];
        }
        
    }
}

//Returns move prose. Eliminates new lines in csv (no idea why the fuck there are arbitrary new lines in there)
- (NSString*) getMoveProse: (Move*) move
{
    NSString* str = [moveProse objectForKey:move.moveID];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return str;
}

- (NSString*) getMoveEffectProse: (Move*) move
{
    NSString* ptemp = [effectProses objectForKey:move.effectID];
    int start = -1;
    int end = -1;
    for (int i = 0; i < [ptemp length]; i++)
    {
        if ([ptemp characterAtIndex:i] == '$')
            start = i;
        if ([ptemp characterAtIndex:i] == '%')
            end = i;
    }
    
    if (end != -1 && start != -1)
    {
        ptemp = [ptemp stringByReplacingOccurrencesOfString: @"$effect_chance%" withString: [NSString stringWithFormat:@"%@%%", move.effectChance]];
        
        NSRegularExpression *regex = [NSRegularExpression
        regularExpressionWithPattern:@"\\{.+?\\}"
        options:NSRegularExpressionCaseInsensitive
        error:NULL];
        
        [regex replaceMatchesInString:ptemp
                              options:0
                                range:NSMakeRange(0, [ptemp length])
                         withTemplate:@""];
    }
    
    ptemp = [ptemp stringByReplacingOccurrencesOfString:@"[" withString:@""];
    
    ptemp = [ptemp stringByReplacingOccurrencesOfString:@"]" withString:@""];

    return ptemp;
}

- (Move*) getMoveById:(int)moveId
{
    return [moveDictionary objectForKey:@(moveId)];
}

- (Move*) getMoveByOrderNum: (int) orderNum
{
    NSNumber* key = [sortedKeys objectAtIndex:orderNum];
    return [moveDictionary objectForKey:key];
}

- (int) getNumberOfMoves
{
    return [moveDictionary count];
}

@end
