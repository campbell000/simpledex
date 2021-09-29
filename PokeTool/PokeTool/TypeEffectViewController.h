//
//  TypeEffectViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 6/25/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#define IMMUNE 0
#define VERY_RESISTANT 25
#define RESISTANT 50
#define WEAK 200
#define VERY_WEAK 400

@interface TypeEffectViewController : UIViewController
{
    NSArray* immunes;
    int immuneIndex;
    
    NSArray* vRests;
    int vRestIndex;
    
    NSArray* rests;
    int restIndex;
    
    NSArray* weaks;
    int weakIndex;
    
    NSArray* vWeaks;
    int vWeakIndex;
    
    Pokemon* pokemon;

}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *immune1;
@property (weak, nonatomic) IBOutlet UIImageView *immune2;
@property (weak, nonatomic) IBOutlet UIImageView *immune3;
@property (weak, nonatomic) IBOutlet UIImageView *immune4;
@property (weak, nonatomic) IBOutlet UIImageView *immune5;
@property (weak, nonatomic) IBOutlet UIImageView *immune6;
@property (weak, nonatomic) IBOutlet UIImageView *immune7;
@property (weak, nonatomic) IBOutlet UIImageView *immune8;
@property (weak, nonatomic) IBOutlet UIImageView *immune9;
@property (weak, nonatomic) IBOutlet UIImageView *immune10;
@property (weak, nonatomic) IBOutlet UIImageView *immune11;
@property (weak, nonatomic) IBOutlet UIImageView *immune12;
@property (weak, nonatomic) IBOutlet UIImageView *immune13;

@property (weak, nonatomic) IBOutlet UIImageView *vRest1;
@property (weak, nonatomic) IBOutlet UIImageView *vRest2;
@property (weak, nonatomic) IBOutlet UIImageView *vRest3;
@property (weak, nonatomic) IBOutlet UIImageView *vRest4;
@property (weak, nonatomic) IBOutlet UIImageView *vRest5;
@property (weak, nonatomic) IBOutlet UIImageView *vRest6;
@property (weak, nonatomic) IBOutlet UIImageView *vRest7;
@property (weak, nonatomic) IBOutlet UIImageView *vRest8;
@property (weak, nonatomic) IBOutlet UIImageView *vRest9;
@property (weak, nonatomic) IBOutlet UIImageView *vRest10;
@property (weak, nonatomic) IBOutlet UIImageView *vRest11;
@property (weak, nonatomic) IBOutlet UIImageView *vRest12;
@property (weak, nonatomic) IBOutlet UIImageView *vRest13;

@property (weak, nonatomic) IBOutlet UIImageView *rest1;
@property (weak, nonatomic) IBOutlet UIImageView *rest2;
@property (weak, nonatomic) IBOutlet UIImageView *rest3;
@property (weak, nonatomic) IBOutlet UIImageView *rest4;
@property (weak, nonatomic) IBOutlet UIImageView *rest5;
@property (weak, nonatomic) IBOutlet UIImageView *rest6;
@property (weak, nonatomic) IBOutlet UIImageView *rest7;
@property (weak, nonatomic) IBOutlet UIImageView *rest8;
@property (weak, nonatomic) IBOutlet UIImageView *rest9;
@property (weak, nonatomic) IBOutlet UIImageView *rest10;
@property (weak, nonatomic) IBOutlet UIImageView *rest11;
@property (weak, nonatomic) IBOutlet UIImageView *rest12;
@property (weak, nonatomic) IBOutlet UIImageView *rest13;

@property (weak, nonatomic) IBOutlet UIImageView *weak1;
@property (weak, nonatomic) IBOutlet UIImageView *weak2;
@property (weak, nonatomic) IBOutlet UIImageView *weak3;
@property (weak, nonatomic) IBOutlet UIImageView *weak4;
@property (weak, nonatomic) IBOutlet UIImageView *weak5;
@property (weak, nonatomic) IBOutlet UIImageView *weak6;
@property (weak, nonatomic) IBOutlet UIImageView *weak7;
@property (weak, nonatomic) IBOutlet UIImageView *weak8;
@property (weak, nonatomic) IBOutlet UIImageView *weak9;
@property (weak, nonatomic) IBOutlet UIImageView *weak10;
@property (weak, nonatomic) IBOutlet UIImageView *weak11;
@property (weak, nonatomic) IBOutlet UIImageView *weak12;
@property (weak, nonatomic) IBOutlet UIImageView *weak13;

@property (weak, nonatomic) IBOutlet UIImageView *vWeak1;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak2;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak3;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak4;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak5;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak6;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak7;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak8;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak9;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak10;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak11;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak12;
@property (weak, nonatomic) IBOutlet UIImageView *vWeak13;

@property (weak, nonatomic) IBOutlet UIView *immuneBox;
@property (weak, nonatomic) IBOutlet UIView *vRestBox;
@property (weak, nonatomic) IBOutlet UIView *restBox;
@property (weak, nonatomic) IBOutlet UIView *weakBox;
@property (weak, nonatomic) IBOutlet UIView *vWeakBox;
@property (weak, nonatomic) IBOutlet UILabel *immuneLabel;
@property (weak, nonatomic) IBOutlet UILabel *vRestLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *weakLabel;
@property (weak, nonatomic) IBOutlet UILabel *vWeakLabel;















- (void) setPokemon: (Pokemon*) p;

@end
