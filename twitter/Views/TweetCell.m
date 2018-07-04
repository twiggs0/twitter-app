//
//  TweetCell.m
//  twitter
//
//  Created by Trevon Wiggs on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   // [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}

- (void)setTweet:(Tweet *)tweet {
    _tweet=tweet;
    
    self.textLabel.text = tweet.tweetText;
    self.dateLabel.text = tweet.createdAt;
    self.screenNameLabel.text = tweet.user.screenName;
    self.nameLabel.text = tweet.user.name;
    
    [self.profilePic setImageWithURL:tweet.user.profilePicURL];
    //[self.profilePic bringSubviewToFront:sel]
    
}

@end
