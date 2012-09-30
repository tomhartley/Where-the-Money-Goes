//
//  THViewController.h
//  DFID
//
//  Created by Tom Hartley on 29/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGNoise.h"

@interface THViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UILabel *importCosts;
    IBOutlet UILabel *remainingCosts;
    IBOutlet UIImageView *imageView;
    IBOutlet UINavigationBar *bar;
    IBOutlet UIImageView *leftArrow;
    IBOutlet UIImageView *rightArrow;
    IBOutlet UIBarButtonItem *infoButton;
    
    NSMutableArray *data;
    UIView *topView;
    UIImageView *bottomView;
    UIView *backgroundView;
    UIPopoverController *controllerProducts;
    UIPopoverController *controllerCountries;
    UIPopoverController *controllerInfo;
    UITableViewController *tvcCountries;
    UITableViewController *tvcProducts;
}

- (void)productButtonClicked:(UIBarButtonItem *)button;
- (void)countryButtonClicked:(UIBarButtonItem *)button;
- (IBAction)infoButtonClicked:(UIBarButtonItem *)button;
@end
