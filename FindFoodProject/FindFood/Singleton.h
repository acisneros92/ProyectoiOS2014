//
//  Singleton.h
//  FindFood
//
//  Created by Alexander Baumann on 11/16/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurante.h"

@interface Singleton : NSObject

-(void) clear;

@property (strong,nonatomic) NSMutableArray *arregloSingleton;

+(Singleton *) getSharedInstance;
-(void) crearArreglo;
-(void) agregarAlArreglo: (Restaurante*) rest;

//-(void)guardarArchivo;
@end
