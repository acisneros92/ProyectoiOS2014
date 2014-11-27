//
//  FavoritesDetailViewController.m
//  FindFood
//
//  Created by Alexander Baumann on 11/4/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import "FavoritesDetailViewController.h"

@interface FavoritesDetailViewController ()
- (void)configureView;
@end

@implementation FavoritesDetailViewController


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem objectForKey:@"nombre"];
        self.direccion.text = [self.detailItem objectForKey:@"direccion"];
    }
    
    NSString *latA = [self.detailItem objectForKey:@"latitud"];
    NSString *latB = [self.detailItem objectForKey:@"longitud"];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [latA doubleValue];
    zoomLocation.longitude = [latB doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = [self.detailItem objectForKey:@"nombre"];
    
    [self.mapView addAnnotation:point];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)shareFB:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookController setInitialText:[NSString stringWithFormat:@"Estoy en %@",[self.detailItem objectForKey:@"nombre"]]];
        
        [self presentViewController:facebookController animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook error" message:@"you may not have facebook set up or\nyou may not be connected to the internet. \n please check..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    
    
}
@end
