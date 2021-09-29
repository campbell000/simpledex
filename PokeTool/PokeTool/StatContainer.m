//
//  StatContainer.m
//  PokeTool
//
//  Created by Alex Campbell on 1/3/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "StatContainer.h"

@implementation StatContainer

- (id) init
{
    stats = [NSMutableArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),@(0), nil];
    effortValues = [[NSMutableDictionary alloc] init];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self->stats forKey:@"stats"];
    [encoder encodeObject:self->effortValues forKey:@"effortValues"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self->stats = [[decoder decodeObjectForKey:@"stats"]mutableCopy ];
        self->effortValues = [[decoder decodeObjectForKey:@"effortValues"]mutableCopy];
    }
    return self;
}

+ (StatContainer*) createStatContainer
{
    StatContainer* container = [[StatContainer alloc] init];
    return container;
}

- (void)addStat:(int)type WithValue:(int)value
{
    //accounts for the fact that the types in the csv file are off by 1
    type -= 1;
    
    [stats setObject:@(value) atIndexedSubscript:type];
}

- (int) getStatOfType:(int)type
{
    return [[stats objectAtIndex:type]intValue];
}

- (void) addEffortValue:(int)value OfType:(int)type
{
    type -= 1;
    
    NSNumber* num = [NSNumber numberWithInt: type];
    NSNumber* val = [NSNumber numberWithInt: value];
    [effortValues setObject:val forKey:num];
}

- (int) getEffortValueOfType:(int)type
{
    NSNumber* evType = [NSNumber numberWithInt:type];
    return [[effortValues objectForKey:evType] intValue];
}

- (int) getBaseStatTotal
{
    int total = 0;
    for (int i = 0; i < 6; i++)
    {
        total += [[stats objectAtIndex:i]intValue];
    }
    return total;
}
@end
