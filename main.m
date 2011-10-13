//
//  main.m
//  TabBarWithSplitView
//

//

#import <UIKit/UIKit.h>
#import "Classes/CoreData/Queries.h"
#import "Classes/CoreData/Utils.h"

int main(int argc, char *argv[]) {
    
    [Queries initialImport:managedObjectContext()];
    NSError *error;
    error=nil;
    if([managedObjectContext()save:&error]){
        NSLog(@"Achtung Error");
        
    }
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}

