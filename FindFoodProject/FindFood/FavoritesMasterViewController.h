//
//  FavoritesMasterViewController.h
//  FindFood
//
//  Created by Alexander Baumann on 11/4/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurante.h"
#import "Singleton.h"
#import "Celda.h"

@interface FavoritesMasterViewController : UITableViewController

@property (strong,nonatomic) Singleton *objetoSingleton;

@end
