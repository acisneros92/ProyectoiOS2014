//
//  ConfiguracionViewController.m
//  FindFood
//
//  Created by Ariana Cisneros on 01/12/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import "ConfiguracionViewController.h"

@interface ConfiguracionViewController ()
{
    NSArray *misDistancias; //arreglo de string
    NSString *distancia ;
}
@end

@implementation ConfiguracionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //inicializamos el array
    
    [self setObjetoSingleton:[Singleton getSharedInstance]];
    [self.objetoSingleton crearArregloConfiguracion];
    
    misDistancias = [[NSArray alloc] initWithObjects: @"200 m", @"400 m",@"600 m",@"800 m", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//metodos del protocolo de delegado

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //Regresa el integer seleccionado
   // NSInteger indice = [self.picker selectedRowInComponent:0]; //porque es la columna 0
    //self.colorLabel.text = misColores[indice];
    distancia = misDistancias[row];
    return [misDistancias objectAtIndex:row];
    
    
}

//metodos protocolo data source


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [misDistancias count];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)guardarDistancia:(id)sender {
    
    // Perfil *miPerfl = [[Perfil alloc] initPerfil:self.nombreTF.text email:self.emailTF.text];
   
    
    [self.objetoSingleton agregarAlArregloConfiguracion:distancia];
    
    
}
@end
