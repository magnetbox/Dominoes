//
//  Helper.m
//  Dominoes
//
//  Created by Ben Tesch on 12/23/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+(NSString *)getUserValueForKey:(NSString*)aKey withDefault:(NSString*)aDefaultValue
{
    NSString *result = [[NSUserDefaults standardUserDefaults] stringForKey:aKey];
    if(result == nil || [result isEqualToString:@""]){
        return aDefaultValue;
    }
    return result;
}

+(void)setUserValue:(NSString*)aValue forKey:(NSString*)aKey
{
    [[NSUserDefaults standardUserDefaults] setObject:aValue forKey:aKey];
}

@end
