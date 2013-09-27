//
//  FileDataAccess.m
//  Protocol
//
//  Created by Ricardo Sampayo on 26/09/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import "FileDataAccess.h"
@interface FileDataAccess()<NSURLConnectionDataDelegate>

@property (nonatomic,assign) long expectedLength;
@property (nonatomic,strong) NSMutableData *fileData;
@property (nonatomic,strong) NSString *fileName;


@end

@implementation FileDataAccess

static float progress = 0.0f;

#pragma mark
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.expectedLength = [response expectedContentLength];
    
    
	progress = 0;
    
    if ([self.delegate respondsToSelector:@selector(dowloadInitLoading:didReceiveResponse:)]) {
        [self.delegate dowloadInitLoading:connection didReceiveResponse:response];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	progress += [data length];
    
    [_fileData appendData:data];
    
    
    if ([self.delegate respondsToSelector:@selector(dowloadChangeLoading:didReceiveData:andProgress:)]) {
        [self.delegate dowloadChangeLoading:connection didReceiveData:data andProgress:(progress / (float)_expectedLength)];
    }
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    
    if ([self.delegate respondsToSelector:@selector(dowloadDidFinishLoading:)]) {
        [_delegate dowloadDidFinishLoading:_fileName];
    }
    
    [self saveDocuments:_fileData andName:_fileName];
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if ([self.delegate respondsToSelector:@selector(dowloadFinishLoading:didFailWithError:andName:)]) {
        [_delegate dowloadFinishLoading:connection didFailWithError:error andName:_fileName];
    }
}


-(void)saveDocuments:(NSData *)imageData andName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *patientPhotoFolder = [[paths lastObject] stringByAppendingPathComponent:@"/file"];
    
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager fileExistsAtPath:patientPhotoFolder
                           isDirectory:&isDir] && isDir == NO) {
        [fileManager createDirectoryAtPath:patientPhotoFolder
               withIntermediateDirectories:NO
                                attributes:nil
                                     error:nil];
    }
    
    
    NSString *filePath = [patientPhotoFolder stringByAppendingPathComponent:name];
    NSError *writeError = nil;
    [imageData writeToFile:filePath options:NSDataWritingAtomic error:&writeError];
    
    
    if ([self.delegate respondsToSelector:@selector(dowloadFinishLoading:didFailWithError:andName:)]) {
        [_delegate dowloadFinishLoading:filePath andName:_fileName];
    }
    
    if (writeError) {
        NSLog(@"Error writing file: %@", writeError);
        if ([self.delegate respondsToSelector:@selector(dowloadFinishLoading:didFailWithError:andName:)]) {
            [_delegate dowloadFinishLoading:nil didFailWithError:writeError andName:_fileName];
        }
    }
}
#pragma mark
-(void)descargarArchivo:(NSString *)url nombre:(NSString *)nombre
{
    _fileName = nombre;
    _fileData = [[NSMutableData alloc] init];
    NSURL *urlData = [NSURL URLWithString:url];
	NSURLRequest *request = [NSURLRequest requestWithURL:urlData];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

+(NSString *)removeFileBookWhitName:(NSString *)name
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSString* sharingPath = [basePath stringByAppendingString:@"/file"];
//    sharingPath = [sharingPath stringByAppendingString:@"/"];
//    sharingPath = [sharingPath stringByAppendingString:name];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error=nil;
    [fm removeItemAtPath:sharingPath error:&error];
    
    if (error) {
        NSLog(@"error borrando el archivo : %@",error);
    }
    
    NSLog(@"Removed directory %@", sharingPath);
    
    return nil;
}


@end

