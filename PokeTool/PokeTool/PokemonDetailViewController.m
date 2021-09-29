//
//  PokemonDetailViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 12/30/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon.h"
#import "PokemonMovesetDatabase.h"
#import "PokemonMoveset.h"
#import "MoveLearnedViewController.h"
#import "TypeEffectViewController.h"
#import "EvoPokeViewController.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"
#import <quartzcore/QuartzCore.h>

@interface PokemonDetailViewController ()

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get image of arrow
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"arrow" ofType:@"png"];
    arrow =  [UIImage imageWithContentsOfFile: strPath];

    pokemonDatabase = [PokemonDatabase getPokemonDatabase];
    Pokemon* initialPoke = [pokemonDatabase getPokemon: pokemonNum];
    
    //Init buttons
    [self initMoveButton];
    [self initTypeButton];
    [self initEvoButton];
    [self initPicker];
    [self initEvoImageButtons];
    [self initLocationButton];
    
    //Init picker wheel with types
    [self setupDismissWheelFunction];
    
    //Set view and segues
    [ViewUtil formatBox:self.statBox];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer greyGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
    //Fill in the visual elements
    [self buildView:initialPoke];
    
    //Manually select the pokemon's first
}

- (void) buildView: (Pokemon*) pokemon
{
    //Set title and image border
    pokemonToSend = pokemon;

    
    self.title = [NSString stringWithFormat:@"(No.%d) %@", pokemon.num, pokemon.name];
    [self.artworkView setImage: [pokemon getArtwork]];
    [ViewUtil formatImage: self.artworkView];
    
    //display stats
    [self displayStats: [pokemonDatabase getStats:[pokemon num]]];
    
    //display types
    [self displayTypes:pokemon];
    
    //Display evolutionary chain
    [self displayEvolutionChain: pokemon];
    
    //reset picker
    [self initPicker];
}

- (void) initLocationButton
{
    [self.locationButton addTarget:self action:@selector(goToLocations)forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) goToLocations
{
    [self performSegueWithIdentifier:@"LocationSegue" sender:Nil];
}

- (void) initEvoImageButtons
{
    [self.imageButtonOne addTarget:self action:@selector(changeToDevolution)forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageButtonThree addTarget:self action:@selector(changeToEvolution)forControlEvents:UIControlEventTouchUpInside];
}

- (void) changeToDevolution
{
    [self buildView:fromPokemon];
}

- (void) changeToEvolution
{
    NSLog(@"Forward");
    [self buildView:toPokemon];
}

- (void) initMoveButton
{
   // self.typeEffectButton.layer.borderColor = [UIColor //blackColor].CGColor;
   // self.typeEffectButton.layer.borderWidth = .5;
   // [self.typeEffectButton.layer setCornerRadius:10.0];
    
    [self.typeEffectButton addTarget:self action:@selector(displayTypeEfficacy)forControlEvents:UIControlEventTouchUpInside];
}

- (void) initTypeButton
{
    self.movesButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.movesButton.layer.borderWidth = .5;
    [self.movesButton.layer setCornerRadius:10.0];
    
    [self.movesButton addTarget:self action:@selector(displayMoves)forControlEvents:UIControlEventTouchUpInside];
}

- (void) initEvoButton
{
    self.evoButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.evoButton.layer.borderWidth = .5;
    [self.evoButton.layer setCornerRadius:10.0];
    [self.evoButton addTarget:self action:@selector(displayEvoPokemon)forControlEvents:UIControlEventTouchUpInside];
}

- (void) displayEvoPokemon
{
    [self performSegueWithIdentifier:@"EvoPokemonSegue" sender:Nil];
}

- (void) displayMoves
{
    [self performSegueWithIdentifier:@"MovesLearnedSegue" sender:Nil];
}

- (void) displayTypeEfficacy
{
    [self performSegueWithIdentifier:@"TypeEffectSegue" sender:Nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MovesLearnedSegue"])
    {
        // Get reference to the destination view controller
        MoveLearnedViewController* vc = [segue destinationViewController];
        
        //Get moves that the pokemon learns
        NSArray* moveset = [PokemonMovesetDatabase searchForMovesetById:pokemonToSend.num];
        movesToSend = moveset;
        
        // Pass any objects to the view controller here, like...
        [vc setMoveset: movesToSend];
    }
    else if ([[segue identifier] isEqualToString:@"TypeEffectSegue"])
    {
        TypeEffectViewController* vc = [segue destinationViewController];
        
        [vc setPokemon:pokemonToSend];
    }
    else if ([[segue identifier] isEqualToString:@"EvoPokemonSegue"])
    {
        EvoPokeViewController* vc = [segue destinationViewController];
        
        NSMutableArray* next = [pokemonDatabase getAllEvolutions:pokemonToSend];
        
        Pokemon* from = pokemonToSend;
        NSMutableArray* to = next;
        Pokemon* previous = [pokemonDatabase getPreviousEvolvedPokemon:pokemonToSend];
        
        /**
         * Sometimes, people search for evolution triggers by the 
         * evolved pokemon, and not the pokemon to evolve. So,
         * adding this check will show evolution triggers for both
         * kinds of searchs. EX: if charizard is selected, the next
         * screen will show how charizard evolves.
         */
        if ([to count] < 1 && previous != Nil)
        {
            
            from = previous;
            to = [NSMutableArray arrayWithObject:pokemonToSend];
        }
        
        
        [vc setPokemon:from];
        [vc setEvolutions:to];
    }
    else if ([[segue identifier] isEqualToString:@"LocationSegue"])
    {
        EvoPokeViewController* vc = [segue destinationViewController];
        [vc setPokemon:pokemonToSend];
    }
}

- (void) setPokemonSegueButtons
{
    if (toPokemon == Nil)
    {
        [self.imageButtonThree setEnabled:NO];
        self.imageButtonThree.hidden = YES;
    }
    else
    {
        [self.imageButtonThree setEnabled:YES];
    }
    
    if (fromPokemon == Nil)
    {
        [self.imageButtonOne setEnabled:NO];
        self.imageButtonOne.hidden = YES;
    }
    else
    {
        [self.imageButtonOne setEnabled: YES];
    }
}

- (void) changePokemonSegueButton: (UIButton*) button toEnabled: (BOOL) enabled
{
    button.enabled = enabled;
    button.hidden = !enabled;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setPokemonNum: (int) num
{
    pokemonNum = num;
}

- (void) initPicker
{
    if (formPicker == NULL)
    {
        NSLog(@"HERE");
        formPicker = [[UIPickerView alloc] init];
    }
    formPicker.dataSource = self;
    formPicker.delegate = self;
    [self.formInput setInputView:formPicker];
    self.formInput.text = @"Normal";
}


- (void) displayStats: statContainer
{
    self.hpLabel.text = [NSString stringWithFormat:@"%d", [statContainer getStatOfType:0]];
    self.attackLabel.text = [NSString stringWithFormat:@"%d", [statContainer getStatOfType:1]];
    self.defenseLabel.text = [NSString stringWithFormat:@"%d", [statContainer getStatOfType:2]];
    self.spattackLabel.text = [NSString stringWithFormat:@"%d", [statContainer getStatOfType:3]];
    self.spDefenseLabel.text = [NSString stringWithFormat:@"%d", [statContainer getStatOfType:4]];
    self.speedLabel.text = [NSString stringWithFormat:@"%d", [statContainer getStatOfType:5]];
    
    self.totalLabel.text = [NSString stringWithFormat:@"%d", [statContainer getBaseStatTotal]];
    
    //Get effort values and format them
    NSString* evOne = @"";
    NSString* evTwo = @"";
    BOOL assignedFirst = NO;
    
    for (int i = 0; i < 6; i++)
    {
        int evVal = [statContainer getEffortValueOfType:i];
        if (evVal != 0)
        {
            NSString* type = @"HP";
            switch(i)
            {
                case 1:
                    type = @"ATK";
                    break;
                case 2:
                    type = @"DEF";
                    break;
                case 3:
                    type = @"Sp.A";
                    break;
                case 4:
                    type = @"Sp.D";
                    break;
                case 5:
                    type = @"SPD";
                    break;
            }
            if (assignedFirst == NO)
            {
                evOne = [NSString stringWithFormat: @"%d %@", evVal, type];
                assignedFirst = YES;
            }
            else
                evTwo = [NSString stringWithFormat: @"%d %@", evVal, type];
        }
    }
    
    if (![evTwo isEqualToString:@""])
        evOne = [evOne stringByAppendingString:@","];
    
    self.evOneLabel.text = evOne;
    self.evTwoLabel.text = evTwo;
}

- (void) displayTypes: (Pokemon*) p
{
    NSMutableArray* types = [pokemonDatabase getPokemonTypes:p.num];
    NSString* type1 = [pokemonDatabase lookupType:[[types objectAtIndex:0]intValue]];
    NSString* type2 = [pokemonDatabase lookupType:[[types objectAtIndex:1]intValue]];
    
    NSLog(@"Two Types are %@ and %@", type1, type2);
    
    NSString* strPath = [[NSBundle mainBundle] pathForResource:type1 ofType:@"png"];
    UIImage* type1Icon =  [UIImage imageWithContentsOfFile: strPath];
    self.typeImage1.image = type1Icon;
    
    if (![type2 isEqualToString:@"NULL"] && type2 !=  NULL)
    {
        NSString* strPath = [[NSBundle mainBundle] pathForResource:type2 ofType:@"png"];
        UIImage* type1Icon =  [UIImage imageWithContentsOfFile: strPath];
        self.typeImage2.image = type1Icon;
    }
    else
        self.typeImage2.image = nil;
}

- (void) displayArceusType: (NSString*) type
{
    NSString* strPath = [[NSBundle mainBundle] pathForResource:type ofType:@"png"];
    UIImage* type1Icon =  [UIImage imageWithContentsOfFile: strPath];

    self.typeImage1.image = type1Icon;
    self.typeImage2.image = NULL;
}

- (void) displayEvolutionChain: (Pokemon*) pokemon
{
    //Get previous and next pokemon in chain if they exist
    Pokemon* previous = [pokemonDatabase getPreviousEvolvedPokemon:pokemon];
    NSArray* next = [pokemonDatabase getAllEvolutions:pokemon];
    Pokemon* nextPokemon1 = Nil;
    
    //We can have more than one "next" evolution
    if ([next count] > 0)
        nextPokemon1 = [next objectAtIndex:0];
    
    toPokemon = nextPokemon1;
    fromPokemon = previous;
    
    //Set up previous evolution image and label
    if (previous != Nil)
    {
        self.prevToCurrImage.image = arrow;
        self.prevToCurrImage.hidden = NO;
        [ViewUtil formatButton:self.imageButtonOne withColor:[UIColor redColor]];
        self.evoLabel1.text = previous.name;
        [self.imageButtonOne setImage:[previous getArtwork] forState:UIControlStateNormal];
        
        [self changePokemonSegueButton:self.imageButtonOne toEnabled:YES];
    }
    else
    {
        [self changePokemonSegueButton:self.imageButtonOne toEnabled:NO];
        self.prevToCurrImage.hidden = YES;
        self.evoLabel1.text = @"";
    }
    
    //Setup current pokemon image, label, and evo triggers if this pokemon has a previous evolution
    self.evoImage2.image = [pokemon getArtwork];
    self.evoLabel2.text = pokemon.name;
    [ViewUtil formatImage:self.evoImage2];
    
    //Setup next evolution image and label
    if (nextPokemon1 != Nil)
    {
        self.currToNextImage.image = arrow;
        self.currToNextImage.hidden = NO;
        [ViewUtil formatButton:self.imageButtonThree withColor:[UIColor redColor]];
        self.evoLabel3.text = nextPokemon1.name;
        [self.imageButtonThree setImage:[toPokemon getArtwork] forState:UIControlStateNormal];
        
        [self changePokemonSegueButton:self.imageButtonThree toEnabled:YES];
    }
    else
    {
        [self changePokemonSegueButton:self.imageButtonThree toEnabled:NO];
        self.currToNextImage.hidden = YES;
        self.evoLabel3.text = @"";
    }
}

//We only want to change a few things since some elements will hold true for all forms
- (void) changeForms: (Pokemon*) p
{
    [self.artworkView setImage: [p getArtwork]];
    [ViewUtil formatImage: self.artworkView];
    
    //display stats
    [self displayStats: [pokemonDatabase getStats:[p num]]];
    
    //display types
    [self displayTypes: p];
    
    //Exception handling for weird pokemon
    if (p.num == 493)
    {
        [self displayArceusType:[p formName]];
    }
    
    //Set Moves to send
    NSArray* moveset = [PokemonMovesetDatabase searchForMovesetById:p.num];
    movesToSend = moveset;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Alter the views based on the form.
    if (row != 0)
    {
        Pokemon* newForm = [pokemonToSend getForm:row-1];
        [self changeForms: newForm];
        NSMutableArray* forms = pokemonToSend.forms;
        self.formInput.text = [[(Pokemon*)[forms objectAtIndex:row-1]formName]capitalizedString];
    }
    else
    {
        [self changeForms: pokemonToSend];
        self.formInput.text = @"Normal";
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 150;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* formName;
    
    if (row < 1)
        formName =  @"Normal";
    else
    {
        NSMutableArray* forms = pokemonToSend.forms;
        formName = [[(Pokemon*)[forms objectAtIndex:row-1]formName]capitalizedString];
    }
    
    return formName;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //Add 1 for the normal form, which will be the default.
    return [pokemonToSend.forms count]+1;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//Sets up a gesture recognizer to dismiss the nature picker when the background is touched.
- (void) setupDismissWheelFunction
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
    [self.view endEditing:NO];
}

@end
