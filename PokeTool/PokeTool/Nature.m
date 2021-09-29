//
//  Nature.m
//  PokeTool
//
//  Created by Alex Campbell on 5/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "Nature.h"

@implementation Nature

- (id) init
{
    name = @"blank";
    natureID = -1;
    decreasedStat = -1;
    increasedStat = -1;
    return self;
}

+ (Nature*) createNatureWithName: (NSString*)name andId: (int) nID andIncreasedStat: (int)increased andDecreasedStat: (int)decreased
{
    Nature* nature = [[Nature alloc] init];
    [nature setName:name];
    [nature setID: nID];
    [nature setIncreasedStat:increased];
    [nature setDecreasedStat:decreased];
    
    return nature;
}

+ (Nature*) createNatureFromAttributes: (NSArray*) attribs
{
    int natureID = [[attribs objectAtIndex:0]intValue];
    NSString* name = (NSString*)[attribs objectAtIndex: 1];
    int increased = [[attribs objectAtIndex:2]intValue];
    int decreased = [[attribs objectAtIndex: 3]intValue];
    
    Nature* n = [Nature createNatureWithName:name andId: natureID andIncreasedStat:increased andDecreasedStat:decreased];
    
    return n;
}

- (int) getID
{
    return natureID;
}

- (void) setID: (int) i
{
    natureID = i;
}

- (NSString*) getName
{
    return name;
}

- (void) setName: (NSString*) n
{
    name = n;
}

- (int) getIncreasedStat
{
    return increasedStat;
}

- (void) setIncreasedStat:(int)i
{
    increasedStat = i;
}

- (int) getDecreasedStat
{
    return decreasedStat;
}

- (void) setDecreasedStat:(int)i
{
    decreasedStat = i;
}

@end
