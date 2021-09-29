//
//  Pokemon.h
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Pokemon : NSObject <NSCopying, NSCoding>
{
    int orderNum;
    int num;
    int speciesID;
    NSString* name;
    int height;
    int weight;
    UIImage* icon;
    NSMutableArray* baseStats;
    NSMutableArray* forms;
    NSString* formName;
}

extern const double ATTACK;
extern const double DEFENSE;
extern const double SP_ATTACK;
extern const double SP_DEFENSE;
extern const double SPEED;
extern const double HP;

+(id) initWithNum: (int)n AndName: (NSString*)theName AndIcon: (UIImage*) i AndOrderNum: (int)oNum andSpeciesID: (int) s;

- (void) setNum: (int) n;
- (void) setName: (NSString*) theName;
- (int) num;
- (NSString*) name;
- (void) setIcon: (UIImage*) i;
- (UIImage*) getIcon;
- (UIImage*) getArtwork;
- (NSMutableArray*) getStats;
- (void) initStats;
- (void) setStat: (int) type WithValue: (int) value;
- (void) setOrderNum: (int) orderNum;
- (int) getOrderNum;
- (NSMutableArray*) forms;
- (void) setFormName: (NSString*) name;
- (void) addForm: (Pokemon*) form;
- (NSString*) formName;
- (Pokemon*) getForm: (int) num;
- (int) speciesID;

@end
