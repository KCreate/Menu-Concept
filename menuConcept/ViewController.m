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
#import "menuView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainMenuView = [[menuView alloc] initWithCenter:CGPointMake(viewWidht_half, viewHeight_half + 150)];
    mainMenuView.delegate = self; //Important if you want to use delegate methods like MVDcurrentIndexWasUpdated:
    [self.view addSubview:mainMenuView];
    [mainMenuView setDrawButtonBorder:NO];
    [self.view.layer setCornerRadius:7];
}

-(void)MVDcurrentIndexWasUpdated:(long int)currentIndex {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    switch (currentIndex) {
        case 0:
            //Button 1
            self.view.backgroundColor = [UIColor blueColor];
            NSLog(@"0");
            break;
        case 1:
            //Button 2
            self.view.backgroundColor = [UIColor greenColor];
            NSLog(@"1");
            break;
        case 2:
            //Button 3
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            NSLog(@"2");
            break;
        default:
            break;
    }
    
    [UIView commitAnimations];
}

- (IBAction)toggleMenu:(id)sender {
    [mainMenuView toggleMenu];
}

@end
