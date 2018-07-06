//
//  TweetCell.m
//  twitter
//
//  Created by Trevon Wiggs on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   [super setSelected:selected animated:animated];
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    // Sets tweet data
    self.dateLabel.text = tweet.createdAt;
    self.tweetTextLabel.text = tweet.tweetText;
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    
    // Creates a circle frame for the profile pic
    [self.profilePic setImageWithURL:tweet.user.profilePicURL];
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    
    // Sets the count for a tweets' likes and retweets
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
}

// Action for tapping the like button
- (IBAction)didTapLike:(UIButton *)sender {
    if (!self.tweet.favorited){
        
        // Updates the local tweet model
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        self.likeButton.selected = YES;
        
        // Sends a POST request to the POST favorites/create endpoint
        [[APIManager shared]favorite:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error favoriting Tweet: %@", error.localizedDescription);
            }else{
                NSLog(@"Favorite Tweet Success!: %@", tweet.tweetText);
            }
        }];
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        self.likeButton.selected = NO;
        
        [[APIManager shared]destroy:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error favoriting Tweet: %@", error.localizedDescription);
            }else{
                NSLog(@"Favorite Tweet Success!: %@", tweet.tweetText);
            }
        }];
    }
   
    // Updates the cell U
    [self refreshData];
    
}

// Action for tapping the retweet Button
- (IBAction)didTapRetweet:(id)sender {
    if (!self.tweet.retweeted){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        self.retweetButton.selected = YES;
        
        [[APIManager shared]retweet:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error retweeting Tweet: %@", error.localizedDescription);
            }else{
                NSLog(@"Retweet Successful!: %@", tweet.tweetText);
            }
        }];
        
    } else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        self.retweetButton.selected = NO;
        
        [[APIManager shared]unretweet:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error unretweeting Tweet: %@", error.localizedDescription);
            }else{
                NSLog(@"Unretweet Successful!: %@", tweet.tweetText);
            }
        }];
    }
    [self refreshData];
}

// Refresh the count for favorites and retweets
- (void)refreshData{
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
}

@end
