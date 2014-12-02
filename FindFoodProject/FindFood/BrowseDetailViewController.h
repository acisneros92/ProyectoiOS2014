//
//  BrowseDetailViewController.h
//  FindFood
//
//  Created by Alexander Baumann on 11/4/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Restaurante.h"
#import <CoreLocation/CoreLocation.h>
#import "Singleton.h"

@interface BrowseDetailViewController : UIViewController

@property (strong,nonatomic) Singleton *objetoSingleton;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *direccion;
- (IBAction)agregarFavorito:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end


