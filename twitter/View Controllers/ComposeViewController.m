//
//  ComposeViewController.m
//  twitter
//
//  Created by Trevon Wiggs on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "ComposeViewController.h"
#import "TimelineViewController.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)closeButton:(id)sender;
- (IBAction)tweetButton:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Close out of ComposeViewController
- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

// Publish the composed tweet
- (IBAction)tweetButton:(id)sender {
    [[APIManager shared]postStatusWithText:(NSString *)self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


@end
