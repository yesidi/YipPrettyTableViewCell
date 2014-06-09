//
//  YipPrettyTableViewCell.m
//  test
//
//  Created by Yip on 14-6-10.
//  Copyright (c) 2014年 Yip. All rights reserved.
//
#import "YipPrettyTableViewCell.h"
#define RADIUS 5


@implementation YipPrettyTableViewCell
@synthesize indexPath;
@synthesize cellPosition;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.subviews enumerateObjectsUsingBlock:^(UIView *obj1, NSUInteger idx1, BOOL *stop1) {
        //        NSLog(@"obj==%d===>%@",idx1 , obj1);
        [obj1.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            //            NSLog(@"-------->%d===>%@",idx , obj);
            if (obj.frame.origin.x == 0 && obj.frame.size.height == 0.5) {
                [obj setHidden:YES];
            }
            else [obj setHidden:NO];
        }];
    }];
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}


- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}


-(void)groupedCellWithIndexPath:(UITableView *)tableView :(NSIndexPath *)theIndexPath
{
    if (theIndexPath.row == 0 && theIndexPath.row == [tableView numberOfRowsInSection:theIndexPath.section] - 1) {
        cellPosition = CELL_POSITION_TOP_AND_BUTTOM;
    }
    else if (theIndexPath.row == 0) {
        cellPosition = CELL_POSITION_TOP;
    }
    else if (theIndexPath.row == [tableView numberOfRowsInSection:theIndexPath.section] - 1)
    {
        cellPosition = CELL_POSITION_BUTTOM;
    }
    else cellPosition = CELL_POSITION_MID;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}


-(void)drawMask
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.imageView.frame;
    CGRect rect = self.bounds;
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    if (cellPosition == CELL_POSITION_TOP) {
        CGPathMoveToPoint(path, NULL, minX, maxY);
        CGPathAddArcToPoint(path, NULL, minX, minY, midX, minY, RADIUS);
        CGPathAddArcToPoint(path, NULL, maxX, minY, maxX, maxY, RADIUS);
        CGPathAddLineToPoint(path, NULL, maxX, maxY);
        CGPathCloseSubpath(path);
    }
    else if(cellPosition == CELL_POSITION_BUTTOM) {
        CGPathMoveToPoint(path, NULL, minX, minY);
        CGPathAddArcToPoint(path, NULL, minX, maxY, midX, maxY, RADIUS);
        CGPathAddArcToPoint(path, NULL, maxX, maxY, maxX, minY, RADIUS);
        CGPathAddLineToPoint(path, NULL, maxX, minY);
        CGPathCloseSubpath(path);
    }
    else if(cellPosition == CELL_POSITION_TOP_AND_BUTTOM) {
        CGPathMoveToPoint(path, NULL, minX, midY);
        CGPathAddArcToPoint(path, NULL, minX, maxY, midX, maxY, RADIUS);
        CGPathAddArcToPoint(path, NULL, maxX, maxY, maxX, midY, RADIUS);
        CGPathAddLineToPoint(path, NULL, maxX, midY);
        CGPathAddArcToPoint(path, NULL, maxX, minY, midX, minY, RADIUS);
        CGPathAddArcToPoint(path, NULL, minX, minY, minX, midY, RADIUS);
        CGPathCloseSubpath(path);
    }
    
    maskLayer.path = path;
    maskLayer.fillColor = [UIColor redColor].CGColor;
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.mask = maskLayer;
}


-(void)drawRect:(CGRect)rect
{
    if (cellPosition == CELL_POSITION_TOP || cellPosition == CELL_POSITION_BUTTOM || cellPosition == CELL_POSITION_TOP_AND_BUTTOM) {
        [self drawMask];
    }
    else
    {
        self.layer.mask = nil;
        [super drawRect:rect];
    }
}


@end