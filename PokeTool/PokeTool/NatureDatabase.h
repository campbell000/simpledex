//
//  NatureDatabase.h
//  PokeTool
//
//  Created by Alex Campbell on 5/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Nature.h"

@interface NatureDatabase : NSObject
{
    NSMutableDictionary* natures;
    BOOL initialized;
}

- (id) init;

+ (void) initSingleton;

+ (NatureDatabase*) getNatureDatabase;

+ (NatureDatabase*) createNatureDatabase;

- (NSMutableDictionary*) getNatures;

@end
