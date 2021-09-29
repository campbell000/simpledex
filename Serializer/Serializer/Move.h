//
//  Move.h
//  PokeTool
//
//  Created by Alex Campbell on 1/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Move : NSObject<NSCoding>
{
    enum attributes
    {
        MOVE_ID,IDENTIFIER,GENERATION_ID,TYPE_ID,POWER,PP,ACCURACY,PRIORITY,TARGET_ID,DAMAGE_CLASS_ID,EFFECT_ID,EFFECT_CHANCE,CONTEST_TYPE_ID,CONTEST_EFFECT_ID,SUPER_CONTEST_EFFECT_ID
    };
}

@property NSNumber* moveID;
@property NSString* moveName;
@property NSNumber* generationID;
@property NSNumber* typeID;
@property NSNumber* power;
@property NSNumber* pp;
@property NSNumber* accuracy;
@property NSNumber* effectID;
@property NSNumber* effectChance;
@property NSNumber* moveClass;

+ (Move*) createMove: (NSNumber*) moveID name: (NSString*)name genID: (NSNumber*)gen typeid: (NSNumber*) typeID power: (NSNumber*) pow pps: (NSNumber*) powerPoints acc: (NSNumber*) acc effectid: (NSNumber*) effectId effectchance: (NSNumber*) effectchance;

+ (Move*) createMoveFromAttributeArray: (NSArray*) attr;

- (NSString*) getFormattedName;

- (NSString*) getFormattedPower;

- (NSString*) getFormattedAccuracy;

- (NSString*) getFormattedPP;

-(void)encodeWithCoder:(NSCoder *)encoder;

- (id)initWithCoder:(NSCoder *)decoder;
@end
