//
//  PokemonDetailViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 12/30/13.
//  Copyright (c) 2013 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonDatabase.h"
#import "PokemonMovesetDatabase.h"

@interface PokemonDetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    int pokemonNum;
    PokemonDatabase* pokemonDatabase;
    PokemonMovesetDatabase* moves;
    Pokemon* pokemonToSend;
    UIImage* arrow;
    NSArray* movesToSend;
    Pokemon* toPokemon;
    Pokemon* fromPokemon;
    UIPickerView* formPicker;
}
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *formInput;
@property (weak, nonatomic) IBOutlet UIButton *typeEffectButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkView;
@property (weak, nonatomic) IBOutlet UILabel *hpLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackLabel;
@property (weak, nonatomic) IBOutlet UIButton *evoButton;
@property (weak, nonatomic) IBOutlet UILabel *defenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *spattackLabel;
@property (weak, nonatomic) IBOutlet UILabel *spDefenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *evOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *evTwoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage1;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage2;
@property (weak, nonatomic) IBOutlet UIButton *imageButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *imageButtonOne;

@property (weak, nonatomic) IBOutlet UILabel *evoLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *evoImage2;
@property (weak, nonatomic) IBOutlet UILabel *evoLabel2;
@property (weak, nonatomic) IBOutlet UILabel *evoLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *currToNextImage;
@property (weak, nonatomic) IBOutlet UILabel *prevToCurrLabel;
@property (weak, nonatomic) IBOutlet UIImageView *prevToCurrImage;
@property (weak, nonatomic) IBOutlet UILabel *currToNextLabel;
@property (weak, nonatomic) IBOutlet UIButton *movesButton;
@property (weak, nonatomic) IBOutlet UIView *statBox;

- (void) setPokemonNum: (int) num;

@end
