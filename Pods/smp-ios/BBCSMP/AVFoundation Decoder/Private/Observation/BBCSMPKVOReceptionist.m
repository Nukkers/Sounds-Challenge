//
//  BBCSMPKVOReceptionist.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPKVOReceptionist.h"
#import "BBCSMPWorker.h"

@implementation BBCSMPKVOReceptionist {
    NSObject *_subject;
    NSString *_keyPath;
    void *_context;
    id<BBCSMPWorker> _callbackWorker;
    __weak id _target;
    SEL _selector;
}

#pragma mark Deallocation

- (void)dealloc
{
    [_subject removeObserver:self forKeyPath:_keyPath context:_context];
}

#pragma mark Class Methods

+ (instancetype)receptionistWithSubject:(NSObject*)subject
                                keyPath:(NSString*)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(void*)context
                         callbackWorker:(id<BBCSMPWorker>)worker
                                 target:(id)target
                               selector:(SEL)selector
{
    return [[self alloc] initWithSubject:subject
                                 keyPath:keyPath
                                 options:options
                                 context:context
                          callbackWorker:worker
                                  target:target
                                selector:selector];
}

#pragma mark Initialization

- (instancetype)initWithSubject:(NSObject*)subject
                        keyPath:(NSString*)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void*)context
                 callbackWorker:(id<BBCSMPWorker>)worker
                         target:(id)target
                       selector:(SEL)selector
{
    self = [super init];
    if (self) {
        _subject = subject;
        _keyPath = keyPath;
        _context = context;
        _callbackWorker = worker;
        _target = target;
        _selector = selector;

        [subject addObserver:self
                  forKeyPath:keyPath
                     options:options
                     context:context];
    }

    return self;
}

#pragma mark Overrides

- (void)observeValueForKeyPath:(NSString*)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString*, id>*)change
                       context:(void*)context
{
    if (_context == context) {
        [self invokeHandler];
    }
}

#pragma mark Private

- (void)invokeHandler
{
    __weak typeof(self) weakSelf = self;
    [_callbackWorker performWork:^{ [weakSelf notifyTarget]; }];
}

- (void)notifyTarget
{
    id target = _target;
    if(target) {
        IMP imp = [target methodForSelector:_selector];
        void (*method)(id, SEL) = (void*)imp;
        method(target, _selector);
    }
}

@end
