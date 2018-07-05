//
//  Tweet.h
//  twitter
//
//  Created by Trevon Wiggs on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *tweetText;
@property (nonatomic) int retweetCount;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) BOOL retweeted;

@property (nonatomic, strong) User *retweetedBy;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
