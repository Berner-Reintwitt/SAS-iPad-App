//
//  ObjPicture+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 24.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "StringConsts.h"
#import "ObjPicture+Extensions.h"
#import "ScaledImage+Extensions.h"
#import "AbstractParser.h"
#import "ImageData.h"

@implementation ObjPicture (Extensions)

- (UIImage *) GetScaledImage:(int)width withHeight:(int)height withMode:(ScaleModes)mode {
    ScaledImage *original = [self.images anyObject]; // im moment ist nur das eine original vorhanden
    UIImage *img = [original getImage];
    CGImageRef cgref = CreateScaledCGImageFromCGImageWithMode(img.CGImage, width, height, mode);
    UIImage *scaled = [UIImage imageWithCGImage:cgref];
    return scaled;
}

+ (ObjPicture *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {
    ObjPicture *result = nil;
    NSString *exid = nil, *big_url = nil, *url = nil, *thumb_url = nil, *timestamp = nil, *title = nil, *type = nil, *md5 = nil;
    for (NSDictionary *d in nodes) {
        NSString *nodeName = [d objectForKey:XML_NodeName];
        NSString *nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_exid] == NSOrderedSame) exid = nodeContent;
        else if ([nodeName compare:NAME_big_url] == NSOrderedSame) big_url = nodeContent;
        else if ([nodeName compare:NAME_url] == NSOrderedSame) url = nodeContent;
        else if ([nodeName compare:NAME_thumb_url] == NSOrderedSame) thumb_url = nodeContent;
        else if ([nodeName compare:NAME_timestamp] == NSOrderedSame) timestamp = nodeContent;
        else if ([nodeName compare:NAME_title] == NSOrderedSame) title = nodeContent;
        else if ([nodeName compare:NAME_type] == NSOrderedSame) type = nodeContent;
        else if ([nodeName compare:Name_md5] == NSOrderedSame) md5 = nodeContent;
        else NSLog(@"unknown tag %s", [nodeContent UTF8String]);
    }
    if (!(nil != exid && nil != big_url && nil != url && nil != thumb_url && nil != timestamp && nil != type && nil != title && nil != md5)) {
        NSLog(@"Picture import: missing tag");
        return nil;
    }
    
    
    
    NSString *picUrl = big_url;
    if (!containsPattern(picUrl, @"http://")) picUrl = url;
    if (!containsPattern(picUrl, @"http://")) picUrl = thumb_url;
    if (!containsPattern(picUrl, @"http://")) {
        NSLog(@"no url for picture");
        return nil;
    }
    
    //data = readData(DATASOURCE_URL, ACTION_import, NAME_name, @"imagedata", PICTURE_url, EndcodeBase16(url), PICTURE_mode, PICTURE_MODE_original, nil);
    
    NSString *esqUrl = [picUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *url_query = [NSURL URLWithString: esqUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL: url_query];
    NSError *error = nil;
    NSURLResponse *response;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        logError(error);
        if (nil == data) {
            NSLog(@"can't read image data at '%s'", [url UTF8String]);
            return nil;
        }
    }
    
    const Byte *data_bytes = [data bytes];
    if (data_bytes[0] == '<') {
        NSLog(@"picture missing (%s)", [esqUrl UTF8String]);
        return nil;
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
    
    
    result = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPicture inManagedObjectContext:context];
    result.big_url = big_url;
    result.timestamp = [AbstractParser parseDate:timestamp];
    result.url = url;
    result.thumb_url = thumb_url;
    result.title = title;
    result.type = type;
    result.md5hash = DecodeAP16(md5);
    [result addImagesObject:image];
    return result;

}


@end
