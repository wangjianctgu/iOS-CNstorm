//
//  RadioButton.m
//  travelApp
//
//  Created by 徐彪 on 13-9-3.
//  Copyright (c) 2013年 徐彪. All rights reserved.
//

#import "RadioButton.h"

@implementation RadioButton

@synthesize isChecked;

static NSMutableDictionary* groups;

- (id)initWithFrame:(CGRect)frame groupId:(NSString*)_groupId
{
    self = [super initWithFrame:frame];
    if (self)
    {      
        groupId=_groupId;
        if(!groups)
        {
            groups=[[NSMutableDictionary alloc]init];
        }
        
        NSMutableArray *radios=[groups objectForKey:_groupId];
        if(!radios)
        {
            radios=[[NSMutableArray alloc]init];
            [groups setObject:radios forKey:groupId];
        }
        [radios addObject:self];
        if(radios.count<=1)
            self.isChecked=YES;
        else
        {
            isChecked=YES;
            self.isChecked=NO;
        }
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)setIsChecked:(BOOL)_isChecked
{
    if(isChecked!=_isChecked)
    {
        if(_isChecked)
        {
            [self setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:(UIControlStateNormal)];
            NSArray* radios=[groups objectForKey:groupId];
            for (RadioButton *radio in radios)
            {
                if(radio.isChecked)
                    radio.isChecked=NO;
            }
        }
        else
        {
            [self setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:(UIControlStateNormal)];
           
        }
        isChecked=_isChecked;
    }
}

-(void)click
{
    self.isChecked=YES;
}

-(void)removeRadioButton
{
    NSMutableArray *radios = [groups objectForKey:groupId];
    [radios removeObject:self];
    if(radios.count==0)
        [groups removeObjectForKey:groupId];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
