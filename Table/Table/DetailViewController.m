//
//  DetailViewController.m
//  Table
//
//  Created by Guest User on 06/01/16.
//  Copyright (c) 2016 Guest User. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _detailViewControllerlable.text = _detailViewControllerstr;
    _detailViewControllerDescriptionlabel.text = _detailViewControllerDescriptionStr;
    _detailViewControllerImageView.image = [UIImage imageNamed:@"DetailViewImage.jpg"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
