//
//  YipPrettyTableViewCell.h
//  test
//
//  Created by Yip on 14-6-10.
//  Copyright (c) 2014年 Yip. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CELL_POSITION_TOP,
    CELL_POSITION_MID,
    CELL_POSITION_BUTTOM,
    CELL_POSITION_TOP_AND_BUTTOM,
}CELL_POSITION;


@interface YipPrettyTableViewCell : UITableViewCell
-(void)groupedCellWithIndexPath:(UITableView *)tableView :(NSIndexPath *)theIndexPath;
@property(nonatomic, retain)NSIndexPath *indexPath;
@property(nonatomic) CELL_POSITION cellPosition;
@end
