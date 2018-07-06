//
//  TweetCell.m
//  twitter
//
//  Created by Trevon Wiggs on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   // [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.tweetTextLabel.text = tweet.tweetText;
    self.dateLabel.text = tweet.createdAt;
    self.screenNameLabel.text = tweet.user.screenName;
    self.nameLabel.text = tweet.user.name;
    
    [self.profilePic setImageWithURL:tweet.user.profilePicURL];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
    
}



- (IBAction)didTapLike:(UIButton *)sender {
    if (!self.tweet.favorited){
        // Update the local tweet model
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        self.likeButton.selected = YES;
        
        // TODO: Send a POST request to the POST favorites/create endpoint
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
   
    // Update cell U
    [self refreshData];
    
}

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

- (void)refreshData{
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
}

@end
