//
//  Singleton.m
//  FindFood
//
//  Created by Alexander Baumann on 11/16/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

-(void) clear
{
    
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"favoritos.plist"];
    
    
    
    self.arregloSingleton = [NSMutableArray arrayWithContentsOfFile:plistPath];
    if(self.arregloSingleton == nil){
        self.arregloSingleton = [[NSMutableArray alloc] init];
    }
}
+(Singleton *) getSharedInstance{
    
    
    // 1 variable que guarda la referencia al Api
    static Singleton *_sharedInstance = nil;
    
    // 2 variable que indica que el codigo se ejecuta una sola vez
    static dispatch_once_t oncePredicate;
    
    // 3
    
    dispatch_once(&oncePredicate, ^{
        
        //solo la primera vez crea la instancia ya que el bloque solo se ejecuta un vez  (dispatchonce)
        _sharedInstance = [[Singleton alloc] init];
    });
    return _sharedInstance;
    
}



-(void)crearArreglo
{
    
    NSString *paths = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"favoritos.plist"];
    
    if(self.arregloSingleton == nil){
        
        self.arregloSingleton = [NSMutableArray arrayWithContentsOfFile:paths];
        
    }
    //REVISAR si es nuloi entonces inicializa
    if(self.arregloSingleton == nil){
        self.arregloSingleton = [[NSMutableArray alloc] init];
    }
    
}


-(void)crearArregloConfiguracion
{
    
    NSString *paths = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"configuracion.plist"];
    
    if(self.arregloSingleton == nil){
        
        self.arregloSingleton = [NSMutableArray arrayWithContentsOfFile:paths];
        
    }
    //REVISAR si es nuloi entonces inicializa
    if(self.arregloSingleton == nil){
        self.arregloSingleton = [[NSMutableArray alloc] init];
    }
    
}


-(void) agregarAlArreglo:(Restaurante*) resta
{
    
    NSDictionary *rest = [[NSDictionary alloc] initWithObjectsAndKeys:resta.nombre, @"nombre", resta.direccion, @"direccion", resta.latitud, @"latitud", resta.longitud, @"longitud", nil];
    
    BOOL rep = NO;
    
    if ( [self.arregloSingleton containsObject: rest]){
        
        rep = YES;
    }
    
    if (!rep)
    {
        [self.arregloSingleton insertObject:rest atIndex:0];
        
        [self errorAlert:@"Agregado a favoritos."];
        
        //NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
        //[self.arregloSingleton sortUsingDescriptors:[NSArray arrayWithObject:firstDescriptor]];
    }
    else
    {
        [self errorAlert:@"Favorito duplicado!"];
        
    }
    
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"favoritos.plist"];
    
    
    id plist = [NSPropertyListSerialization dataFromPropertyList:(id)self.arregloSingleton
                                                          format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    [plist writeToFile:plistPath atomically:YES];
    
    
}



-(void) agregarAlArregloConfiguracion:(NSString*) distancia
{
    
  // NSDictionary *rest = [[NSDictionary alloc] initWithObjectsAndKeys:distancia.text, @"nombre", resta.direccion, @"direccion", resta.latitud, @"latitud", resta.longitud, @"longitud", nil];

        [self.arregloSingletonConfiguracion insertObject:distancia atIndex:0];
        
        [self errorAlert:@"Configuración guardada."];

    
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"configuracion.plist"];
    
    
    id plist = [NSPropertyListSerialization dataFromPropertyList:(id)self.arregloSingleton
                                                          format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    [plist writeToFile:plistPath atomically:YES];
    
    
}


-(void) errorAlert:(NSString*) error {
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                     message:error
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alerta show];
}

//-(void) guardarArchivo;
//{
//    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"favoritos.plist"];
//    
//    
//    id plist = [NSPropertyListSerialization dataFromPropertyList:(id)self.arregloSingleton
//                                                          format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
//    [plist writeToFile:plistPath atomically:YES];
// 
//}

@end
