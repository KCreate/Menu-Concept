//
//  ViewController.m
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#define viewWidht_half (self.view.bounds.size.width / 2)
#define viewHeight_half (self.view.bounds.size.height / 2)

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuView *mainMenuView = [[menuView alloc] initWithCenter:CGPointMake(viewWidht_half, 450)];
    mainMenuView.delegate = self; //Important if you want to use delegate methods like updateCurrentIndex:
    [self.view addSubview:mainMenuView];

}

-(void)MVDcurrentIndexWasUpdated:(long int)currentIndex {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    switch (currentIndex) {
        case 0:
            //index 0
            [self.view setBackgroundColor:[UIColor greenColor]];
            break;
        case 1:
            //index 1
            [self.view setBackgroundColor:[UIColor orangeColor]];
            break;
        case 2:
            //index 2
            [self.view setBackgroundColor:[UIColor yellowColor]];
            break;
        default:
            break;
    }
    
    [UIView commitAnimations];
}

@end
