//
//  NRERover.m
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NRERover.h"

@implementation NRERover

- (instancetype)initWithIndex:(NSUInteger)roverIndex initialCoords:(CGVect)initialCords direction:(char)direction{
    if (self = [super init]) {
        _roverIndex = roverIndex;
        _currentCoords = initialCords;
        _direction = [[self class] directionTypeFromChar:direction];
    }
    return self;
}

- (void)inputOrder:(char)order{
    switch (order) {
        case 'M': // Move
            self.currentCoords = [self projectedCoordsForMovement];
            break;
        case 'L': // Turn anti-clockwise
            self.direction = (self.direction + 3) % 4;
            break;
        case 'R': // Turn clockwise
            self.direction = (self.direction + 1) % 4;
            break;
        default:
            break;
    }
    NSLog(@"Rover moved to X:%ld Y:%ld facing: %c",(long)self.currentCoords.x, (long)self.currentCoords.y,self.directionChar);
}

- (CGVect)projectedCoordsForMovement{
    CGVect addCoords = [[self class] vectFromDirection:self.direction];
    CGVect newCoords = self.currentCoords;
    newCoords.x += addCoords.x;
    newCoords.y += addCoords.y;
    return newCoords;
}

- (char)directionChar{
    NSArray *directions = @[@"N",@"E",@"S",@"W"];
    return [[directions objectAtIndex:self.direction] characterAtIndex:0];
}

#pragma mark - Utility

+ (NRERoverDirectionType)directionTypeFromChar:(char)directionChar{
    NRERoverDirectionType directionType;
    switch (directionChar) {
        case 'N':
            directionType = NRERoverDirectionNorth;
            break;
        case 'S':
            directionType = NRERoverDirectionSouth;
            break;
        case 'E':
            directionType = NRERoverDirectionEast;
            break;
        case 'W':
            directionType = NRERoverDirectionWest;
            break;
        default:
            [NSException raise:@"Unknown direction char" format:@"%c is not a valid direction",directionChar];
            break;
    }
    return directionType;
}

+ (CGVect)vectFromDirection:(NRERoverDirectionType)direction{
    CGVect vector; vector.x = 0; vector.y = 0;
    switch (direction) {
        case NRERoverDirectionNorth:
            vector.y = 1;
            break;
        case NRERoverDirectionSouth:
            vector.y = -1;
            break;
        case NRERoverDirectionEast:
            vector.x = 1;
            break;
        case NRERoverDirectionWest:
            vector.x = -1;
            break;
        default:
            break;
    }
    return vector;
}

@end
