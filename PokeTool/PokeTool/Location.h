//
//  Location.h
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject<NSCoding>

@property NSString* name;
@property int regionID;
@property int locationID;

- (NSString*) getFormattedName;

+ (Location*) initWithId: (int) locID andRegion: (int) region andName: (NSString*) name;

@end
