//
//  ViewController.h
//  Protocol
//
//  Created by Ricardo Sampayo on 26/09/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileDataAccess.h"

@interface ViewController : UIViewController<FileDataAccessDelegate>
@property (weak, nonatomic) IBOutlet UILabel *progreso;

-(IBAction)descargar:(id)sender;
@end
