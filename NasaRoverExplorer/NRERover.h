//
//  NRERover.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRETypes.h"

// Order must be clock-wise
typedef enum : NSUInteger {
    NRERoverDirectionNorth,
    NRERoverDirectionEast,
    NRERoverDirectionSouth,
    NRERoverDirectionWest
} NRERoverDirectionType;

@interface NRERover : NSObject

@property (nonatomic, assign) CGVect currentCoords;
@property (nonatomic, strong) NSArray *movementOrders;
@property (nonatomic, assign) NRERoverDirectionType direction;
@property (nonatomic, readonly) char directionChar;
@property (nonatomic, assign) NSUInteger roverIndex;

- (instancetype)initWithIndex:(NSUInteger)roverIndex initialCoords:(CGVect)initialCords direction:(char)direction;

/// Inputs an order into the rover. Modifies the logic state
- (void)inputOrder:(char)order;

/// Returns the new vector the rover will be after a movement based on its current direction
- (CGVect)projectedCoordsForMovement;

+ (CGVect)vectFromDirection:(NRERoverDirectionType)direction;

@end
