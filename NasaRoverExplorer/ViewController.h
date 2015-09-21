//
//  ViewController.h
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *inputTxt;
@property (nonatomic, weak) IBOutlet UIButton *inputButton;
@property (nonatomic, weak) IBOutlet SKView *skView;

@end

