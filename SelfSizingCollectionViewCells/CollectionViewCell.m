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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text isEqualToString:@"\n"] ) {
        [_textView resignFirstResponder];
        return NO;
    }
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    if( self.contentView.frame.size.height != fitting.height ) {
        [_delegate cell:self sizeDidChange:fitting];
    }
    
    return YES;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    _textView.frame = CGRectMake(0, 0, self.frame.size.width, fitting.height);
}

-(CGSize)sizeThatFits:(CGSize)size {
    NSLog( @"%d: %@", self.item, NSStringFromSelector(_cmd) );
    return [super sizeThatFits:size];
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    NSLog( @"%d: %@", self.item, NSStringFromSelector(_cmd) );
    
    UICollectionViewLayoutAttributes *attr = [layoutAttributes copy];
    CGRect targetFrame = attr.frame;
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    targetFrame.size.height = fitting.height;
    attr.frame = targetFrame;
    return attr;
}

@end