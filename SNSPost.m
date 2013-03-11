//
//  SNSPost.m
//
//  Created by masanorythm
//

#import "SNSPost.h"

@implementation SNSPost

//=========//
// Twitter //
//=========//
+ (id)postWithTwitter:(NSString *)_string
{
    return [[[self alloc] initWithString:_string setUrl:nil setImage:nil type:SNSTypeTwitter] autorelease];
}

+ (id)postWithTwitter:(NSString *)_string setUrl:(NSString *)_url
{
    return [[[self alloc] initWithString:_string setUrl:_url setImage:nil type:SNSTypeTwitter] autorelease];
}

+ (id)postWithTwitter:(NSString *)_string setImage:(UIImage *)_image
{
    return [[[self alloc] initWithString:_string setUrl:nil setImage:_image type:SNSTypeTwitter] autorelease];
}

+ (id)postWithTwitter:(NSString *)_string setUrl:(NSString *)_url setImage:(UIImage *)_image
{
    return [[[self alloc] initWithString:_string setUrl:_url setImage:_image type:SNSTypeTwitter] autorelease];
}


//==========//
// Facebook //
//==========//
+ (id)postWithFacebook:(NSString *)_string
{
    return [[[self alloc] initWithString:_string setUrl:nil setImage:nil type:SNSTypeFacebook] autorelease];
}

+ (id)postWithFacebook:(NSString *)_string setUrl:(NSString *)_url
{
    return [[[self alloc] initWithString:_string setUrl:_url setImage:nil type:SNSTypeFacebook] autorelease];
}

+ (id)postWithFacebook:(NSString *)_string setImage:(UIImage *)_image
{
    return [[[self alloc] initWithString:_string setUrl:nil setImage:_image type:SNSTypeFacebook] autorelease];
}

+ (id)postWithFacebook:(NSString *)_string setUrl:(NSString *)_url setImage:(UIImage *)_image
{
    return [[[self alloc] initWithString:_string setUrl:_url setImage:_image type:SNSTypeFacebook] autorelease];
}


//======//
// LINE //
//======//
+ (id)postWithLineText:(NSString *)_string
{
    return [[[self alloc] initWithString:_string setUrl:nil setImage:nil type:SNSTypeLINE] autorelease];
}
+ (id)postWithLineImage:(UIImage *)_image
{
    return [[[self alloc] initWithString:nil setUrl:nil setImage:_image type:SNSTypeLINE] autorelease];
}

//============//
// Initialize //
//============//
- (id)initWithString:(NSString *)_string setUrl:(NSString *)_url setImage:(UIImage *)_image type:(SNSType)_type
{
    if ((self = [super init])) {
        
        post    = _string;
        url     = [NSURL URLWithString:_url];
        image   = _image;
        snsType = _type;
        
        switch (snsType) {
            case SNSTypeTwitter:
                [self onTwitter];
                break;
            case SNSTypeFacebook:
                [self onFacebook];
                break;
            case SNSTypeLINE:
                [self onLine];
                break;
        }
    }
    return self;
}

#pragma mark - Twitter処理
- (void) onTwitter
{
    //------------------//
    // Social.framework //
    //------------------//
    if(NSClassFromString(@"SLComposeViewController")) {
        
        SLComposeViewController *tweetViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // ツイート内容セット
        [tweetViewController setInitialText:post];
        
        // URLセット
        if (url != nil)
            [tweetViewController addURL:url];
        
        // 画像セット
        if (image != nil)
            [tweetViewController addImage:image];
        
        tweetViewController.completionHandler = ^(SLComposeViewControllerResult result)
        {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    // 送信した場合
                    break;
                case SLComposeViewControllerResultCancelled:
                    // キャンセルした場合
                    break;
            }
            
            [[CCDirector sharedDirector] dismissViewControllerAnimated:YES completion:^{
                // ビュー消去完了後の処理
            }];
            
        };
        
        [[CCDirector sharedDirector] presentViewController:tweetViewController animated:YES completion:^{
            // ビュー表示完了後の処理
        }];
    }
    
    //-------------------//
    // Twitter.framework //
    //-------------------//
    else {
        
        TWTweetComposeViewController *tweetViewController = [[[TWTweetComposeViewController alloc] init] autorelease];
        
        // ツイート内容セット
        [tweetViewController setInitialText:post];
        
        // URLセット
        if (url != nil)
            [tweetViewController addURL:url];
        
        // 画像セット
        if (image != nil)
            [tweetViewController addImage:image];
        
        tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result)
        {
            switch (result) {
                case TWTweetComposeViewControllerResultDone:
                    // 送信した場合
                    break;
                case TWTweetComposeViewControllerResultCancelled:
                    // キャンセルした場合
                    break;
            }
            
            [[CCDirector sharedDirector] dismissViewControllerAnimated:YES completion:^{
                // ビュー消去完了後の処理
            }];
            
        };
        
        [[CCDirector sharedDirector] presentViewController:tweetViewController animated:YES completion:^{
            // ビュー表示完了後の処理
        }];
    }
}

#pragma mark - Facebook処理
- (void)onFacebook
{
    //------------------//
    // Social.framework //
    //------------------//
    if(NSClassFromString(@"SLComposeViewController")) {
        SLComposeViewController *fbViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        // ポスト内容セット
        [fbViewController setInitialText:post];
        
        // URLセット
        if (url != nil)
            [fbViewController addURL:url];
        
        // 画像セット
        if (image != nil)
            [fbViewController addImage:image];
        
        fbViewController.completionHandler = ^(SLComposeViewControllerResult result)
        {
            switch (result) {
                case SLComposeViewControllerResultDone:
                    // 送信した場合
                    CCLOG(@"Done");
                    break;
                case SLComposeViewControllerResultCancelled:
                    // キャンセルした場合
                    CCLOG(@"Cancelled");
                    break;
            }
            [[CCDirector sharedDirector] dismissViewControllerAnimated:YES completion:^{
                // ビュー消去完了後の処理
            }];
        };
        
        [[CCDirector sharedDirector] presentViewController:fbViewController animated:YES completion:^{
            // ビュー表示完了後の処理
        }];
    }
    
    //----------------------//
    // iOS6未満の対応があれば //
    //----------------------//
    else {
        
    }
}

#pragma mark - LINE処理
- (void)onLine
{
    // LINEアプリがインストール済みがチェック
    BOOL installedLine = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]];
    
    if (installedLine) { // LINEアプリが存在する
        
        NSURL *targetUrl;
        
        if (post != nil) {
            // テキストセット
            NSString *urlString = [NSString stringWithFormat:@"line://msg/text/%@",
                                   [post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            targetUrl = [NSURL URLWithString:urlString];
        }
        if (image != nil) {
            // 画像セット
            UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:@"jp.naver.linecamera.pasteboard" create:YES];
            [pasteboard setData:UIImageJPEGRepresentation(image, 0.8) forPasteboardType:@"public.jpeg"];
            NSString *urlString = [NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name];
            targetUrl = [NSURL URLWithString:urlString];
        }
        
        // LINEアプリを開く
        [[UIApplication sharedApplication] openURL:targetUrl];
        
    } else { // LINEアプリが存在しない
        
        CCLOG(@"LINE is not installed");
        
        // LINE App Store へ飛ばす
        // アラートビューを出すなど...
    }
}

#pragma mark - 解放
- (void)dealloc
{
    CCLOG(@"LOG: %@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}
@end
