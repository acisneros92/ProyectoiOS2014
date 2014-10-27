//
//  ViewController.h
//  FindFoodProject
//
//  Created by Ariana Cisneros on 26/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *restaurantesTableView;

@property (strong,nonatomic) UIActivityIndicatorView *loading;
@property (strong,nonatomic) NSMutableData *responseData;
@property (strong,nonatomic) NSURLConnection *connection;
- (IBAction)despliegaResultados:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *despliegaFavoritos;


@end
