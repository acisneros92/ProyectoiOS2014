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
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setObjetoSingleton:[Singleton getSharedInstance]];
    [self.objetoSingleton crearArreglo];
    [self configureView];
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
