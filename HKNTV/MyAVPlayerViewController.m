//
//  MyAVPlayerViewController.m
//  HKNTV
//
//  Created by ZhiYou on 11/3/14.
//  Copyright (c) 2014 ZhiYou. All rights reserved by HKNTV.
//

#import "MyAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation MyAVPlayerViewController

#define STREAM_SVR_IP @"192.168.1.101"

- (void) setupURLArray{
    self.urlArray = [NSMutableArray array];
    
    [self.urlArray addObject:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    [self.urlArray addObject:@"http://211.216.53.139:1935/vod/mp4:sample2.mp4/playlist.m3u8"];
    [self.urlArray addObject:[NSMutableString stringWithFormat:@"http://%@/speed/speed.m3u8", STREAM_SVR_IP]];
    [self.urlArray addObject:[NSMutableString stringWithFormat:@"http://%@/duck/duck.m3u8", STREAM_SVR_IP]];
    [self.urlArray addObject:[NSMutableString stringWithFormat:@"http://%@/edge/edge.m3u8", STREAM_SVR_IP]];
    
    [self.urlArray addObject:[NSMutableString stringWithFormat:@"http://%@/duck/duck.m3u8", STREAM_SVR_IP]];

}

- (NSString*)getURLString:(NSInteger)index{
    
    if(index < self.urlArray.count){
        return (NSString *)self.urlArray[index];
    }else{
        return (NSString*)self.urlArray[self.urlArray.count -1];
    }
}

- (void)viewDidLoad{
    [self setupURLArray];
    NSLog(@"MyAVPlayerViewController view loaded with index  %ld", self.prog_id);
    NSURL *url = [NSURL URLWithString:[self getURLString:self.prog_id]];
    NSLog(@"%@", url);
    [self setPlayer: [AVPlayer playerWithURL:url]];
    [self setUpPlayerObwithURL:url];
}

/*
 - (id)addPeriodicTimeObserverForInterval:(CMTime)interval
 queue:(dispatch_queue_t)queue
 usingBlock:(void (^)(CMTime time)){NSLog(@"%lld \n", self.player.currentTime.value);};
 */

- (void) setUpPlayerObwithURL:(NSURL *) url{
    Float64 durationSeconds = CMTimeGetSeconds([[[AVURLAsset alloc] initWithURL:url options:nil] duration]);
    NSLog(@"duration seconds %f", durationSeconds);
    CMTime first = CMTimeMakeWithSeconds(2, 1);
    CMTime second = CMTimeMakeWithSeconds(4, 1);
    CMTime third = CMTimeMakeWithSeconds(10, 1);
    CMTime forth = CMTimeMakeWithSeconds(14, 1);
    CMTime fifth = CMTimeMakeWithSeconds(16, 1);
    CMTime sixth = CMTimeMakeWithSeconds(20, 1);
    NSArray *times = @[[NSValue valueWithCMTime:first],
                       [NSValue valueWithCMTime:second],
                       [NSValue valueWithCMTime:third],
                       [NSValue valueWithCMTime:forth],
                       [NSValue valueWithCMTime:fifth],
                       [NSValue valueWithCMTime:sixth],
                       ];
    
    self.playerOb = [self.player addBoundaryTimeObserverForTimes:times queue:NULL usingBlock:^{
        NSString *timeDescription = (NSString *)
        CFBridgingRelease(CMTimeCopyDescription(NULL, [self.player currentTime]));
        NSLog(@"Passed a boudary at %@", timeDescription);
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 150, 10, 10)];
        picView.backgroundColor = [UIColor redColor];
        picView.tag = 99;
        Boolean operated = false;
        
        for (UIView *subView in self.view.subviews)
        {
            if (subView.tag == 99)
            {
                [subView removeFromSuperview];
                operated = true;
            }
        }
        if(!operated){
            [self.view addSubview:picView];
        }
    }];
    
    
    
}

@end
