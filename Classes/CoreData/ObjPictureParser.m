//
//  ObjPicturesParser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 07.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <ImageIO/ImageIO.h>
#import "ObjPictureParser.h"
#import "ObjInfo2.h"
#import "ObjPicture.h"
#import "ScaledImage.h"
#import "StringConsts.h"
#import "Utils.h"
#import "Queries.h"

@implementation ObjPictureParser

- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {

    if ([CLASS_ObjPicture compare:elementName] == NSOrderedSame) {
        
        NSString *exid = [mDict objectForKey:NAME_exid];
        //if ([exid compare:@"1/04"] != NSOrderedSame) return;
        
        ObjPicture *picture = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPicture inManagedObjectContext:context];
        picture.title = [mDict objectForKey:NAME_title];
        NSDate *timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
        if (nil == timestamp) {
            NSLog(@"no timestamp %s", [exid UTF8String]);
        }
        picture.timestamp = timestamp;
        picture.type = [mDict objectForKey:NAME_type];
        picture.url = [mDict objectForKey:NAME_url];
        picture.thumb_url = [mDict objectForKey:NAME_thumb_url];
        picture.big_url = [mDict objectForKey:NAME_big_url];
		picture.md5hash = [AbstractParser parseBase16:[mDict objectForKey:Name_md5]];
        picture.images = [NSSet set];
		picture.serial = [NSNumber numberWithInt:++serial];
        NSString *url = picture.big_url;
        if (nil == url || url.length == 0) url = picture.url;
        if (nil == url || url.length == 0) url = picture.thumb_url;
        if (nil != url && url.length > 0) {
            ScaledImage *image = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ScaledImage inManagedObjectContext:context];
            image.data = readData(DATASOURCE_URL, ACTION_picture, PICTURE_url, EndcodeBase16(url), PICTURE_mode, PICTURE_MODE_original, nil);
            UIImage *ui = [UIImage imageWithData:image.data];
            CGSize size = ui.size;
            image.width = [NSNumber numberWithFloat: size.width];  
            image.height = [NSNumber numberWithFloat: size.height];
            image.mode = @"original";
            image.quality = [NSNumber numberWithInt: 100]; // TODO: echten Wert feststellen
            image.timestamp = [NSDate date];
            [picture addImagesObject:image];
            //[ui release];
        }
        
        ObjInfo2 *a = [Queries getApartment:context withExID:exid];
        if (nil != a) {
            [a addPicturesObject:picture];
        }
		else{
			
			NSLog(@"missing xid(%s)",[exid UTF8String]);
		}
    }

}


@end
