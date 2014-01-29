//
//  Comment.h
//  Footbook
//
//  Created by Matthew Graham on 1/29/14.
//  Copyright (c) 2014 Matthew Graham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * timeStamp;

@end
