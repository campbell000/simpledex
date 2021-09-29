//
//  StatContainer.h
//  PokeTool
//
//  Created by Alex Campbell on 1/3/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatContainer : NSObject<NSCoding>
{
    NSMutableArray* stats;
    NSMutableDictionary* effortValues;
}

+ (StatContainer*) createStatContainer;

- (id) init;

- (void) addStat: (int) type WithValue: (int) value;

- (int) getStatOfType: (int) type;

- (void) addEffortValue: (int) value OfType: (int) type;

- (int) getEffortValueOfType: (int) type;

- (int) getBaseStatTotal;



@end
