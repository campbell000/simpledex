//
//  Nature.h
//  PokeTool
//
//  Created by Alex Campbell on 5/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nature : NSObject
{
    int natureID;
    NSString* name;
    int increasedStat;
    int decreasedStat;
}

- (id) init;

+ (Nature*) createNatureWithName: (NSString*)name andId: (int) id andIncreasedStat: (int)increased andDecreasedStat: (int)decreased;

+ (Nature*) createNatureFromAttributes: (NSArray*) attribs;

- (int) getID;
- (void) setID: (int) natureID;

- (NSString*) getName;
- (void) setName: (NSString*) name;

- (int) getIncreasedStat;
- (void) setIncreasedStat: (int) i;

- (int) getDecreasedStat;
- (void) setDecreasedStat: (int) i;



@end
