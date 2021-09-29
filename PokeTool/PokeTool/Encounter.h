//
//  Encounter.h
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Version.h"

@interface Encounter : NSObject<NSCoding>

@property Location* location;
@property Version* version;
@property int minLevel;
@property int maxLevel;
@property NSString* descriptor;

+ (id) initWithLocation: (Location*) l andVersion: (Version*) v andMinLevel: (int) min andMaxLevel: (int) max andDescriptor: (NSString*) str;

@end
