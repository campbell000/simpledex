//
//  Version.m
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "Version.h"

@implementation Version

+ (id) initVersionWithID: (int) n andGroupID: (int) group andName: name
{
    Version* l = [Version alloc];
    [l setVersionID: n];
    [l setName: name];
    [l setGroupID:group];
    
    return l;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self.versionID forKey:@"versionID"];
    [encoder encodeInt:self.groupID forKey:@"groupID"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        int l = [decoder decodeIntForKey:@"versionID"];
        [self setVersionID: l];
        
        int r = [decoder decodeIntForKey:@"groupID"];
        [self setGroupID:r];
        
        NSString* n = [decoder decodeObjectForKey:@"name"];
        [self setName:n];
    }
    return self;
}


- (NSString*) getFormattedName
{
    return [[self.name stringByReplacingOccurrencesOfString:@"-" withString:@" "]capitalizedString];
}

@end
