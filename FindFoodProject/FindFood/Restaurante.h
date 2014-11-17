//
//  Restaurante.h
//  FindFood
//
//  Created by Alexander Baumann on 11/16/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurante : NSObject

@property (strong,nonatomic) NSString *nombre;
@property (strong, nonatomic) NSString *direccion;

@property (strong,nonatomic) NSNumber *latitud;
@property (strong,nonatomic) NSNumber *longitud;


@end
