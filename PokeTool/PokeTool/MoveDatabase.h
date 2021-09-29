//
//  MoveDatabase.h
//  PokeTool
//
//  Created by Alex Campbell on 1/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Move.h"

@interface MoveDatabase : NSObject<NSCoding>
{
    //NSMutableArray* moves;
    NSMutableDictionary* moveDictionary;
    NSArray* sortedKeys;
    NSMutableDictionary* moveProse;
    NSMutableDictionary* effectProses;
}

+ (MoveDatabase*) getMoveDatabase;

+ (MoveDatabase*) createMoveDatabase;

- (NSMutableDictionary*) moveDictionary;

- (void) createMoveDescDictionary;

- (UIImage*) getTypeImage: (Move*) move;

- (NSString*) getMoveProse: (Move*) move;

- (void) createEffectProseDictionary;

- (NSString*) getMoveEffectProse: (Move*) move;

- (UIImage*) getDamageClassImage: (Move*) move;

+ (void) initSingleton;

- (Move*) getMoveById: (int) moveId;

- (Move*) getMoveByOrderNum: (int) orderNum;

- (int) getNumberOfMoves;

-(void)encodeWithCoder:(NSCoder *)encoder;

- (id)initWithCoder:(NSCoder *)decoder;

@end
