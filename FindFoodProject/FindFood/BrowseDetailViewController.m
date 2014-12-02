//
//  BrowseDetailViewController.m
//  FindFood
//
//  Created by Alexander Baumann on 11/4/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import "BrowseDetailViewController.h"

@interface BrowseDetailViewController ()
- (void)configureView;
@end

@implementation BrowseDetailViewController

#pragma mark - Managing the detail item

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
        self.detailDescriptionLabel.text = [[self.detailItem objectForKey:@"venue"] objectForKey:@"name"];
        self.direccion.text =[[[self.detailItem objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"address"];
    }
    
    NSString *latA = [[[self.detailItem objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"lat"];
    NSString *latB = [[[self.detailItem objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"lng"];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [latA doubleValue];
    zoomLocation.longitude = [latB doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    self.mapView.showsUserLocation = YES;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = zoomLocation;
    point.title = [[self.detailItem objectForKey:@"venue"] objectForKey:@"name"];
    
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
    
    [self setObjetoSingleton:[Singleton getSharedInstance]];
    [self.objetoSingleton crearArreglo];
    [self configureView];
    
    if([[[self.detailItem objectForKey:@"venue"] objectForKey:@"categories"] objectAtIndex:0 ]){
    
        NSString *urlA = @"http://";
        NSString *urlB = [[[[self.detailItem objectForKey:@"venue"] objectForKey:@"categories"] objectAtIndex:0] objectForKey:@"name"];
        NSString *urlC = @".jpg.to";
        
        NSString *urlB1 = [urlB stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        
        NSString *urli = [urlA stringByAppendingString:urlB1];
        NSString *url1 = [urli stringByAppendingString:urlC];
        
        NSURL *url = [NSURL URLWithString:url1];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)agregarFavorito:(id)sender {
    
    // Perfil *miPerfl = [[Perfil alloc] initPerfil:self.nombreTF.text email:self.emailTF.text];
    Restaurante *newRestaurante=[[Restaurante alloc] init];
    
    newRestaurante.nombre=self.detailDescriptionLabel.text;
    newRestaurante.direccion=self.direccion.text;
    
    //[NSNumber numberWithDouble:datosRestaurante.latitud]
    
    newRestaurante.latitud= [[[self.detailItem objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"lat"];
    newRestaurante.longitud= [[[self.detailItem objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"lng"];
    
    [self.objetoSingleton agregarAlArreglo:newRestaurante];
    

    
}
@end
