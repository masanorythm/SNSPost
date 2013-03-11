//
//  SNSPost.h
//
//  Created by masanorythm
//

#import "cocos2d.h"

#import <Twitter/Twitter.h>
#import <Social/Social.h>

typedef enum {
    SNSTypeTwitter,
    SNSTypeFacebook,
    SNSTypeLINE,
} SNSType;

@interface SNSPost : CCNode {
    
    NSString    *post;      // ポスト内容
    NSURL       *url;       // 添付URL
    UIImage     *image;     // 添付画像
    SNSType     snsType;    // SNSタイプ
}

// Twitter
+ (id)postWithTwitter:(NSString *)_tweet;
+ (id)postWithTwitter:(NSString *)_tweet setUrl:(NSString *)_url;
+ (id)postWithTwitter:(NSString *)_tweet setImage:(UIImage *)_image;
+ (id)postWithTwitter:(NSString *)_tweet setUrl:(NSString *)_url setImage:(UIImage *)_image;

// Facebook
+ (id)postWithFacebook:(NSString *)_string;
+ (id)postWithFacebook:(NSString *)_string setUrl:(NSString *)_url;
+ (id)postWithFacebook:(NSString *)_string setImage:(UIImage *)_image;
+ (id)postWithFacebook:(NSString *)_string setUrl:(NSString *)_url setImage:(UIImage *)_image;

// LINE
+ (id)postWithLineText:(NSString *)_string;
+ (id)postWithLineImage:(UIImage *)_image;

@end
