//
//  Friend.h
//  Footbook
//
//  Created by Matthew Graham on 1/29/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numFeet;
@property (nonatomic, retain) NSNumber * shoeSize;
@property (nonatomic, retain) NSString * imagePath;

@end
