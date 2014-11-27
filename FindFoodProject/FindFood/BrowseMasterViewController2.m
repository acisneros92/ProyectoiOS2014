//
//  BrowseMasterViewController2.m
//  FindFood
//
//  Created by alumno on 13/11/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import "BrowseMasterViewController2.h"
#import "BrowseDetailViewController.h"
#import "Celda.h"

@interface BrowseMasterViewController2 (){
    NSMutableArray *_objects;
    NSMutableArray *restaurantes;
    NSDictionary *restaurante;
}

@end

@implementation BrowseMasterViewController2

- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loading.frame = CGRectMake(0,0,40,40); //Tamaño del indicador
    self.loading.center = self.view.center;
    [self.view addSubview:self.loading]; //Indicador se agrega a la vista principal
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    
    //Formar el URL
    NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/explore?client_id=0ZDHG1EQAYRFNSEMFWIP1BDLWIMET21K3J5ZBEB5IAKCZRTZ&client_secret=G0Z3L1Q3PFBJL2KRQ0FQHGC2G05JSPOTGNSGVDNJM20F3T0Y&v=20130815&ll=25.6500973,-100.2888395&radius=200&section=food"];
    
    //NSString *url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?client_id=0ZDHG1EQAYRFNSEMFWIP1BDLWIMET21K3J5ZBEB5IAKCZRTZ&client_secret=G0Z3L1Q3PFBJL2KRQ0FQHGC2G05JSPOTGNSGVDNJM20F3T0Y&v=20130815&ll=%f,%f&radius=200&section=food", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    
    
    //Realizar request al URL
    NSURL *miUrl = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:miUrl
                                                  cachePolicy:
                             NSURLRequestReloadIgnoringCacheData
                                              timeoutInterval:60];
    
    //Iniciar la conexion al servidor
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    //Preparar variable que recibe cualquier tipo de dato del servidor.
    
    self.responseData =[[NSMutableData alloc] init ];
    [self.loading startAnimating];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 25.6500973;
    zoomLocation.longitude = -100.2888395;

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    // 3
    [_browseMap setRegion:viewRegion animated:YES];
    
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.browseMap setRegion:[self.browseMap regionThatFits:region] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//IMPLEMENTACION DEL PROTOCOLOS
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    //Espera la respuesta del servidor
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    int statusCode = [httpResponse statusCode];
    NSLog(@"ESTATUS DE CONEXION %i", statusCode);
    
    //inicializa en 0 bytes responseData
    [self.responseData setLength:0];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    //Cada vez que recibe datos del servidor lo concatena con los datos anteriores para así formar el paquete final de datos.
    
    //Acumula la respuesta del servidor
    [self.responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //Este metodo se invoca al terminar de recibir los datos del servidor.
    //Recibir datos json y parsearlos a un objeto de acuerdo a a la estructura de los datos.
    
    NSError *error;
    
    // Json recibido como arreglo
    NSDictionary *datos= [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    NSDictionary *response = [datos objectForKey:@"response"] ;
    restaurantes = [[[response objectForKey:@"groups"] objectAtIndex:0] objectForKey:@"items"];
    //    restaurante= [[[[[response objectForKey:@"groups"] objectAtIndex:0] objectForKey:@"items"] objectAtIndex:0] objectForKey:@"venue"];
    
    NSLog(@"count %i",restaurantes.count);
    //Identificar si existen elementos o no como respuesta del servidor
    if (restaurantes.count == 0) {
        
        //Crea un alerta como mensade de la conexión
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No existen restaurantes" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alerta show];
    }else{
        
        //Se redibuja la tabla ya que los datos de las celdas fueron actualizados
        [self.table reloadData];
        
    }
    
    [self.loading stopAnimating];
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    //Cuando existe un error en la conexion
    //Crea un alerta como mensade de la conexión
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error en la conexion" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerta show];
    
    [self.loading stopAnimating];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [restaurantes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Celda *cell = (Celda*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = restaurantes[indexPath.row];
    cell.titulo.text = [[object objectForKey:@"venue"] objectForKey:@"name"];
    //cell.subtitulo.text = [[[object objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"city"];
    
    NSString *str = [NSString stringWithFormat:@"%@ m",[[[object objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"distance"]];
    cell.subtitulo.text = str;
    
    return cell;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        NSDictionary *object = restaurantes[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (IBAction)refresh:(id)sender {
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    
    //Formar el URL
    //NSString *url = [[NSString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/explore?client_id=0ZDHG1EQAYRFNSEMFWIP1BDLWIMET21K3J5ZBEB5IAKCZRTZ&client_secret=G0Z3L1Q3PFBJL2KRQ0FQHGC2G05JSPOTGNSGVDNJM20F3T0Y&v=20130815&ll=25.6500973,-100.2888395&radius=200&section=food"];
    
    NSString *url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?client_id=0ZDHG1EQAYRFNSEMFWIP1BDLWIMET21K3J5ZBEB5IAKCZRTZ&client_secret=G0Z3L1Q3PFBJL2KRQ0FQHGC2G05JSPOTGNSGVDNJM20F3T0Y&v=20130815&ll=%f,%f&radius=200&section=food", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    
    
    //Realizar request al URL
    NSURL *miUrl = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:miUrl
                                                  cachePolicy:
                             NSURLRequestReloadIgnoringCacheData
                                              timeoutInterval:60];
    
    //Iniciar la conexion al servidor
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    //Preparar variable que recibe cualquier tipo de dato del servidor.
    
    self.responseData =[[NSMutableData alloc] init ];
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.locationManager.location.coordinate.latitude;
    zoomLocation.longitude = self.locationManager.location.coordinate.longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    // 3
    [_browseMap setRegion:viewRegion animated:YES];
    
}
@end
