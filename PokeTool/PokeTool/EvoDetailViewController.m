//
//  EvoDetailViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 6/30/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "EvoDetailViewController.h"
#import "BackgroundLayer.h"

@interface EvoDetailViewController ()

@end

@implementation EvoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    db = [PokemonDatabase getPokemonDatabase];
    
    [self initImages];
    
    EvoTrigger* evoTrigger = [db getEvoTrigger:toPokemon.num];
    [self setEvoTriggerLabels:evoTrigger];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
}

- (void) initImages
{
    [self.fromImage setImage:[fromPokemon getArtwork]];
    [self.toImage setImage:[toPokemon getArtwork] ];
    [self formatImage:self.fromImage];
    [self formatImage:self.toImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setFromPokemon: (Pokemon*) from andTo: (Pokemon*) to
{
    fromPokemon = from;
    toPokemon = to;
}

- (void) formatImage: (UIImageView*) imageView
{
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.borderWidth = 2.0;
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setCornerRadius:3.0];
}

- (void) setEvoTriggerLabels: (EvoTrigger*) evoTrigger
{
    self.location.text = [evoTrigger getLocation];
    self.gender.text = [evoTrigger getGender];
    self.level.text = [NSString stringWithFormat:@"%@", [evoTrigger getMinLevel]];
    self.useItem.text = [evoTrigger getUsedItem];
    self.holdItem.text = [evoTrigger getHeldItem];
    self.time.text = [evoTrigger getTimeOfDay];
    self.move.text = [evoTrigger getKnownMove];
    self.moveType.text = [evoTrigger getKnownMoveType];
    self.happiness.text = [evoTrigger getHappiness];
    self.beauty.text = [evoTrigger getBeauty];
    self.affection.text = [evoTrigger getAffection];
    self.stats.text = [evoTrigger getRelativeStats];
    self.inParty.text = [evoTrigger getPartySpecies];
    self.partyType.text = [evoTrigger getPartyType];
    self.trade.text = [evoTrigger needsTrade];
    self.rain.text = [evoTrigger needsRain];
    self.turn.text = [evoTrigger needsUpsideDown];
    
    [self addSpecificText];
}

- (void) addSpecificText
{
    if (fromPokemon.num == 588)
        self.trade.text = @"YES (For Shelmet)";
    else if (fromPokemon.num == 617)
        self.trade.text = @"Yes (For Karrablast)";
}

@end
