//
//  NRERoversManager.m
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NRERoversManager.h"
#import "NSString+Utils.h"
#import "NRERover.h"


#define kNumberOfOrdersPerRover 4

@interface NRERoversManager()

@property (nonatomic, assign) CGVect gridSize;
@property (nonatomic, strong) NSMutableArray *roversOnGrid;

@end

@implementation NRERoversManager

- (instancetype)init{
    if (self = [super init]) {
        self.roversOnGrid = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Parsing of input orders

- (void)inputOrdersCommands:(NSString*)orderCommand{
    NSArray *rawInput = [orderCommand componentsSeparatedByString:@" "];
    [self processOrders:rawInput];
}

- (void)processOrders:(NSArray*)ordersToProcess{
    [self.roversOnGrid removeAllObjects];
    
    NSAssert(ordersToProcess.count >= 5, @"command input missing must at leat have grid size and initial coords and direction");
    
    // Strip first coords (grid size)
    CGVect gridSize;
    gridSize.x = [[ordersToProcess objectAtIndex:0] integerValue] + 1;
    gridSize.y = [[ordersToProcess objectAtIndex:1] integerValue] + 1;
    self.gridSize = gridSize;
    
    [self.delegate scannedGridWithSize:self.gridSize];
    
    NSArray *restOfOrders = [ordersToProcess subarrayWithRange:NSMakeRange(2, ordersToProcess.count-2)];
    
    NSUInteger numberOfRovers = ceil(restOfOrders.count / kNumberOfOrdersPerRover);
    
    for (int roverIdx = 0; roverIdx < numberOfRovers; roverIdx++) {
        // Gets the array of orders for each rover
        NSArray *roverOrders = [restOfOrders subarrayWithRange:NSMakeRange(kNumberOfOrdersPerRover * roverIdx, kNumberOfOrdersPerRover)];
        
        // Get rover's initial coords and direction
        CGVect currentCoords;
        currentCoords.x = [[roverOrders objectAtIndex:0] integerValue];
        currentCoords.y = [[roverOrders objectAtIndex:1] integerValue];
        
        char currentDirection = [[roverOrders objectAtIndex:2] characterAtIndex:0];
        
        NRERover *rover = [[NRERover alloc] initWithIndex:roverIdx initialCoords:currentCoords direction:currentDirection];
        
        // Parse rest of orders
        NSString *movementOrders = [roverOrders objectAtIndex:3];
        rover.movementOrders = [movementOrders arrayOfChars];
        
        [self.roversOnGrid addObject:rover];
        NSLog(@"Rover added on coords X: %ld Y: %ld facing: %c",(long)rover.currentCoords.x, (long)rover.currentCoords.y, rover.directionChar);
        
        [self.delegate roverWithIndex:roverIdx landedAtCoords:rover.currentCoords withDirection:[NRERover vectFromDirection:rover.direction]];
    }
}

#pragma mark - Simulation

- (void)simulateRovers{
    for (NRERover *rover in self.roversOnGrid) {
        for (id orderObj in rover.movementOrders) {
            char orderChar = [orderObj characterAtIndex:0];
            [self inputOrder:orderChar forRover:rover]; // Inputs order in the rover
        }
    }
}

- (void)outputGridState{
    for (NRERover *rover in self.roversOnGrid) {
        NSLog(@"%ld %ld %c",(long)rover.currentCoords.x, (long)rover.currentCoords.y, rover.directionChar);
    }
}

- (void)inputOrder:(char)order forRover:(NRERover*)rover{
    // Check if within limits and not collides when moving
    if (order == 'M') {
        CGVect newCoords = [rover projectedCoordsForMovement];
        
        // Check if within limits
        if ((newCoords.x >= self.gridSize.x || newCoords.x < 0) ||
            (newCoords.y >= self.gridSize.y || newCoords.y < 0)){
            NSLog(@"Rover reached limit on X:%ld Y:%ld",(long)newCoords.x, (long)newCoords.y);
                return;
        }
        
        // Check if collides with another rover
        for (NRERover *otherRover in self.roversOnGrid) {
            if (rover != otherRover) {
                if (newCoords.x == otherRover.currentCoords.x &&
                    newCoords.y == otherRover.currentCoords.y) {
                    NSLog(@"Rover collided with another rover on X:%ld Y:%ld",(long)newCoords.x, (long)newCoords.y);
                    return;
                }
            }
        }
        
        // Calculate relative movement and notify delegate
        CGVect relativeCoords; relativeCoords.x = newCoords.x - rover.currentCoords.x; relativeCoords.y = newCoords.y - rover.currentCoords.y;
        [self.delegate roverWithIndex:rover.roverIndex movedByCoords:relativeCoords];
    }else{
        // Notify delegate abour rotation
        if (order == 'R') {
            [self.delegate roverWithIndex:rover.roverIndex rotatedByAngle:-90.0];
        }else{
            [self.delegate roverWithIndex:rover.roverIndex rotatedByAngle:90.0];
        }
    }
    
    // Actually update state on the rover
    [rover inputOrder:order];
}

@end
