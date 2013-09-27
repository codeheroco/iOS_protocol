//
//  ViewController.m
//  Protocol
//
//  Created by Ricardo Sampayo on 26/09/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import "ViewController.h"




@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma button
-(IBAction)descargar:(id)sender{
    FileDataAccess *file = [[FileDataAccess alloc] init];
    [FileDataAccess removeFileBookWhitName:@"imagen.png"];
    [file descargarArchivo:@"http://codehero.co/oc-content/uploads/2013/08/Screen-Shot-2013-08-12-at-1.04.36-AM.png" nombre:@"imagen.png"];
    file.delegate=self;
}

#pragma mark Delegete File
-(void)dowloadFinishLoading:(NSString *)filePath andName:(NSString *)name{
    NSLog(@"termina de descargar y guardar con exito");
     _progreso.text = @"listo! Cambiemos la ruta y empezemos de nuevo";
}
-(void)dowloadDidFinishLoading:(NSString *)name{
    NSLog(@"termina de descargar");
}
-(void)dowloadFinishLoading:(NSURLConnection *)connection didFailWithError:(NSError *)error andName:(NSString *)name{
    NSLog(@"Error");
}
- (void)dowloadChangeLoading:(NSURLConnection *)connection didReceiveData:(NSData *)data andProgress:(float)progress{
    _progreso.text = [NSString stringWithFormat:@"%.2f%%",progress*100];
}
- (void)dowloadInitLoading:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _progreso.text = @"0%%";
    NSLog(@"inicia de descargar");
}
@end
