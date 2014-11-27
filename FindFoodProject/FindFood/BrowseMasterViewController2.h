//
//  BrowseMasterViewController2.h
//  FindFood
//
//  Created by alumno on 13/11/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Restaurante.h"

@interface BrowseMasterViewController2 : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate>


@property (strong,nonatomic) UIActivityIndicatorView *loading;
@property (strong,nonatomic) NSMutableData *responseData;
@property (strong,nonatomic) NSURLConnection *connection;

@property (nonatomic,retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)refresh:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *browseMap;

@end
