//
//  NRERoversManager.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRERoversManagerDelegate.h"

@interface NRERoversManager : NSObject

@property (nonatomic, weak) id<NRERoversManagerDelegate> delegate;

/// Inputs raw string of commands into the manager
- (void)inputOrdersCommands:(NSString*)orderCommand;

/// Executes the simulation of rovers orders in the manager
- (void)simulateRovers;

/// Output the resulting coords and direction of each rover
- (void)outputGridState;

@end
