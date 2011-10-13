//
//  ObjPicturesParser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 07.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjPictureParser.h"
#import "ObjInfo2.h"
#import "ObjPicture.h"
#import "ScaledImage.h"
#import "StringConsts.h"
#import "Utils.h"
#import "Queries.h"
#import <ImageIO/ImageIO.h>

@implementation ObjPictureParser

- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {

    if ([CLASS_ObjPicture compare:elementName] == NSOrderedSame) {
        ObjPicture *picture = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPicture inManagedObjectContext:context];
        picture.title = [mDict objectForKey:NAME_title];
        picture.timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
        picture.type = [mDict objectForKey:NAME_type];
        picture.url = [mDict objectForKey:NAME_url];
        picture.thumb_url = [mDict objectForKey:NAME_thumb_url];
        picture.big_url = [mDict objectForKey:NAME_big_url];
        picture.images = [NSSet set];
        
        NSString *url = picture.big_url;
        if (nil == url || url.length == 0) url = picture.url;
        if (nil == url || url.length == 0) url = picture.thumb_url;
        
        if (nil != url && url.length > 0) {
/*
            ScaledImage *image = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ScaledImage inManagedObjectContext:context];
            image.data = readData(DATASOURCE_URL, ACTION_picture, PICTURE_url, EndcodeBase16(url), PICTURE_mode, PICTURE_MODE_original, nil);

            
            CFDataRef dataRef = (CFDataRef) image.data;
            
            CGDataProviderRef dataProviderRef = CGDataProviderCreateWithCFData(dataRef);

            CFDictionaryRef dictionaryRef = NULL;

            CGImageSourceRef imgSourceRef = CGImageSourceCreateWithData(dataRef, dictionaryRef);
            
            
            CGImageRef imgRef = CGImageCreateWithJPEGDataProvider(dataProviderRef, NULL, true, kCGRenderingIntentDefault);
           
            
            
            
//            image.width = [NSNumber numberWithInt:(int) ([img size].width)];  
//            image.height = [NSNumber numberWithInt:(int) ([img size].height)];
            image.mode = @"original";
            image.quality = [NSNumber numberWithInt: 100]; // TODO: echten Wert feststellen
            image.timestamp = [NSDate date];
            [picture addImagesObject:image];
//            [img release];
*/
        }
        
        NSString *exid = [mDict objectForKey:NAME_exid];
        ObjInfo2 *a = [Queries getApartment:exid context:context];
        [a addPicturesObject:picture];
    }

}


@end
