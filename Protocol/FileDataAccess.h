//
//  FileDataAccess.h
//  Protocol
//
//  Created by Ricardo Sampayo on 26/09/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileDataAccessDelegate.h"

@interface FileDataAccess : NSObject

@property (nonatomic,strong) id<FileDataAccessDelegate>delegate;

-(void)descargarArchivo:(NSString *)url nombre:(NSString *)nombre;
+(NSString *)removeFileBookWhitName:(NSString *)name;


@end
