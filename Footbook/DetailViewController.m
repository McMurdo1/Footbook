//
//  DetailViewController.m
//  Footbook
//
//  Created by Matthew Graham on 1/29/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import "DetailViewController.h"
#import "Friend.h"
#import "Comment.h"

@interface DetailViewController () <UITextFieldDelegate>
{
    __weak IBOutlet UILabel *detailName;
    __weak IBOutlet UILabel *detailNumFeet;
    __weak IBOutlet UILabel *detailShoeSize;
    __weak IBOutlet UITextField *URLTextField;
    Friend *friend;
}

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    detailName.text = friend.name;
    detailNumFeet.text = friend.numFeet.description;
    detailShoeSize.text = friend.shoeSize.description;
    URLTextField.delegate = self;
}

-(void)setDetailItem:(Friend*)detailFriend
{
    friend = detailFriend;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSData *imageData = UIImagePNGRepresentation([UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URLTextField.text]]]);
    [friend.managedObjectContext setValue:imageData forKey:@"image"];
    [URLTextField resignFirstResponder];
    NSLog(@"%@", imageData);
    return YES;
}

@end
