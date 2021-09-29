//
//  ViewUtil.h
//  PokeTool
//
//  Created by Alex Campbell on 7/12/14.
//  Copyright (c) 2014 Alex Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

//Useful macros for version number comparisons
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ViewUtil : NSObject

+ (void) formatNavigator: (UINavigationController*) navController;
+ (void) formatImage: (UIImageView*) image;
+ (void) formatBox: (UIView*) box withBorderColor: (UIColor*)color;
+ (void) formatText: (UILabel*) text;
+ (UIColor*) customColorRed: (int) red green: (int)green blue: (int) blue;
+ (void) formatImage: (UIImageView*) image withColor: (UIColor*)color;
+ (void) formatButton: (UIButton*) button;
+ (void) formatTableView: (UITableView*) tableView;
+ (void) formatTableCell: (UITableViewCell*) cell;

+ (void) formatBox: (UIView*) box;
+ (void) formatButton: (UIButton*) image withColor: (UIColor*)color;
+ (void) createAlert: (NSString*) text withTitle: (NSString*) title withButtonText: (NSString*) buttonText;








@end
