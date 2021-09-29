//
//  FirstViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"

#import <quartzcore/QuartzCore.h>
@implementation FirstViewController

@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchResults = [[NSMutableDictionary alloc] init];

    //init variables
    pokemonDatabase = [PokemonDatabase getPokemonDatabase];
    isFiltered = NO;
    numOfSelectedPokemon = 0;
    
    //Format navigator bar and table
    [ViewUtil formatNavigator:self.navigationController];
    [ViewUtil formatTableView:self.myTableView];
    
    [self setupDismissKeyboardFunction];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer greyGradient];
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
    
    if(isFiltered)
        return[searchResults count];
    
    else
        return [pokemonDatabase numPokemon];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row + 1 + indexPath.section;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //App-wide cell formatting
        [ViewUtil formatTableCell: cell];
    }
    
    Pokemon* pokemon = Nil;
    
    if (isFiltered == YES)
        pokemon = [searchResults objectForKey:@(row)];
    else
        pokemon = [pokemonDatabase getPokemon:row];
    
    
    //Format cell with attributes specific to this view controller
    NSString* cellText = [NSString stringWithFormat: @"%d. %@", pokemon.num, pokemon.name];
    cell.textLabel.text = cellText;
    UIImage* image = [pokemon getIcon];
    cell.imageView.image = image;
    return cell;
    
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    //Clear searchResults
    [searchResults removeAllObjects];
    if(text.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        NSString* searchText = [text lowercaseString];
        isFiltered = YES;
        int matches = 1;
        
        for (int i = 1; i <= [pokemonDatabase numPokemon]; i++)
        {
            Pokemon* currPoke = [pokemonDatabase.pokemonDictionary objectForKey:@(i)];
            NSString* name = [currPoke.name lowercaseString];
            if ([name hasPrefix: searchText])
            {
                [searchResults setObject:currPoke forKey: @(matches)];
                matches++;
            }

        }
    }
    [self.myTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *array = [cell.textLabel.text componentsSeparatedByString:@"."];
    numOfSelectedPokemon = [[array objectAtIndex:0] intValue];
    
    //Check if we're going to the pokemon detail view
    @try
    {
       [self performSegueWithIdentifier:@"pokemonDetailSegue" sender:Nil];
    }@catch(NSException* e){}
    
    //else, go to the IV view
    @try
    {
        [self performSegueWithIdentifier:@"PokemonIvSegue" sender:Nil];
    }@catch(NSException* e){}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"pokemonDetailSegue"])
    {
        // Get reference to the destination view controller
        PokemonDetailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setPokemonNum: numOfSelectedPokemon];
    }
    else //We are going to the IV calculator
    {
        IvCalcViewController *vc = [segue destinationViewController];
        [vc setPokemonNum:numOfSelectedPokemon];
    }
}

//**********METHODS TO DISMISS KEYBOARD*********//
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar
{
    [aSearchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];

}

- (void) setupDismissKeyboardFunction
{
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *notification) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:tap];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *notification) {
        [self.view removeGestureRecognizer:[self.view.gestureRecognizers lastObject]];
    }];
}

- (void)dismissKeyboard:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    [self.myTableView resignFirstResponder];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0)
        return 3.0f;
    return 32.0f;
}

- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return nil;
   } else {
        return @"Select a Pokemon:";
   }
}
@end
