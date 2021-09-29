//
//  NatureDatabase.m
//  PokeTool
//
//  Created by Alex Campbell on 5/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "NatureDatabase.h"
#import "CHCSVParser.h"

@implementation NatureDatabase

//Singleton variable that is to be used in all of the views
static NatureDatabase* singletonNatureDatabase = Nil;

- (id) init
{
    natures = [[NSMutableDictionary alloc] init];
    initialized = NO;
    return self;
}

+ (void) initSingleton
{
    singletonNatureDatabase = [self createNatureDatabase];
}

+ (NatureDatabase*) getNatureDatabase
{
    if (singletonNatureDatabase == Nil)
    {
        [self initSingleton];
    }
    return singletonNatureDatabase;
}

+ (NatureDatabase*) createNatureDatabase
{
    NatureDatabase* natureDatabase = [[NatureDatabase alloc] init];
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"natures" ofType:@"csv"];
    NSString *file = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    if (!file) {
        NSLog(@"Error reading file.");
    }
    
    NSArray *array = [[NSArray alloc] init];
    array = [file componentsSeparatedByString:@"\n"];
    //Store the name and number of each pokemon
    for(int i = 1; i < [array count]; i++)
    {
        NSString* natureString = [array objectAtIndex: i];
        //Parse line into array
        NSArray *natureAttribs = [natureString componentsSeparatedByString:@","];
        
        //Create nature object from the data in the array
        Nature* n = [Nature createNatureFromAttributes:natureAttribs];
        
        //Store nature in dictionary
        [natureDatabase->natures setObject: n forKey: @([n getID])];
    }
    
    return natureDatabase;
}

- (NSMutableDictionary*) getNatures
{
    return self->natures;
}
@end
