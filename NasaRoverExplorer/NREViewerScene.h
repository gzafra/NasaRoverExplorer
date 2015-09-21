//
//  NREViewerScene.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/15.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NRERoversManagerDelegate.h"

@interface NREViewerScene : SKScene <NRERoversManagerDelegate>

- (void)restartScene;

@end
