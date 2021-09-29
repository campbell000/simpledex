//
//  LocationArea.h
//  PokeTool
//
//  Created by Alex Campbell on 12/26/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationArea : NSObject<NSCoding>
{
    int locationAreaID;
    int locationID;
    int gameID;
    NSString* descriptor;
}

+ (id) initLocationArea: (int) ID withLocID: (int) locID withGameID: (int) gameID withDescriptor: (NSString*) str;

- (int) getID;

- (int) getLocationID;

- (int) getGameID;

- (NSString*) getDescriptor;

- (void) setID: (int) d;

- (void) setLocationID: (int) d;

- (void) setGameID: (int) d;

- (void) setDescriptor: (NSString*) str;

- (NSString*) getFormattedName;

@end
