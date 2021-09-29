//
//  LocationViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "LocationViewController.h"
#import "BackgroundLayer.h"
#import "Version.h"
#import "ViewUtil.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *bgLayer = [BackgroundLayer greyGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    locationDatabase = [LocationDatabase getLocationDatabase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setPokemon: (Pokemon*) p
{
    pokemon = p;
}

//Returns number of sections in tableView. NEEDED FOR UITABLEVIEW INTERFACE
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSMutableDictionary* versions = [locationDatabase getAllVersions];
    return [versions count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Version* v = [locationDatabase getVersionById:(int)section+1];
    NSMutableArray* encounters = [locationDatabase getEncountersFor:pokemon inVersion:v];
    
    int count = (int)[encounters count];
    
    //Return a message in the table saying the pokemon can't be found
    if (count == 0)
        return 1;
    else
        return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //Versions start at 1, sections start at 0;
    int versionID = (int)section + 1;
    NSString* str = [[locationDatabase getVersionById:versionID]getFormattedName];
    return str;
}

//defines the data of a cell. NEEDED FOR UITABLEVIEW INTERFACE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoveCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    int section = (int)indexPath.section + 1;
    int row = (int)indexPath.row;
    
    //Get All Encounters for the pokemon at a specific version. Versions start at 1, sections start at 0.
    Version* v = [locationDatabase getVersionById:section];
    NSMutableArray* encounters = [locationDatabase getEncountersFor:pokemon inVersion:v];
    
    if ([encounters count] > 0)
    {
        Encounter* encounter = [encounters objectAtIndex:row];
    
        //Format cell with attributes specific to this view controller
        NSString* locName = [[encounter location]getFormattedName];
        NSString* cellText = @"";
    
        if (![encounter.descriptor isEqualToString:@""])
            cellText = [NSString stringWithFormat: @"%@ - %@ (Lv.%d - Lv.%d)", locName, encounter.descriptor, encounter.minLevel, encounter.maxLevel];
        else
            cellText = [NSString stringWithFormat: @"%@ (Lv.%d - Lv.%d)", locName, encounter.minLevel, encounter.maxLevel];
    
        //Set cell text and adjust size so that everything fits
        cell.textLabel.text = cellText;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    //In this case, the pokemon cannot be found
    else
        cell.textLabel.text = @"Cannot Find in Wild";
    return cell;
    
}


@end
