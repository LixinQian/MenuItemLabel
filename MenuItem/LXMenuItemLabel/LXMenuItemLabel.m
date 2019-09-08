//
//  QYCMenuItemLabel.m
//  MenuTest
//
//  Created by 启业云 on 2019/8/30.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "LXMenuItemLabel.h"

@interface LXMenuItemLabel ()

@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end

@implementation LXMenuItemLabel

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return self.shouldLongPress;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // Only return YES for the copy: action AND the copyingEnabled property is YES.
    BOOL matching = NO;
    for (UIMenuItem *item in self.menuList) {
        if (item.action == action) {
            matching = YES;
            break;
        }
    }
    return matching;
}

#pragma mark - UI Actions

- (void) longPressGestureRecognized:(UIGestureRecognizer *) gestureRecognizer {
    if (gestureRecognizer == self.longPressGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            [self becomeFirstResponder];
            
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            copyMenu.menuItems = self.menuList.copy;
            [copyMenu setTargetRect:self.bounds inView:self];
            copyMenu.arrowDirection = UIMenuControllerArrowDefault;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}

#pragma mark - Private Methods

- (void) setupGestureRecognizers {
    // Remove gesture recognizer
    if(self.longPressGestureRecognizer) {
        [self removeGestureRecognizer:self.longPressGestureRecognizer];
        self.longPressGestureRecognizer = nil;
    }
    
    if(self.shouldLongPress) {
        self.userInteractionEnabled = YES;
        // Enable gesture recognizer
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

- (void)qyc_textcopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.text];
}

- (id)forwardingTargetForSelector:(SEL)sel {
    BOOL matching = NO;
    for (UIMenuItem *item in self.menuList) {
        if (item.action == sel) {
            matching = YES;
            break;
        }
    }
    if (matching) {
        return _forwardObject;
    }
    return [super forwardingTargetForSelector:sel];
}

#pragma mark - ================ Getter and Setter =================

- (void)setShouldLongPress:(BOOL)shouldLongPress {
    _shouldLongPress = shouldLongPress;
    [self setupGestureRecognizers];
}

- (NSMutableArray<UIMenuItem *> *)menuList {
    if (!_menuList) {
        UIMenuItem *textcopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(qyc_textcopy:)];
         _menuList = @[textcopy].mutableCopy;
    }
    return _menuList;
}

@end
