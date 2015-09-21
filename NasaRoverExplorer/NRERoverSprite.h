//
//  NRERoverSprite.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NRERoverSprite : SKSpriteNode

- (instancetype)initWithSize:(CGSize)size directionVect:(CGVector)directionVect;

/// Schedules a movement with relative position on the rover sprite
- (void)scheduleMovement:(CGVector)movementVector;
- (void)scheduleRotation:(CGFloat)rotation;

@property (nonatomic, strong) NSMutableArray *scheduledActions;

@end

@interface NRERoverAction : NSObject

- (instancetype)initWithRelativeMovement:(CGVector)movementVector;
- (instancetype)initWithRotation:(CGFloat)rotation;

@property (nonatomic, assign) CGVector relativeMovement;
@property (nonatomic, assign) CGFloat rotation;

@end