//
//  MoveLearnedViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 6/7/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "MoveLearnedViewController.h"
#import "MoveLearnedCell.h"
#import "PokemonMoveset.h"
#import "MoveDetailController.h"
#import "BackgroundLayer.h"

@interface MoveLearnedViewController ()

@end

@implementation MoveLearnedViewController

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
	// Do any additional setup after loading the view.
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Returns number of sections in tableView. NEEDED FOR UITABLEVIEW INTERFACE
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//returns number of rows. NEEDED FOR UITABLEVIEW INTERFACE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moveset count];
}

//defines the data of a cell. NEEDED FOR UITABLEVIEW INTERFACE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoveCell";
    
    MoveLearnedCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MoveLearnedCell" owner:self options:Nil];
        cell = [nib objectAtIndex:0];
        NSLog(@"Creating new Cell");
    }
    PokemonMoveset* move = [moveset objectAtIndex:indexPath.row];
    
    [self formatCell:cell withMoveLearned:move];
    
    return cell;
    
}

- (void) formatCell: (MoveLearnedCell*)cell withMoveLearned: (PokemonMoveset*)move
{
    int level = [move getLevel];
    cell.level.text = [NSString stringWithFormat:@"%d", level];
    
    cell.moveName.text = [[move getMove]getFormattedName];
    cell.move = [move getMove];
}

- (void) setMoveset: (NSArray*) moves
{
    moveset = moves;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoveLearnedCell* cell = (MoveLearnedCell*)[tableView cellForRowAtIndexPath:indexPath];
    moveToSend = cell.move;
    [self performSegueWithIdentifier:@"MoveDetailSegue" sender:Nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"MoveDetailSegue"])
    {
        // Get reference to the destination view controller
        MoveDetailController* vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setMove: moveToSend];
    }
}

@end
