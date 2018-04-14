//
//  Goods.m
//  CNstorm
//
//  Created by Zhang Lisheng on 14-5-15.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (id) init
{
	if((self = [super init]))
    {
        self.goodsImageArray = [[NSMutableArray alloc]init];
        
        self.goodsImageColorDictionary = [[NSMutableDictionary alloc]init];
        
        self.propImageArray = [[NSMutableArray alloc]init];
        
        
        self.realPriceDictionary = [[NSMutableDictionary alloc]init];
        
        self.quantityArray = [[NSMutableArray alloc]init];
        
        
        self.sizeArray = [[NSMutableArray alloc]init];
        
        self.sizeNumberDictionary = [[NSMutableDictionary alloc]init];
        
        
        self.colorArray = [[NSMutableArray alloc]init];
        
        self.colorNumberDictionary = [[NSMutableDictionary alloc]init];
        
        self.kucunDictionary = [[NSMutableDictionary alloc]init];
        
        self.isSelected = YES;
	}
	return self;
}

@end
