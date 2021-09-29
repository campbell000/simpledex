//
//  Pokemon.m
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import "Pokemon.h"
#import "PokemonDatabase.h"
@import AppKit;

@implementation Pokemon

const double ATTACK = 1;
const double DEFENSE = 2;
const double SP_ATTACK = 3;
const double SP_DEFENSE = 4;
const double SPEED = 5;
const double HP = 0;

+(id) initWithNum: (int)n AndName: (NSString*)theName AndIcon: (NSImage*) i AndOrderNum: (int)oNum andSpeciesID: (int) s
{
    Pokemon* pokemon = [self alloc];
    [pokemon setNum: n];
    [pokemon setName: theName];
    [pokemon setIcon: i];
    [pokemon initStats];
    [pokemon setOrderNum:oNum];
    pokemon.forms = [[NSMutableArray alloc]init];
    pokemon.formName = @"";
    pokemon.speciesID = s;
    return pokemon;
}

- (NSData *) PNGRepresentationOfImage:(NSImage *) image
{
     // Create a bitmap representation from the current image
    [image lockFocus];
    NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    NSLog(@"Dimensions: %f x %f", image.size.width, image.size.height);
    [image unlockFocus];
    
return [bitmapRep representationUsingType:NSPNGFileType properties:Nil];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self->orderNum = [decoder decodeIntForKey:@"orderNum"];
        self->num = [decoder decodeIntForKey:@"num"];
        self->speciesID = [decoder decodeIntForKey:@"speciesID"];
        self->name = [[decoder decodeObjectForKey:@"name"]mutableCopy];
        self->height= [decoder decodeIntForKey:@"height"];
        self->weight= [decoder decodeIntForKey:@"weight"];
        self->icon = [[NSImage alloc] initWithData:[decoder decodeObjectForKey:@"icon"]];
        self->baseStats= [decoder decodeObjectForKey:@"baseStats"];
        self->forms= [[decoder decodeObjectForKey:@"forms"]mutableCopy];
        self->formName= [[decoder decodeObjectForKey:@"formName"]mutableCopy];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self->orderNum forKey:@"orderNum"];
    [encoder encodeInt:self->num forKey:@"num"];
    [encoder encodeInt:self->speciesID forKey:@"speciesID"];
    [encoder encodeObject:self->name forKey:@"name"];
    [encoder encodeInt:self->height forKey:@"height"];
    [encoder encodeInt:self->weight forKey:@"weight"];
    [encoder encodeObject:[self PNGRepresentationOfImage:self->icon] forKey:@"icon"];
    [encoder encodeObject:self->baseStats forKey:@"baseStats"];
    [encoder encodeObject:self->forms forKey:@"forms"];
    [encoder encodeObject:self->formName forKey:@"formName"];
}

- (NSString*) formName
{
    return formName;
}

- (void) setFormName: (NSString*) f
{
    formName = f;
}

- (NSMutableArray*) forms
{
    return forms;
}

- (void) setForms: (NSMutableArray*) f
{
    forms = f;
}

- (void)setName:(NSString *)theName
{
    name = theName;
}

- (void) setNum:(int)n
{
    num = n;
}

- (int)num
{
    return num;
}

- (NSString*)name
{
    return name;
}

- (void) setIcon: (NSImage*) i
{
    icon = i;
}


- (void) setStat: (int) type WithValue: (int) value
{
    //accounts for the off-by-one mismatch of the csv file
    int actualType = type - 1;
    [baseStats setObject:@(value) atIndexedSubscript:actualType];
}

- (NSMutableArray*) getStats
{
    return baseStats;
}

- (void) initStats
{
    baseStats = [NSMutableArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),@(0), nil];
    
}

- (NSImage*) getIcon
{
    return icon;
}

- (void) setStats: (NSMutableArray*) stat
{
    baseStats = stat;
}

- (void) setOrderNum: (int) n
{
    orderNum = n;
}

- (int) getOrderNum
{
    return orderNum;
}

- (void) addForm: (Pokemon*) form
{
    [self.forms addObject:form];
}

- (Pokemon*) getForm: (int) n
{
    return [self.forms objectAtIndex:n];
}

// In the implementation
-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    Pokemon* another = [[Pokemon allocWithZone:zone] init];
    another.name = name;
    another.num = num;
    [another setOrderNum:orderNum];
    [another setStats:baseStats];
    [another setSpeciesID:speciesID];
    
    return another;
}

- (int) speciesID
{
    return speciesID;
}

- (void) setSpeciesID: (int) s
{
    speciesID = s;
}

@end
