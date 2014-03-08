//
//  ViewController.h
//  menuConcept
//
//  Created by Leonard Schuetz on 03.03.14.
//  Copyright (c) 2014 Leonard Schuetz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "menuView.h"

@interface ViewController : UIViewController <menuViewDelegate> {
    menuView *mainMenuView;
}

@property (strong, nonatomic) IBOutlet UIView *view;

@end
