//
//  ViewController.m
//  NasaRoverExplorer
//
//  Created by Guillermo Zafra on 08/07/2015.
//  Copyright (c) 2015 Guillermo Zafra. All rights reserved.
//

#import "ViewController.h"
#import "NRERoversManager.h"
#import "NREViewerScene.h"

@interface ViewController ()

@property (nonatomic, strong) NRERoversManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *testString = @"5 5 1 2 N LMLMLMLMM 3 3 E MMRMMRMRRM"; //
    
    self.inputTxt.text = testString;
    
    SKView * skView = self.skView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    NREViewerScene *viewer = [NREViewerScene sceneWithSize:CGSizeMake(300,300)];
    
    [skView presentScene:viewer];

    self.manager = [NRERoversManager new];
    self.manager.delegate = viewer;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)runButtonTouched:(id)sender{
    if ([self.skView.scene respondsToSelector:@selector(restartScene)]) {
        [self.skView.scene performSelector:@selector(restartScene)];
    }
    
    [self.manager inputOrdersCommands:self.inputTxt.text];
    [self.manager simulateRovers];
    [self.manager outputGridState];
}

@end
