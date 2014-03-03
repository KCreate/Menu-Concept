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
    menuView *mainMenuView = [[menuView alloc] initWithDefaultsWithDevice:@"iPhone4"];
    mainMenuView.delegate = self;
    [mainMenuView setCloseDuration:0.4];
    [mainMenuView setOpenDuration:0.4];
    [self.view addSubview:mainMenuView];
}

-(void)menuViewNewIndex:(long int)currentIndex {
    switch (currentIndex) {
        case 0:
            //index 0
            [self.view setBackgroundColor:[UIColor greenColor]];
            NSLog(@"bratwurst");
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
