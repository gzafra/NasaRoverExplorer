//
//  NRERoverSprite.m
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "NRERoverSprite.h"

#define kSpeed 60.0f

@interface NRERoverSprite()

@end

@implementation NRERoverSprite

- (instancetype)initWithSize:(CGSize)size directionVect:(CGVector)directionVect{
    if (self = [super initWithColor:[UIColor yellowColor] size:size]) {
        _scheduledActions = [NSMutableArray new];
        
        SKSpriteNode *head = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(self.size.width * 0.8f, self.size.height * 0.8f)];
        head.position = CGPointMake(self.size.width/2 * directionVect.dx, self.size.height/2 * directionVect.dy);
        [self addChild:head];
    }
    return self;
}

- (void)scheduleMovement:(CGVector)movementVector{
    NRERoverAction *action = [[NRERoverAction alloc] initWithRelativeMovement:movementVector];
    [self.scheduledActions addObject:action];
}

- (void)scheduleRotation:(CGFloat)rotation{
    NRERoverAction *action = [[NRERoverAction alloc] initWithRotation:rotation];
    [self.scheduledActions addObject:action];
}

@end

@implementation NRERoverAction

- (instancetype)initWithRelativeMovement:(CGVector)movementVector{
    if (self = [super init]) {
        _relativeMovement = movementVector;
        _rotation = 0.0;
    }
    return self;
}

- (instancetype)initWithRotation:(CGFloat)rotation{
    if (self = [super init]) {
        _relativeMovement = CGVectorMake(0.0f, 0.0f);
        _rotation = rotation;
    }
    return self;
}

@end
