//
//  WebViewController.h
//  DriverAssistant
//
//  Created by C on JW 16/3/31.
//  Created by C on JW 118 rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
- (instancetype)initWithURL:(NSString *)url;
@property (nonatomic, copy) NSString *myTitle;

@end
