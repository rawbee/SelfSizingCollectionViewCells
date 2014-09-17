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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text isEqualToString:@"\n"] ) {
        [_textView resignFirstResponder];
        return NO;
    }
    
    CGSize fitting = [_textView sizeThatFits:CGSizeMake(320, FLT_MAX)];
    if( fitting.height != _textView.frame.size.height ) {
        [self updateConstraints];
        [self.delegate cell:self sizeDidChange:fitting];
    }
    return YES;
}

-(void)updateConstraints {
    NSLog( @"%@::%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
    
    [self.contentView removeConstraints:self.contentView.constraints];
    [_textView removeConstraints:_textView.constraints];
    
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

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    NSLog( @"%@::%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
    
    UICollectionViewLayoutAttributes *attr = [layoutAttributes copy];
    CGSize size = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(layoutAttributes.frame),CGFLOAT_MAX)];
    CGRect newFrame = attr.frame;
    newFrame.size.height = size.height;
    attr.frame = newFrame;
    return attr;
}

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    NSLog( @"%@::%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
    return [super systemLayoutSizeFittingSize:targetSize];
}

@end
