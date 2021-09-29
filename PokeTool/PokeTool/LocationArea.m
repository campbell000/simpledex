//
//  LocationArea.m
//  PokeTool
//
//  Created by Alex Campbell on 12/26/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "LocationArea.h"

@implementation LocationArea

+ (id) initLocationArea: (int) ID withLocID: (int) locID withGameID: (int) gameID withDescriptor: (NSString*) str
{
    
    /*
     int locationAreaID;
     int locationID;
     int gameID;
     NSString* descriptor;
     */
    LocationArea* newArea = [LocationArea alloc];
    [newArea setID:ID];
    [newArea setLocationID:locID];
    [newArea setGameID:gameID];
    [newArea setDescriptor:str];
    
    return newArea;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self->locationID forKey:@"locationID"];
    [encoder encodeInt:self->locationAreaID forKey:@"locationAreaID"];
    [encoder encodeInt:self->gameID forKey:@"gameID"];
    [encoder encodeObject:self->descriptor forKey:@"descriptor"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        int l = [decoder decodeIntForKey:@"locationID"];
        [self setLocationID: l];
        
        int la = [decoder decodeIntForKey:@"locationAreaID"];
        [self setID:la];
        
        int g = [decoder decodeIntForKey:@"gameID"];
        [self setGameID:g];
        
        NSString* n = [decoder decodeObjectForKey:@"descriptor"];
        [self setDescriptor:n];
    }
    return self;
}

- (int) getID
{
    return locationAreaID;
}

- (int) getLocationID
{
    return locationID;
}

- (int) getGameID
{
    return gameID;
}

- (NSString*) getDescriptor
{
    return descriptor;
}

- (void) setID: (int) d
{
    locationAreaID = d;
}

- (void) setLocationID: (int) d
{
    locationID = d;
}

- (void) setGameID: (int) d
{
    gameID = d;
}

- (void) setDescriptor: (NSString*) str
{
    descriptor = str;
}

//Removes Hyphens, makes everything capitalized
- (NSString*) getFormattedName
{
    return [[[self getDescriptor] stringByReplacingOccurrencesOfString:@"-" withString:@" "]capitalizedString];
}


@end
