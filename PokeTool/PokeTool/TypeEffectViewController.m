//
//  TypeEffectViewController.m
//  PokeTool
//
//  Created by Alex Campbell on 6/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import "TypeEffectViewController.h"
#import "PokemonDatabase.h"
#import "TypeEffectDatabase.h"
#import "ViewUtil.h"
#import "BackgroundLayer.h"

@interface TypeEffectViewController ()

@end

@implementation TypeEffectViewController

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
    
    self.title = [NSString stringWithFormat:@"%@", [pokemon name]];
    [self initImageArrays];
    [self initImages];
    [self initTextBoxes];
    
    //Make background a gradient light blue
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (void) initTextBoxes
{

    
    [ViewUtil formatBox:self.immuneBox withBorderColor:[ViewUtil customColorRed:190 green:190 blue:190]];
    [ViewUtil formatBox:self.vRestBox withBorderColor:[ViewUtil customColorRed:140 green:0 blue:0]];
    [ViewUtil formatBox:self.restBox withBorderColor:[ViewUtil customColorRed:190 green:3 blue:3]];
    [ViewUtil formatBox:self.weakBox withBorderColor:[ViewUtil customColorRed:52 green:153 blue:0]];
    [ViewUtil formatBox:self.vWeakBox withBorderColor:[ViewUtil customColorRed:71 green:214 blue:0]];
}

- (void) initImageArrays
{
    immuneIndex = 0;
    immunes = [[NSArray alloc] initWithObjects:self.immune1, self.immune2, self.immune3, self.immune4, self.immune5, self.immune6, self.immune7, self.immune8, self.immune9, self.immune10, self.immune11, self.immune12, self.immune13, nil];
    
    restIndex = 0;
    rests = [[NSArray alloc] initWithObjects:self.rest1, self.rest2, self.rest3, self.rest4, self.rest5, self.rest6, self.rest7, self.rest8, self.rest9, self.rest10, self.rest11, self.rest12, self.rest13, nil];
    
    vRestIndex = 0;
    vRests = [[NSArray alloc] initWithObjects:self.vRest1, self.vRest2, self.vRest3, self.vRest4, self.vRest5, self.vRest6, self.vRest7, self.vRest8, self.vRest9, self.vRest10, self.vRest11, self.vRest12, self.vRest13,nil];
    
    weakIndex = 0;
    weaks = [[NSArray alloc] initWithObjects:self.weak1, self.weak2, self.weak3, self.weak4, self.weak5, self.weak6,self.weak7, self.weak8, self.weak9, self.weak10, self.weak11, self.weak12, self.weak13,nil];
    
    vWeakIndex = 0;
    vWeaks = [[NSArray alloc] initWithObjects:self.vWeak1, self.vWeak2, self.vWeak3, self.vWeak4, self.vWeak5, self.vWeak6, self.vWeak7, self.vWeak8, self.vWeak9, self.vWeak10, self.vWeak11, self.vWeak12, self.vWeak13,nil];
}

- (void) initImages
{
    NSMutableDictionary* typeEffects;
    typeEffects = [TypeEffectDatabase getTypeEffectMatrix:pokemon];
    
    for (int i = 1; i <= NUM_TYPES; i++)
    {
        int factor = [[typeEffects objectForKey:@(i)]intValue];
        if (factor == IMMUNE)
        {
            UIImageView* imgView = [immunes objectAtIndex:immuneIndex];
            immuneIndex++;
            
            imgView.image = [self getImageForType:i];
        }
        else if (factor == VERY_RESISTANT)
        {
            UIImageView* imgView = [vRests objectAtIndex:vRestIndex];
            vRestIndex++;
            
            imgView.image = [self getImageForType:i];
        }
        else if (factor == RESISTANT)
        {
            UIImageView* imgView = [rests objectAtIndex:restIndex];
            restIndex++;
            
            imgView.image = [self getImageForType:i];
        }
        else if (factor == WEAK)
        {
            UIImageView* imgView = [weaks objectAtIndex:weakIndex];
            weakIndex++;
            
            imgView.image = [self getImageForType:i];
        }
        else if (factor == VERY_WEAK)
        {
            UIImageView* imgView = [vWeaks objectAtIndex:vWeakIndex];
            vWeakIndex++;
            
            imgView.image = [self getImageForType:i];
        }
    }
}

- (UIImage*) getImageForType: (int) typeNum
{
    PokemonDatabase* db = [PokemonDatabase getPokemonDatabase];
    NSString* typeName = [db lookupType:typeNum];
    
    NSString* strPath = [[NSBundle mainBundle] pathForResource:typeName ofType:@"png"];
    UIImage* typeIcon =  [UIImage imageWithContentsOfFile: strPath];
    
    return typeIcon;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setPokemon:(Pokemon *)p
{
    pokemon = p;
}


@end
