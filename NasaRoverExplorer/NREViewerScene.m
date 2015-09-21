//
//  NREViewerScene.m
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NREViewerScene.h"
#import "NRERoverSprite.h"

#define kBaseName @"rover"

@interface NREViewerScene()

@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, strong) NSMutableArray *roversOnGrid;

@end

@implementation NREViewerScene

- (instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        _roversOnGrid = [NSMutableArray new];
        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void)restartScene{
    for (SKNode *node in self.children) {
        [node removeAllActions];
        [node removeFromParent];
    }
    
    [self.roversOnGrid removeAllObjects];
}

- (void)update:(NSTimeInterval)currentTime{
    for (NRERoverSprite *rover in self.roversOnGrid) {
        if (rover.hasActions) { // Rover is running, skip
            break;
        }else{
            if (rover.scheduledActions.count) { // Rover still has scheduled orders
                NRERoverAction *actionToTrigger = [rover.scheduledActions firstObject];

                [rover runAction:[SKAction group:@[
                                                   [SKAction moveBy:actionToTrigger.relativeMovement duration:1.0f],
                                                   [SKAction rotateByAngle:actionToTrigger.rotation * M_PI / 180 duration:1.0f]
                                                   ]]];
                
                [rover.scheduledActions removeObject:actionToTrigger];
                break;
            }
        }
    }
}

#pragma mark - NRERoversManagerDelegate

- (void)scannedGridWithSize:(CGVect)size{
    self.cellSize = CGSizeMake(self.size.width / size.x, self.size.height / size.y);
    for (int x = 0; x < size.x; x++) {
        for (int y = 0; y < size.y; y++) {
            SKShapeNode *cell = [SKShapeNode shapeNodeWithRectOfSize:self.cellSize];
            cell.fillColor = [UIColor clearColor];
            cell.strokeColor = [UIColor blackColor];
            
            CGVect vector; vector.x = x; vector.y = y;
            cell.position = [self positionForVector:vector];
            
            [self addChild:cell];
        }
    }
}

- (void)roverWithIndex:(NSUInteger)idx landedAtCoords:(CGVect)vect withDirection:(CGVect)directionVect{
    NRERoverSprite *rover = [[NRERoverSprite alloc] initWithSize:CGSizeMake(self.cellSize.width * 0.4f,
                                                                            self.cellSize.height * 0.4f)
                                                   directionVect:CGVectorMake((CGFloat)directionVect.x, (CGFloat)directionVect.y)];
    rover.position = [self positionForVector:vect];
    rover.name = [NSString stringWithFormat:@"%@%ld",kBaseName,(unsigned long)idx];
    [self addChild:rover];
    [self.roversOnGrid addObject:rover];
}

- (void)roverWithIndex:(NSUInteger)idx movedByCoords:(CGVect)vect{
    id roverObject = [self childNodeWithName:[NSString stringWithFormat:@"%@%ld",kBaseName,(unsigned long)idx]];
    if (roverObject) {
        NRERoverSprite *roverSprite = (NRERoverSprite*)roverObject;
        [roverSprite scheduleMovement:CGVectorMake(vect.x * self.cellSize.width, vect.y * self.cellSize.height)];
    }
}

- (void)roverWithIndex:(NSUInteger)idx rotatedByAngle:(double)angle{
    id roverObject = [self childNodeWithName:[NSString stringWithFormat:@"%@%ld",kBaseName,(unsigned long)idx]];
    if (roverObject) {
        NRERoverSprite *roverSprite = (NRERoverSprite*)roverObject;
        [roverSprite scheduleRotation:(CGFloat)angle];
    }
}

#pragma mark - Utility

- (CGPoint)positionForVector:(CGVect)vector{
    return CGPointMake(vector.x * self.cellSize.width + self.cellSize.width/2,
                       vector.y * self.cellSize.height + self.cellSize.height/2);
}

@end



