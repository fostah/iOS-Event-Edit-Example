//
//  EventEditViewController.m
//  EventEditExample
//
//  Created by Michael Foster on 9/27/12.
//  Copyright (c) 2012 Michael Foster. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

#import "EventEditViewController.h"

@interface EventEditViewController ()

- (IBAction)eventAddButtonPressed:(id)sender;

- (void)presentEventEditViewControllerWithEventStore:(EKEventStore*)eventStore;

@end

@implementation EventEditViewController

@synthesize eventAddButton = _eventAddButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_eventAddButton addTarget:self
                        action:@selector(eventAddButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)eventAddButtonPressed:(id)sender
{
    EKEventStore* eventStore = [[EKEventStore alloc] init];
    
    // iOS 6 introduced a requirement where the app must
    // explicitly request access to the user's calendar. This
    // function is built to support the new iOS6 requirement,
    // as well as earlier versions of the OS.
    if([eventStore respondsToSelector:
        @selector(requestAccessToEntityType:completion:)]) {
        // iOS 6 and later
        [eventStore
         requestAccessToEntityType:EKEntityTypeEvent
         completion:^(BOOL granted, NSError *error) {
             [self performSelectorOnMainThread:
              @selector(presentEventEditViewControllerWithEventStore:)
                                    withObject:eventStore
                                 waitUntilDone:NO];
         }];
    } else {
        // iOS 5
        [self presentEventEditViewControllerWithEventStore:eventStore];
    }
}

- (void)presentEventEditViewControllerWithEventStore:(EKEventStore*)eventStore
{
    EKEventEditViewController* vc = [[EKEventEditViewController alloc] init];
    vc.eventStore = eventStore;
    
    EKEvent* event = [EKEvent eventWithEventStore:eventStore];
    // Prepopulate all kinds of useful information with you event.
    event.title = @"New Event Title";
    event.startDate = [NSDate date];
    event.endDate = [NSDate date];
    event.URL = [NSURL URLWithString:@"http://fostah.com"];
    event.notes = @"This event will be awesome!";
    event.allDay = YES;
    vc.event = event;
    
    vc.editViewDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma EKEventEditViewDelegate

- (void)eventEditViewController:(EKEventEditViewController*)controller
          didCompleteWithAction:(EKEventEditViewAction)action
{
    [controller dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
