//
//  EvoPokeViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 6/30/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "EvoPokeViewController.h"
#import "PokemonDatabase.h"
#import "EvoDetailViewController.h"
#import "PokemonDetailViewController.h"
#import "EvoCell.h"
#import "EvoTrigger.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"

@interface EvoPokeViewController ()

@end

@implementation EvoPokeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    db = [PokemonDatabase getPokemonDatabase];
    
    //Make background a gradient light blue
    //This doesn't work right in ios 6?????
    self.table.delegate = self;
    self.table.dataSource = self;
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setPokemon: (Pokemon*) p
{
    pokemon = p;
}

- (void) setEvolutions: (NSMutableArray*) evos
{
    evolutions = evos;
}

//Returns number of sections in tableView. NEEDED FOR UITABLEVIEW INTERFACE
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EvoCell getHeight];
}

//returns number of rows. NEEDED FOR UITABLEVIEW INTERFACE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [evolutions count];
}

//defines the data of a cell. NEEDED FOR UITABLEVIEW INTERFACE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    EvoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EvoView" owner:self options:Nil];
        cell = [nib objectAtIndex:0];
    }
    Pokemon* p = [evolutions objectAtIndex:indexPath.row];
    
    [cell formatCell:pokemon andTo:p];
    [self addSpecificTriggers:cell withPokemon:pokemon andTo: p];
    
    return cell;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"EvoTargetSegue"])
    {
        // Get reference to the destination view controller
        PokemonDetailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setPokemonNum: targetPokemon.num];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    targetPokemon = [evolutions objectAtIndex:indexPath.row];
    
    //Go to the detail view of the target evolution
    @try
    {
        [self performSegueWithIdentifier:@"EvoTargetSegue" sender:Nil];
    }@catch(NSException* e){}
}

/** 
 * Some pokemon have really odd evo requirements that aren't explained well enough in the csvs.
 * So, this is a messy way to make them more descriptive.
 */
- (void) addSpecificTriggers: (EvoCell*) cell withPokemon:(Pokemon*) fromPokemon andTo: (Pokemon*)toPokemon
{
    if (fromPokemon.num == 588)
        cell.triggerThree.text = @"Trade (For Shelmet)";
    else if (fromPokemon.num == 616)
        cell.triggerThree.text = @"Trade (For Karrablast)";
    else if (fromPokemon.num == 290 && toPokemon.num == 292)
    {
        cell.triggerThree.text = @"Empty spot in Party";
        cell.triggerTwo.text = @"Pokeball in Bag";
    }
}


@end
