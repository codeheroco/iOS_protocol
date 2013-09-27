//
//  FileDataAccessDelegate.h
//  Protocol
//
//  Created by Ricardo Sampayo on 26/09/13.
//  Copyright (c) 2013 CodeHero. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileDataAccessDelegate <NSObject>

@optional
-(void)dowloadFinishLoading:(NSString *)filePath andName:(NSString *)name;
-(void)dowloadDidFinishLoading:(NSString *)name;
-(void)dowloadFinishLoading:(NSURLConnection *)connection didFailWithError:(NSError *)error andName:(NSString *)name;
- (void)dowloadChangeLoading:(NSURLConnection *)connection didReceiveData:(NSData *)data andProgress:(float)progress;
- (void)dowloadInitLoading:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

@end

