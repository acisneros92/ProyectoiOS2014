//
//  FavoritesDetailViewController.m
//  FindFood
//
//  Created by Alexander Baumann on 11/4/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import "FavoritesDetailViewController.h"

@interface FavoritesDetailViewController ()
- (void)configureView;
@end

@implementation FavoritesDetailViewController


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem objectForKey:@"nombre"];
        self.direccion.text = [self.detailItem objectForKey:@"direccion"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
