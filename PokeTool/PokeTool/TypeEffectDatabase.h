//
//  TypeEffectDatabase.h
//  PokeTool
//
//  Created by Alex Campbell on 6/24/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#define NUM_TYPES 18
#define TYPE_ID 0
#define TARGET_TYPE 1
#define DAMAGE_FACTOR 2

@interface TypeEffectDatabase : NSObject

+ (NSMutableDictionary*) getTypeEffectMatrix: (Pokemon*) pokemon;

@end
