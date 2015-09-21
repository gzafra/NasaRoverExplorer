//
//  NRERoversManagerDelegate.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRETypes.h"

@protocol NRERoversManagerDelegate <NSObject>

- (void)scannedGridWithSize:(CGVect)size;
- (void)roverWithIndex:(NSUInteger)idx landedAtCoords:(CGVect)vect withDirection:(CGVect)directionVect;
- (void)roverWithIndex:(NSUInteger)idx movedByCoords:(CGVect)vect;
- (void)roverWithIndex:(NSUInteger)idx rotatedByAngle:(double)angle;

@end
