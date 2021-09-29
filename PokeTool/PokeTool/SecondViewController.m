//
//  SecondViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 12/27/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import "SecondViewController.h"
#import "MoveDatabase.h"
#import "Move.h"
#import "MoveCell.h"
#import "MoveDetailController.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"

@implementation SecondViewController

@synthesize moveTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    moveDatabase = [MoveDatabase getMoveDatabase];
    NSLog(@"WE GOT %d moves", [moveDatabase getNumberOfMoves]);
    isFiltered = NO;
  
    [ViewUtil formatNavigator:self.navigationController];
    [ViewUtil formatTableView:self.moveTableView];
    
    [self setupDismissKeyboardFunction];
    
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    self->count = 0;
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
        return [moveDatabase getNumberOfMoves];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//defines the data of a cell. NEEDED FOR UITABLEVIEW INTERFACE
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row + indexPath.section;
    static NSString *CellIdentifier = @"MoveCell";
    
    MoveCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MoveCell" owner:self options:Nil];
        cell = [nib objectAtIndex:0];
        [ViewUtil formatTableCell:cell];//TODO: WHY IS MOVE SCROLLING SO SLOW?
    }
    
    Move* move = Nil;
    
    /*******Configure the cell**********/
    if (isFiltered == YES)
        move = [searchResults objectAtIndex:row];
    else
        move = [moveDatabase getMoveByOrderNum:row];
    
    [cell formatCell:move];


    return cell;
    
}

//Determines if there is text in the search bar. Filters results if yes.
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    NSLog(@"TEXT CHANGED!");
    if(text.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        NSString* searchText = [text lowercaseString];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"moveName beginswith %@", searchText];
        
       // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K beginswith %@",@"moveName", searchText];
        searchResults = [[moveDatabase.moveDictionary allValues]filteredArrayUsingPredicate: predicate];

        isFiltered = YES;
    }
    
        NSLog(@"tableView is '%@'",self.moveTableView);
    
    [moveTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoveCell* cell = (MoveCell*)[tableView cellForRowAtIndexPath:indexPath];
    moveToSend = cell.move;
    [self performSegueWithIdentifier:@"moveDetailSegue" sender:Nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"moveDetailSegue"])
    {
        // Get reference to the destination view controller
        MoveDetailController* vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setMove: moveToSend];
    }
}

//**********METHODS TO DISMISS KEYBOARD*********//
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar
{
    [aSearchBar resignFirstResponder];
    [self.moveTableView resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.moveTableView resignFirstResponder];
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
        return @"Select a Move:";
    }
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
    [self.moveTableView resignFirstResponder];
}
@end

