//
//  photoCell.h
//  StachesAndGlasses
//
//  Created by Yu Yichen on 5/14/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;

@end
