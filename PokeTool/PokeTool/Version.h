//
//  Version.h
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Version : NSObject<NSCoding>

@property NSString* name;
@property int versionID;
@property int groupID;

+ (id) initVersionWithID: (int) n andGroupID: (int) group andName: name;

- (NSString*) getFormattedName;

@end
