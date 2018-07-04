//
//  User.h
//  twitter
//
//  Created by Trevon Wiggs on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// Properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSURL *profilePicURL;

// Initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
