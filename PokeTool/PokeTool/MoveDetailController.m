//
//  MoveDetailController.m
//  PokeTool
//
//  Created by Alex Campbell on 1/13/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "MoveDetailController.h"
#import "PokemonDatabase.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"

@interface MoveDetailController ()

@end

@implementation MoveDetailController

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
    
    self.title = [move getFormattedName];
    
    moveDatabase = [MoveDatabase getMoveDatabase];
    
    self.powerLabel.text = [move getFormattedPower];
    self.accuracyLabel.text = [move getFormattedAccuracy];
	self.ppLabel.text = [move getFormattedPP];
    self.moveDescLabel.text = [moveDatabase getMoveProse:move];
    self.effectLabel.text = [moveDatabase getMoveEffectProse:move];
    self.typeImageView.image = [moveDatabase getTypeImage:move];
    self.classImageView.image = [moveDatabase getDamageClassImage:move];
    [ViewUtil formatBox:self.statBox withBorderColor:[UIColor grayColor]];
    
    [self formatCells];
    
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setMove: (Move*) m
{
    move = m;
}

- (void) formatCells
{
    [ViewUtil formatBox:self.effectBox withBorderColor:[UIColor grayColor]];
    
    [ViewUtil formatText:self.effectLabel];
    
    [ViewUtil formatBox:self.descBox withBorderColor:[UIColor grayColor]];
    
    [ViewUtil formatText:self.moveDescLabel];
    
    [self changeBoxColors];
}

- (void) changeBoxColors
{
    PokemonDatabase* pokeDatabase = [PokemonDatabase getPokemonDatabase];
    NSString* type = [[pokeDatabase lookupType: [move.typeID intValue]]lowercaseString];
    UIColor* color;
    
    if ([type isEqualToString:@"fire"])
        color = [self customColorRed:265 green:69 blue: 100];
    else if ([type isEqualToString:@"normal"])
        color = [UIColor blackColor];
    else if ([type isEqualToString:@"fighting"])
        color = [self customColorRed:102 green:0 blue:0];
    else if ([type isEqualToString:@"flying"])
        color = [self customColorRed:153 green:102 blue:255];
    else if ([type isEqualToString:@"poison"])
        color = [self customColorRed:102 green:0 blue:153];
    else if ([type isEqualToString:@"ground"])
        color = [self customColorRed:204 green:204 blue:51];
    else if ([type isEqualToString:@"rock"])
        color = [self customColorRed:204 green:153 blue:0];
    else if ([type isEqualToString:@"bug"])
        color = [self customColorRed:102 green:153 blue:0];
    else if ([type isEqualToString:@"ghost"])
        color = [self customColorRed:60 green:0 blue:60];
    else if ([type isEqualToString:@"steel"])
        color = [self customColorRed:224 green:224 blue:224];
    else if ([type isEqualToString:@"water"])
        color = [self customColorRed:102 green:179 blue:255];
    else if ([type isEqualToString:@"grass"])
        color = [self customColorRed:0 green:204 blue:0];
    else if ([type isEqualToString:@"electric"])
        color = [self customColorRed:230 green:230 blue:0];
    else if ([type isEqualToString:@"psychic"])
        color = [self customColorRed:255 green:77 blue:255];
    else if ([type isEqualToString:@"ice"])
        color = [self customColorRed:51 green:251 blue:204];
    else if ([type isEqualToString:@"dragon"])
        color = [self customColorRed:33 green:0 blue:133];
    else if ([type isEqualToString:@"dark"])
        color = [self customColorRed:0 green:26 blue:26];
    else if ([type isEqualToString:@"fairy"])
        color = [self customColorRed:204 green:102 blue:53];
        
        
    self.descBox.layer.borderColor = [color CGColor];
    self.effectBox.layer.borderColor = [color CGColor];
    self.statBox.layer.borderColor = [color CGColor];
}

- (UIColor*) customColorRed: (int) red green: (int)green blue: (int) blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue: blue/255.0 alpha: 1.0];
}

@end
