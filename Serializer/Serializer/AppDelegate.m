//
//  AppDelegate.m
//  Serializer
//
//  Created by Alex Campbell on 11/26/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "AppDelegate.h"
#import "MoveDatabase.h"
#import "PokemonDatabase.h"
#import "LocationDatabase.h"
#import "Version.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [MoveDatabase initSingleton];
    [PokemonDatabase initSingleton];
    [LocationDatabase initSingleton];
    
    MoveDatabase* db = [MoveDatabase getMoveDatabase];
    PokemonDatabase* pdb = [PokemonDatabase getPokemonDatabase];
    LocationDatabase* locDB = [LocationDatabase getLocationDatabase];
    
    //Create file for move database
    [[NSFileManager defaultManager] createFileAtPath:@"/Users/Alex_Lappy_486/Desktop/SerializedMoveDatabase.txt" contents:nil attributes:nil];
    
    //Create file for pokemon database
    [[NSFileManager defaultManager] createFileAtPath:@"/Users/Alex_Lappy_486/Desktop/SerializedPokemonDatabase.txt" contents:nil attributes:nil];
    
    //Create file for location database
    [[NSFileManager defaultManager] createFileAtPath:@"/Users/Alex_Lappy_486/Desktop/SerializedLocationDatabase.txt" contents:nil attributes:nil];
    
    
    [NSKeyedArchiver archiveRootObject:db toFile:@"/Users/Alex_Lappy_486/Desktop/SerializedMoveDatabase.txt"];
    [NSKeyedArchiver archiveRootObject:pdb toFile:@"/Users/Alex_Lappy_486/Desktop/SerializedPokemonDatabase.txt"];
    [NSKeyedArchiver archiveRootObject:locDB toFile:@"/Users/Alex_Lappy_486/Desktop/SerializedLocationDatabase.txt"];
    
    MoveDatabase* move2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/Alex_Lappy_486/Desktop/SerializedMoveDatabase.txt"];
    PokemonDatabase* pokemon2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/Alex_Lappy_486/Desktop/SerializedPokemonDatabase.txt"];
    LocationDatabase* locDB2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/Alex_Lappy_486/Desktop/SerializedLocationDatabase.txt"];
    
    NSLog(@"New move database count is %d", [move2 getNumberOfMoves]);
    NSLog(@"New pokemon database count is %d", [pokemon2 numPokemon]);
    Pokemon* p = [pokemon2 getPokemon:3];
    
    NSImage* image = [p getIcon];
        NSLog(@"Dimensions: %f x %f", image.size.width, image.size.height);
    
    Pokemon* form = [p getForm:0];
    NSLog(@"Forms of %@: %@", [p name], [form formName]);
    
    Version* v = [locDB2 getVersionById:8];
    NSLog(@"Version name: %@", [v getFormattedName]);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
