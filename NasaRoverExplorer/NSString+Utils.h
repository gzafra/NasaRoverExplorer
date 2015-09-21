//
//  NSString+ToArrayUtil.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSArray*)arrayOfChars;
- (BOOL)isNumeric:(NSString*)checkText;

@end
