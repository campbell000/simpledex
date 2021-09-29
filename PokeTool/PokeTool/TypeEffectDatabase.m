//
//  TypeEffectDatabase.m
//  PokeTool
//
//  Created by Alex Campbell on 6/24/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "TypeEffectDatabase.h"
#import "PokemonDatabase.h"

@implementation TypeEffectDatabase

+ (NSDictionary*) getTypeEffectMatrix:(Pokemon*) pokemon
{
    PokemonDatabase* db = [PokemonDatabase getPokemonDatabase];
    NSMutableArray* types = [db getPokemonTypes:pokemon.num];
    
    int type = [[types objectAtIndex:0]intValue];
    int typeTwo = [[types objectAtIndex:1]intValue];
    
    NSMutableDictionary* matrix = [self getPredefinedTypeMatrix:pokemon.num];
    
    if (matrix == NULL)
    {
        matrix = [[NSMutableDictionary alloc]init];
        NSMutableDictionary* finalMatrix;
    
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"type_efficacy" ofType:@"csv"];
        NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
        if (!file) {
            NSLog(@"Error reading file.");
        }
    
        NSArray *array = [[NSArray alloc] init];
        array = [file componentsSeparatedByString:@"\n"];
    
        //Get type efficacy of the type
        for(int i = 1; i < [array count]; i++)
        {
            NSString* typeEffectString = [array objectAtIndex: i];
        
            //Parse line into array
            NSArray *row = [typeEffectString componentsSeparatedByString:@","];
            int currType = [[row objectAtIndex:TYPE_ID] intValue];
            int targetType = [[row objectAtIndex:TARGET_TYPE]intValue];
        
            //Skip some of the cells if we have not found the type yet.
            if (targetType == type)
            {
                int factor = [[row objectAtIndex:DAMAGE_FACTOR]intValue];
            
                [matrix setObject:@(factor) forKey:@(currType)];
            
                //The next type we want is 18 rows down. -1 for the i++
                i += NUM_TYPES - 1;
            }
        }
    
        //Perform the same thing for the second type, but multiply the factors of each type
        //to get the final factor. (divide by 100 so we get a percentage)
        if (typeTwo != -1)
        {
            finalMatrix = [[NSMutableDictionary alloc]init];
            //Get type efficacy of the type
            for(int i = 1; i < [array count]; i++)
            {
                NSString* typeEffectString = [array objectAtIndex: i];
            
                //Parse line into array
                NSArray *row = [typeEffectString componentsSeparatedByString:@","];
                int currType = [[row objectAtIndex:TYPE_ID] intValue];
                int targetType = [[row objectAtIndex:TARGET_TYPE]intValue];
            
                //Skip some of the cells if we have not found the type yet.
                if (targetType == typeTwo)
                {
                    int factor = [[row objectAtIndex:DAMAGE_FACTOR]intValue];
                    int prevFactor = [[matrix objectForKey:@(currType)]intValue];
                
                    float finalFactor = (float)factor * prevFactor * .01;
                    [finalMatrix setObject:@((int)finalFactor) forKey:@(currType)];
                
                    //The next type we want is 18 rows down. -1 for the i++
                    i += NUM_TYPES - 1;
                }
            }
        }
    
        if (typeTwo == -1)
            return matrix;
        else
            return finalMatrix;
    }
    
    return matrix;
}

//For pokemon like shedinja, who has a type chart that defies the usual game logic.
+ (NSMutableDictionary*)getPredefinedTypeMatrix: (int) pokeNum
{
    PokemonDatabase* db = [PokemonDatabase getPokemonDatabase];
    NSMutableDictionary* dict = NULL;
    if (pokeNum == 292)
    {
        dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"normal"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"fighting"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"poison"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"ground"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"bug"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"steel"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"water"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"grass"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"electric"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"psychic"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"ice"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"dragon"])];
        [dict setObject:@(0) forKey:@([db lookupTypeNumber:@"fairy"])];
        
        [dict setObject:@(200) forKey:@([db lookupTypeNumber:@"flying"])];
        [dict setObject:@(200) forKey:@([db lookupTypeNumber:@"rock"])];
        [dict setObject:@(200) forKey:@([db lookupTypeNumber:@"ghost"])];
        [dict setObject:@(200) forKey:@([db lookupTypeNumber:@"fire"])];
        [dict setObject:@(200) forKey:@([db lookupTypeNumber:@"dark"])];

    }
    return dict;
}

@end
