//
//  Helper.h
//  Dominoes
//
//  Created by Ben Tesch on 12/23/11.
//  Copyright (c) 2011 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject {}

+(NSString *)getUserValueForKey:(NSString*)aKey withDefault:(NSString*)aDefaultValue;
+(void)setUserValue:(NSString*)aValue forKey:(NSString*)aKey;

@end
