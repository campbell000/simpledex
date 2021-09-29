//
//  IvCalculator.m
//  PokeTool
//
//  Created by Alex Campbell on 8/31/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "IvCalculator.h"


@implementation IvCalculator

- (int**) calculateIVs: (Pokemon*) pokemon withStats:(double*) statArray withEvs: (int*) evArray withLevel: (int) level withNature: (Nature*) nature
{
    BOOL statsAreValid = YES;
    PokemonDatabase* pokemonDatabase = [PokemonDatabase getPokemonDatabase];
    StatContainer* baseStats = [pokemonDatabase getStats:pokemon.num];
    
    //Test if the nature does not affect stats
    BOOL ignoreNature = NO;
    if ([nature getIncreasedStat] == [nature getDecreasedStat])
        ignoreNature = YES;
    
    int* lowerIvArray = malloc(7 * sizeof(int));
    int* higherIvArray = malloc(7 * sizeof(int));
    
    //Calculate HP Ivs seperately
    int* ivRange = [self calulateHpIvRange:[baseStats getStatOfType:HP-1] withEv:evArray[HP] withLevel:level withStatValue:statArray[HP]];
    
    //Validate HP stat given by the user
    statsAreValid = [self isHPValid:[baseStats getStatOfType:HP-1] withEv:evArray[HP] withLevel:level withStatValue:statArray[HP]];
    
    lowerIvArray[HP] = ivRange[0];
    higherIvArray[HP] = ivRange[1];
    
    //Go through all of the stats (excluding HP) and calculate IVs.
    for (int statIndex = 2; statIndex < 7; statIndex++)
    {
        //Determine nature modifier
        double natureMod = 1;
        if (ignoreNature == NO)
        {
            if ([nature getIncreasedStat] == statIndex)
                natureMod = .9;
            else if ([nature getDecreasedStat] == statIndex)
                natureMod = 1.1;
        }
        
        //Calculate IV
        int baseStat = [baseStats getStatOfType:statIndex-1];
        int* ivRange = [self calulateIvRange:baseStat withEv:evArray[statIndex] withLevel:level withStatValue:statArray[statIndex] withNatureMod: natureMod];
        
        //Verify that the stat entered by the user is valid
        if (statsAreValid == YES)
            statsAreValid = [self isStatValid:baseStat withEv:evArray[statIndex] withLevel:level withStatValue:statArray[statIndex] withNatureMod:natureMod];
            
        lowerIvArray[statIndex] = ivRange[0];
        higherIvArray[statIndex] = ivRange[1];
        free(ivRange);
    }
    
    free(statArray);
    free(evArray);
    
    //If there was an issue during the calculation, then free all memory and return nil.
    if (statsAreValid == NO)
    {
        free(lowerIvArray);
        free(higherIvArray);
        return nil;
    }
    else
    {
        int** ivRanges = malloc(3 * sizeof(int*));
        ivRanges[0] = lowerIvArray;
        ivRanges[1] = higherIvArray;
    
        return ivRanges;
    }
}

#define HP 1
#define ATTACK 2
#define DEFENSE 3
#define SP_ATK 4
#define SP_DEF 5
#define SPEED 6

- (int*) calulateHpIvRange: (int) baseStat withEv: (int) ev withLevel: (int)level withStatValue: (int) statValue
{
    int* result = malloc(2 * sizeof(int));
    int lower = 0;
    int higher = 0;
    bool lowend = false;
    
    for (int i = 0; i <= 31; i++)
    {
        double stat = [self calculateHP:baseStat withEv:ev withLevel:level withIV:i];
        
        if (statValue == stat && !lowend)
        {
            lower = i;
            lowend = true;
        }
        else if (statValue == stat && lowend)
        {
            higher = i;
        }
    }
    result[0] = lower;
    result[1] = higher;
    
    //If the level is high enough, then there will only be one match
    if (result[0] != 0 && result[1] == 0)
        result[1] = result[0];
    return result;
}

- (int*) calulateIvRange: (int) baseStat withEv: (int) ev withLevel: (int)level withStatValue: (int) statValue withNatureMod: (double)natureMod
{
    int* result = malloc(2 * sizeof(int));
    int lower = 0;
    int higher = 0;
    bool lowend = false;
    
    for (int i = 0; i <= 31; i++)
    {
        double stat = [self calculateStat:baseStat withEv:ev withLevel:level withNatureMod:natureMod withIV:i];
        
        if (statValue == stat && !lowend)
        {
            lower = i;
            lowend = true;
        }
        else if (statValue == stat && lowend)
        {
            higher = i;
        }
    }
    
    result[0] = lower;
    result[1] = higher;
    
    //If the level is high enough, then there will only be one match
    if (result[0] != 0 && result[1] == 0)
        result[1] = result[0];
    return result;
}

- (NSString*) calculateIvTotal: (int*)lowerBounds andUpper: (int*)upperBounds
{
    NSString* totals;
    
    int lowerTotal = 0;
    int higherTotal = 0;
    
    for (int i = 0; i < 7; i++)
    {
        int lower = lowerBounds[i];
        int higher = upperBounds[i];
        
        if (lower >= 0 && lower < 32)
            lowerTotal += lower;
        if (higher >= 0 && higher < 32)
            higherTotal += higher;
    }
    
    totals = [NSString stringWithFormat:@"%d-%d", lowerTotal, higherTotal];
    return totals;
}

- (BOOL) isStatValid: (int) baseStat withEv: (int) ev withLevel: (int)level withStatValue: (int) statValue withNatureMod: (double)natureMod
{
    double maxStat = [self calculateStat:baseStat withEv:ev withLevel:level withNatureMod:natureMod withIV:31];
    double minStat = [self calculateStat:baseStat withEv:ev withLevel:level withNatureMod:natureMod withIV:0];
    
    if (statValue > maxStat || statValue < minStat)
    {
        NSLog(@"Min = %f, Max = %f, Actual = %d", minStat, maxStat, statValue);
        return NO;
    }
    else
        return YES;
}

- (BOOL) isHPValid: (int) baseStat withEv: (int) ev withLevel: (int)level withStatValue: (int) statValue
{
    double maxStat = [self calculateHP:baseStat withEv:ev withLevel:level withIV:31];
    double minStat = [self calculateHP:baseStat withEv:ev withLevel:level withIV:0];
    
    if (statValue > maxStat || statValue < minStat)
    {
        NSLog(@"Min = %f, Max = %f, Actual = %d", minStat, maxStat, statValue);
        return NO;
    }
    else
        return YES;
}



- (double) calculateStat: (int) baseStat withEv: (int) ev withLevel: (int)level withNatureMod: (double)natureMod withIV: (int) i
{
    return floor((floor(((baseStat*2 + (i/1) + floor(ev/4))*level)/100) + 5)*natureMod);
}

- (int) calculateHP: (int) baseStat withEv: (int) ev withLevel: (int)level withIV: (int) i
{
    return (floor(((baseStat*2 + (i/1) + floor(ev/4))*level)/100)) + (level/1) + 10;
}

@end


