//
//  IvCalcViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 5/9/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonDatabase.h"
#import "NatureDatabase.h"
#define HP 1
#define ATTACK 2
#define DEFENSE 3
#define SP_ATK 4
#define SP_DEF 5
#define SPEED 6

@interface IvCalcViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    PokemonDatabase* pokemonDatabase;
    NatureDatabase* natureDatabase;
    Pokemon* pokemon;
    Nature* nature;
    UIPickerView* naturePicker;
}

- (void) setPokemonNum: (int) num;

@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIView *resultsBox;

@property (weak, nonatomic) IBOutlet UITextField *natureField;
@property (weak, nonatomic) IBOutlet UITextField *levelField;
@property (weak, nonatomic) IBOutlet UITextField *attackStatField;
@property (weak, nonatomic) IBOutlet UITextField *defenseStatField;
@property (weak, nonatomic) IBOutlet UITextField *spDefenseStatField;

@property (weak, nonatomic) IBOutlet UITextField *spAttackStatField;
@property (weak, nonatomic) IBOutlet UITextField *speedStatField;
@property (weak, nonatomic) IBOutlet UITextField *hpEvField;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITextField *attackEvField;
@property (weak, nonatomic) IBOutlet UILabel *totalsLabel;

@property (weak, nonatomic) IBOutlet UITextField *defenseEvField;

@property (weak, nonatomic) IBOutlet UITextField *spAttackEvField;

@property (weak, nonatomic) IBOutlet UITextField *spDefenseEvField;
@property (weak, nonatomic) IBOutlet UITextField *hpStatField;

@property (weak, nonatomic) IBOutlet UITextField *speedEvField;
@property (weak, nonatomic) IBOutlet UILabel *hpField;
@property (weak, nonatomic) IBOutlet UILabel *attackField;
@property (weak, nonatomic) IBOutlet UILabel *defenseField;
@property (weak, nonatomic) IBOutlet UILabel *spAttackField;

@property (weak, nonatomic) IBOutlet UILabel *spDefenseField;
@property (weak, nonatomic) IBOutlet UILabel *speedField;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@end
