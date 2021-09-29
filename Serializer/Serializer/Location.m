//
//  Location.m
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "Location.h"

@implementation Location

+ (Location*) initWithId: (int) locID andRegion: (int) region andName: (NSString*) name
{
    Location* l = [Location alloc];
    [l setLocationID:locID];
    [l setRegionID:region];
    [l setName: name];
    
    return l;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self.locationID forKey:@"locationID"];
    [encoder encodeInt:self.regionID forKey:@"regionID"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        int l = [decoder decodeIntForKey:@"locationID"];
        [self setLocationID: l];
        
        int r = [decoder decodeIntForKey:@"regionID"];
        [self setRegionID:r];
        
        NSString* n = [decoder decodeObjectForKey:@"name"];
        [self setName:n];
    }
    return self;
}

//Removes Hyphens, makes everything capitalized
- (NSString*) getFormattedName
{
    return [[self.name stringByReplacingOccurrencesOfString:@"-" withString:@" "]capitalizedString];
}

@end
