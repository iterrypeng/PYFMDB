//
//  PYStructure.m
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import "PYStructure.h"

@implementation PYStructure
-(void)addWithField:(NSString *)field andType:(PYStructureType)type{
    NSDictionary *structure = [NSDictionary dictionary];
    if (type==PYStructureTypeAutoInc) {
        structure = @{field:@"integer primary key autoincrement"};
    }
    else if (type==PYStructureTypeNormalInt){
        structure = @{field:@"integer not null"};
    }
    else if (type ==PYStructureTypeNormalText){
        structure = @{field:@"text not null"};
    }
    else if(type==PYStructureTypePrimaryInt){
        structure = @{field:@"integer primary key"};
    }
    else if (type==PYStructureTypePrimaryText){
        structure = @{field:@"text primary key"};
    }
    [self.structureArray addObject:structure];
}

-(NSDictionary *)structureDictory{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in self.structureArray) {
        [dict addEntriesFromDictionary:dic];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}



-(NSMutableArray *)structureArray{
    if (_structureArray) {
        return _structureArray;
    }
    _structureArray = [NSMutableArray array];
    return _structureArray;
}
-(NSArray *)fieldsArray{
    return [[self structureDictory] allKeys];
}
-(NSString *)fieldsString{
    NSString *fields = nil;
    for (NSString *obj in self.fieldsArray) {
        if (fields==nil) {
            fields = obj;
        }
        else{
            fields = [NSString stringWithFormat:@"%@,%@",fields,obj];
        }
    }
    return fields;
}
@end
