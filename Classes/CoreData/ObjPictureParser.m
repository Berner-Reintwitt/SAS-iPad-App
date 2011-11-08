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
#import "ImageData.h"
#import "Utils.h"
#import "Queries.h"


BOOL containsPattern(NSString *source, NSString *pattern) {
	return
		nil != source &&
		nil != pattern &&
		NSNotFound != [source rangeOfString:pattern options:NSCaseInsensitiveSearch | NSLiteralSearch].location;
}

@implementation ObjPictureParser

- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {

    if ([CLASS_ObjPicture compare:elementName] == NSOrderedSame) {

		NSString *exid = [mDict objectForKey:NAME_exid];
		ObjInfo2 *a = [Queries getApartment:context withExID:exid];
		if (nil == a) {
			NSLog(@"missing exid(%s) --> drop picture", [exid UTF8String]);
			return;
		}

		NSString *normal_url = [mDict objectForKey:NAME_url];
        NSString *thumb_url = [mDict objectForKey:NAME_thumb_url];
        NSString *big_url = [mDict objectForKey:NAME_big_url];
		NSString *url = big_url;
        if (!containsPattern(url, @"http://")) url = normal_url;
        if (!containsPattern(url, @"http://")) url = thumb_url;
        if (!containsPattern(url, @"http://")) {
			NSLog(@"no url for picture");
			return;
		}

		//data = readData(DATASOURCE_URL, ACTION_import, NAME_name, @"imagedata", PICTURE_url, EndcodeBase16(url), PICTURE_mode, PICTURE_MODE_original, nil);
		
		NSString *esqUrl = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		
		NSURL *url_query = [NSURL URLWithString: esqUrl];
		NSURLRequest *request = [NSURLRequest requestWithURL: url_query];
		NSError *error = nil;
		NSURLResponse *response;

		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		if (error) {
			logError(error);
			if (nil == data) {
				NSLog(@"can't read image data at '%s'", [url UTF8String]);
				return;
			}
		}

		ScaledImage *image = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ScaledImage inManagedObjectContext:context];
		image.imageData = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ImageData inManagedObjectContext:context];
		image.imageData.data = data;
		image.imageData.parent = image;
		UIImage *ui = [UIImage imageWithData:data];
		CGSize size = ui.size;
		image.width = [NSNumber numberWithFloat: size.width];  
		image.height = [NSNumber numberWithFloat: size.height];
		image.mode = @"original";
		image.quality = [NSNumber numberWithInt: 100]; // TODO: echten Wert feststellen
		image.timestamp = [NSDate date];
		//[ui release];

		ObjPicture *picture = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPicture inManagedObjectContext:context];
			
		picture.title = [mDict objectForKey:NAME_title];
		NSDate *timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
		if (nil == timestamp) {
			NSLog(@"no timestamp %s", [exid UTF8String]);
		}
		picture.timestamp = timestamp;
		picture.type = [mDict objectForKey:NAME_type];
		picture.url = normal_url;
		picture.thumb_url = thumb_url;
		picture.big_url = big_url;
		picture.md5hash = [AbstractParser parseBase16:[mDict objectForKey:Name_md5]];
		picture.images = [NSSet set];
		picture.serial = [NSNumber numberWithInt:++serial];
		[picture addImagesObject:image];
		[a addPicturesObject:picture];
    }

}


@end
