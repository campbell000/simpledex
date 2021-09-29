//
//  IvCalculator.h
//  PokeTool
//
//  Created by Alex Campbell on 8/31/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatContainer.h"
#import "PokemonDatabase.h"
#import "Nature.h"
#define HP 1
#define ATTACK 2
#define DEFENSE 3
#define SP_ATK 4
#define SP_DEF 5
#define SPEED 6


@interface IvCalculator : NSObject

- (int**) calculateIVs: (Pokemon*) pokemon withStats:(double*) statArray withEvs: (int*) evArray withLevel: (int) level withNature: (Nature*) nature;

- (int*) calulateHpIvRange: (int) baseStat withEv: (int) ev withLevel: (int)level withStatValue: (int) statValue;

- (int*) calulateIvRange: (int) baseStat withEv: (int) ev withLevel: (int)level withStatValue: (int) statValue withNatureMod: (double)natureMod;

- (NSString*) calculateIvTotal: (int*)lowerBounds andUpper: (int*)upperBounds;

@end
