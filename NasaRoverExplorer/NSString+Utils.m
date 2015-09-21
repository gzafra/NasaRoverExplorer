//
//  NSString+ToArrayUtil.m
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (NSArray*)arrayOfChars{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [self length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%C", [self characterAtIndex:i]]];
    }
    return array;
}

- (BOOL)isNumeric:(NSString*)checkText{
    
    NSNumberFormatter* numberFormatter = [NSNumberFormatter new];
    
    NSNumber* number = [numberFormatter numberFromString:checkText];
    
    if (number != nil) {
        return YES;
    }

    return NO;
}

@end
