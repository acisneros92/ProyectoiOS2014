//
//  FavoritesDetailViewController.h
//  FindFood
//
//  Created by Alexander Baumann on 11/4/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *direccion;

@end

