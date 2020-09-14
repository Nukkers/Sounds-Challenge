#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BBCSMPViewFactory <NSObject>

- (UIView*)getView;

@end
