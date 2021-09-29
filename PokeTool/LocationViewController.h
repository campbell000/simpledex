//
//  LocationViewController.h
//  PokeTool
//
//  Created by Alex Campbell on 12/2/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "LocationDatabase.h"

@interface LocationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    Pokemon* pokemon;
    LocationDatabase* locationDatabase;
    NSMutableArray* emptyVersions;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

- (void) setPokemon: (Pokemon*) p;

@end
