//
//  CeldaTableViewCell.m
//  FindFoodProject
//
//  Created by Ariana Cisneros on 26/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "Celda.h"

@implementation Celda

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
