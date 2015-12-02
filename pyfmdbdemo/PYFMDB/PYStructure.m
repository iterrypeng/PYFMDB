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
    __block NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self.structureArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dict addEntriesFromDictionary:obj];
    }];
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
   __block NSString *fields = nil;
    [self.fieldsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (fields==nil) {
            fields = obj;
        }
        else{
            fields = [NSString stringWithFormat:@"%@,%@",fields,obj];
        }
    }];
    return fields;
}
@end
