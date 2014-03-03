//
//  ViewController.m
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#import "ViewController.h"
#import "menuView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuView *mainMenuView = [[menuView alloc] initWithDefaults];
    mainMenuView.delegate = self;
    [mainMenuView setCloseDuration:4];
    [mainMenuView setOpenDuration:2];
    
    [self.view addSubview:mainMenuView];
    
    [mainMenuView setImageForButton1:[UIImage imageNamed:@"ZH-Logo-Red.png"] forState:UIControlStateNormal];
    [mainMenuView setImageForButton1:[UIImage imageNamed:@"ZH-Logo-Blue.png"] forState:UIControlStateHighlighted];
}

-(void)menuViewNewIndex:(long int)currentIndex {
    switch (currentIndex) {
        case 0:
            //index 0
            [self.view setBackgroundColor:[UIColor greenColor]];
            break;
        case 1:
            //index 1
            [self.view setBackgroundColor:[UIColor redColor]];
            break;
        case 2:
            //index 2
            [self.view setBackgroundColor:[UIColor yellowColor]];
            break;
        default:
            break;
    }
}

@end
