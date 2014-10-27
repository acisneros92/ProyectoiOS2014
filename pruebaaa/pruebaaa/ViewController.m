//
//  ViewController.m
//  pruebaaa
//
//  Created by Ariana Cisneros on 24/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)boton1:(id)sender {
    
    self.botonImagen.alpha = 1;
    self.botonImagen2.alpha = 0.25;
}



- (IBAction)boton2:(id)sender {
    self.botonImagen2.alpha = 1;
    self.botonImagen.alpha = 0.25;
}
@end
