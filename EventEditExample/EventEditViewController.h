//
//  EventEditViewController.h
//  EventEditExample
//
//  Created by Michael Foster on 9/27/12.
//  Copyright (c) 2012 Michael Foster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventEditViewController : UIViewController
<EKEventEditViewDelegate>

@property (retain, nonatomic) IBOutlet UIButton* eventAddButton;

@end
