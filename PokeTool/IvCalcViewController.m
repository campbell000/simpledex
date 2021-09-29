//
//  IvCalcViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 5/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "IvCalcViewController.h"
#import "NatureDatabase.h"
#import "StatContainer.h"
#import "BackgroundLayer.h"
#import "IvCalculator.h"
#import "ViewUtil.h"

@interface IvCalcViewController ()

@end

@implementation IvCalcViewController

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
    natureDatabase = [NatureDatabase getNatureDatabase];
    self->pokemonDatabase = [PokemonDatabase getPokemonDatabase];
    
    [self initCalculateButton];
    [self initPicker];
    [self setupDismissWheelFunction];
    
    //CHange Title of view
    self.title = [NSString stringWithFormat:@"%@ IV Calc", pokemon.name];
    
    //Setup info button action
    [self.infoButton addTarget:self action:@selector(createInfoAlert)forControlEvents:UIControlEventTouchUpInside];
    
    //format result box
    [ViewUtil formatBox:self.resultsBox];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void) initPicker
{
    naturePicker = [[UIPickerView alloc] init];
    naturePicker.dataSource = self;
    naturePicker.delegate = self;
    [self.natureField setInputView:naturePicker];
}

- (void) createInfoAlert
{
    NSString* text = @"IV values are given as a range of possible values, with the lowest value being the most probable value. Higher levels yield more accurate results.";
    UIAlertView* finalCheck = [[UIAlertView alloc]
                               initWithTitle:@"Note about IV Calculator"
                               message:text
                               delegate:self
                               cancelButtonTitle:nil
                               otherButtonTitles:@"Understood!",nil];
    finalCheck.cancelButtonIndex = -1;
    [finalCheck show];
}

- (void) createErrorAlert
{
    NSString* text = @"One or more of the stat values has been entered incorrectly. Please verify that the stats, level, EVs, nature, and pokemon are all correct, and try again. ";
    UIAlertView* finalCheck = [[UIAlertView alloc]
                               initWithTitle:@"Note about IV Calculator"
                               message:text
                               delegate:self
                               cancelButtonTitle:nil
                               otherButtonTitles:@"I'll check again...!",nil];
    finalCheck.cancelButtonIndex = -1;
    [finalCheck show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initCalculateButton
{
    self.calculateButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.calculateButton.layer.borderWidth = .5;
    [self.calculateButton.layer setCornerRadius:10.0];

    [self.calculateButton addTarget:self action:@selector(calculateIVs)forControlEvents:UIControlEventTouchUpInside];
}

- (void) calculateIVs
{
    IvCalculator* calculator = [[IvCalculator alloc] init];
    double* statArray = malloc(7 * sizeof(double));
    int* evArray = malloc(7 * sizeof(int));
    
    //Get values from fields
    statArray[HP] = [self.hpStatField.text intValue];
    evArray[HP] = [self.hpEvField.text intValue];
    statArray[ATTACK] = [self.attackStatField.text intValue];
    evArray[ATTACK] = [self.attackEvField.text intValue];
    evArray[DEFENSE] = [self.defenseEvField.text intValue];
    statArray[DEFENSE] = [self.defenseStatField.text intValue];
    statArray[SP_ATK] = [self.spAttackStatField.text intValue];
    evArray[SP_ATK] = [self.spAttackEvField.text intValue];
    statArray[SP_DEF] = [self.spDefenseStatField.text intValue];
    evArray[SP_DEF]= [self.spDefenseEvField.text intValue];
    statArray[SPEED] = [self.speedStatField.text intValue];
    evArray[SPEED] = [self.speedEvField.text intValue];
    
    //get level
    int level = [self.levelField.text intValue];
    
    //Calculate IVs using the IVCalculator
    int** ivRanges = [calculator calculateIVs:pokemon withStats:statArray withEvs:evArray withLevel:level withNature:nature];
    
    if (ivRanges == nil)
        [self createErrorAlert];
    else
    {
        int* lowerIvArray = ivRanges[0];
        int* higherIvArray = ivRanges[1];
        NSString* totalsString = [calculator calculateIvTotal:lowerIvArray andUpper:higherIvArray];
        
        [self displayResults: lowerIvArray andHigher: higherIvArray andTotals: totalsString];
        
        free(ivRanges[0]);
        free(ivRanges[1]);
        free(ivRanges);
    }
}

- (void) displayResults: (int*) lower andHigher: (int*) higher andTotals: (NSString*) totals
{
    self.attackField.text = [NSString stringWithFormat:@"%d-%d", lower[ATTACK], higher[ATTACK]];
    self.defenseField.text = [NSString stringWithFormat:@"%d-%d", lower[DEFENSE], higher[DEFENSE]];
    self.spAttackField.text = [NSString stringWithFormat:@"%d-%d", lower[SP_ATK], higher[SP_ATK]];
    self.spDefenseField.text = [NSString stringWithFormat:@"%d-%d", lower[SP_DEF], higher[SP_DEF]];
    self.speedField.text = [NSString stringWithFormat:@"%d-%d", lower[SPEED], higher[SPEED]];
    self.hpField.text = [NSString stringWithFormat:@"%d-%d", lower[HP], higher[HP]];
    self.totalsLabel.text = totals;
}

- (void) setPokemonNum: (int) num
{
    if (pokemonDatabase == NULL)
        pokemonDatabase = [PokemonDatabase getPokemonDatabase];
    pokemon = [pokemonDatabase getPokemon:num];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableDictionary* natures = [natureDatabase getNatures];
    nature = [natures objectForKey:@(row)];
    self.natureField.text = [[nature getName] capitalizedString];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 200;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
    NSMutableDictionary* natures = [natureDatabase getNatures];
    Nature* n = [natures objectForKey:@(row)];
    returnStr = [[n getName]capitalizedString];
    
    return returnStr;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSMutableDictionary* natures = [natureDatabase getNatures];
    return [natures count];
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