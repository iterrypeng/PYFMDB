//
//  CarTable.m
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import "CarTable.h"

@implementation CarTable
-(PYStructure *)structure{
    PYStructure * st = [[PYStructure alloc] init];
    [st addWithField:@"id" andType:PYStructureTypeAutoInc];
    [st addWithField:@"name" andType:PYStructureTypeNormalText];
    [st addWithField:@"wheels" andType:PYStructureTypeNormalInt];
    return st;
}

-(NSString *)tableName{
    return @"car";
}
@end
