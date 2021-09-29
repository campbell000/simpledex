//
//  Encounter.m
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "Encounter.h"

@implementation Encounter

+ (id) initWithLocation: (Location*) l andVersion: (Version*) v andMinLevel: (int) min andMaxLevel: (int) max andDescriptor: (NSString*) str;

{
    Encounter* e = [Encounter alloc];
    [e setLocation:l];
    [e setVersion:v];
    [e setMinLevel: min];
    [e setMaxLevel: max];
    [e setDescriptor:str];
    
    return e;
}

/*
 @property Location* location;
 @property Version* version;
 @property int minLevel;
 @property int maxLevel;
 @property NSString* descriptor;
 */

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.version forKey:@"version"];
    [encoder encodeInt:self.minLevel forKey:@"minLevel"];
    [encoder encodeInt:self.maxLevel forKey:@"maxLevel"];
    [encoder encodeObject:self.descriptor forKey:@"descriptor"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        Location* l = [decoder decodeObjectForKey:@"location"];
        [self setLocation: l];
        
        Version* v = [decoder decodeObjectForKey:@"version"];
        [self setVersion:v];
        
        int min = [decoder decodeIntForKey:@"minLevel"];
        [self setMinLevel:min];
        
        int max = [decoder decodeIntForKey:@"maxLevel"];
        [self setMaxLevel:max];
        
        NSString* desc = [decoder decodeObjectForKey:@"descriptor"];
        [self setDescriptor:desc];
    }
    return self;
}

@end
