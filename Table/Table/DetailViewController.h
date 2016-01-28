//
//  DetailViewController.h
//  Table
//
//  Created by Guest User on 06/01/16.
//  Copyright (c) 2016 Guest User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property(atomic, retain) NSString * detailViewControllerstr;
@property(atomic, retain) NSString * detailViewControllerDescriptionStr;
@property(atomic, retain) IBOutlet UILabel * detailViewControllerlable;
@property (atomic, retain) IBOutlet UILabel *detailViewControllerDescriptionlabel;
@property (atomic, retain) IBOutlet UIImageView *detailViewControllerImageView;
@end
