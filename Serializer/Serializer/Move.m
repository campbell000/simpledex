//
//  Move.m
//  PokeTool
//
//  Created by Alex Campbell on 1/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "Move.h"

@implementation Move

+ (Move*) createMove: (NSNumber*) moveID name: (NSString*)name genID: (NSNumber*)gen typeid: (NSNumber*) typeID power: (NSNumber*) pow pps: (NSNumber*) powerPoints acc: (NSNumber*) acc effectid: (NSNumber*) effectId effectchance: (NSNumber*) effectchance
{
    Move* m = [[Move alloc] init];
    m.moveID = moveID;
    m.moveName = name;
    m.generationID = gen;
    m.typeID = typeID;
    m.power = pow;
    m.pp = powerPoints;
    m.accuracy = acc;
    m.effectID = effectId;
    m.effectChance = effectchance;
    return m;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.moveID forKey:@"moveID"];
    [encoder encodeObject:self.moveName forKey:@"moveName"];
    [encoder encodeObject:self.generationID forKey:@"generationID"];
    [encoder encodeObject:self.typeID forKey:@"typeID"];
    [encoder encodeObject:self.power forKey:@"power"];
    [encoder encodeObject:self.pp forKey:@"pp"];
    [encoder encodeObject:self.accuracy forKey:@"accuracy"];
    [encoder encodeObject:self.effectID forKey:@"effectID"];
    [encoder encodeObject:self.effectChance forKey:@"effectChance"];
    [encoder encodeObject:self.moveClass forKey:@"moveClass"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self.moveID = [decoder decodeObjectForKey:@"moveID"];
        self.moveName = [decoder decodeObjectForKey:@"moveName"];
        self.generationID = [decoder decodeObjectForKey:@"generationID"];
        self.typeID = [decoder decodeObjectForKey:@"typeID"];
        self.power = [decoder decodeObjectForKey:@"power"];
        self.pp = [decoder decodeObjectForKey:@"pp"];
        self.accuracy = [decoder decodeObjectForKey:@"accuracy"];
        self.effectID = [decoder decodeObjectForKey:@"effectID"];
        self.effectChance = [decoder decodeObjectForKey:@"effectChance"];
        self.moveClass = [decoder decodeObjectForKey:@"moveClass"];

    }
    return self;
}

+ (Move*) createMoveFromAttributeArray: (NSArray*) attr
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    Move* m = [[Move alloc] init];
    m.moveID = [f numberFromString:[attr objectAtIndex: MOVE_ID]];
    m.moveName = [attr objectAtIndex: IDENTIFIER];
    m.generationID = [f numberFromString:[attr objectAtIndex: GENERATION_ID]];
    m.typeID = [f numberFromString:[attr objectAtIndex: TYPE_ID]];
    m.power = [f numberFromString:[attr objectAtIndex: POWER]];
    m.pp = [f numberFromString:[attr objectAtIndex: PP]];
    m.accuracy = [f numberFromString:[attr objectAtIndex: ACCURACY]];
    m.effectID = [f numberFromString:[attr objectAtIndex: EFFECT_ID]];
    m.effectChance = [f numberFromString:[attr objectAtIndex: EFFECT_CHANCE]];
    m.moveClass = [f numberFromString:[attr objectAtIndex:DAMAGE_CLASS_ID]];
    
    return m;
}

- (NSString*) getFormattedName
{
    NSString* newName = [self.moveName capitalizedString];
    return [newName stringByReplacingOccurrencesOfString:@"-" withString:@" "];
}

- (NSString*) getFormattedPower
{
    NSString* str;
    if (self.power != Nil && [self.power intValue] > 0)
        str = [NSString stringWithFormat:@"%@", self.power];
    else
        str = @"--";
    
    return str;
    
}

- (NSString*) getFormattedAccuracy
{
    NSString* str;
    if (self.accuracy != Nil)
        str = [NSString stringWithFormat:@"%@", self.accuracy];
    else
        str = @"--";
    
    return str;
    
}

- (NSString*) getFormattedPP
{
    NSString* str;
    if (self.pp != Nil)
        str = [NSString stringWithFormat:@"%@", self.pp];
    else
        str = @"--";
    
    return str;
}

@end
