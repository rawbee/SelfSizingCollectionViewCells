//
//  CollectionViewCell.m
//  SelfSizingCollectionViewCells
//
//  Created by Robby Abaya on 9/17/14.
//  Copyright (c) 2014 rawbee. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell() <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if( self ) {
        _textView = [[UITextView alloc] initWithFrame:frame];
        _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _textView.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
        _textView.backgroundColor = [UIColor blueColor];
        _textView.textColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.scrollEnabled = NO;
        [self.contentView addSubview:_textView];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size {
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    return fitting;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    _textView.frame = CGRectMake(0, 0, self.frame.size.width, fitting.height);
}

@end
