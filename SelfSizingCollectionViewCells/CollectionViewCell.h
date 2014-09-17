//
//  CollectionViewCell.h
//  SelfSizingCollectionViewCells
//
//  Created by Robby Abaya on 9/17/14.
//  Copyright (c) 2014 rawbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewCellDelegate;

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<CollectionViewCellDelegate> delegate;
@property (nonatomic, assign) NSInteger item;

@end

@protocol CollectionViewCellDelegate

-(void)cell:(CollectionViewCell *)cell sizeDidChange:(CGSize)size;

@end
