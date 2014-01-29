//
//  DetailViewController.h
//  Footbook
//
//  Created by Matthew Graham on 1/29/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
