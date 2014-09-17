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
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _textView = [[UITextView alloc] initWithFrame:frame];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _textView.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
        _textView.backgroundColor = [UIColor blueColor];
        _textView.textColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.scrollEnabled = NO;
        [self.contentView addSubview:_textView];
        
        self.backgroundColor = [UIColor redColor];
        
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(void)updateConstraints {
    NSLog( @"%@::%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
    
    [self.contentView removeConstraints:self.contentView.constraints];
    
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)];
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *views = NSDictionaryOfVariableBindings(_textView);
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textView(320)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_textView]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_textView
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:fitting.height];
    [_textView addConstraints:@[heightConstraint]];
    
    [self.contentView addConstraints:constraints];
    [super updateConstraints];
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    NSLog( @"%@::%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
    
    return [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
}

@end
