//
//  PYStructure.h
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PYStructureType) {
    PYStructureTypeAutoInc = 0,//自增键
    PYStructureTypePrimaryInt = 1,//主键Int
    PYStructureTypePrimaryText = 2,//主键Text
    PYStructureTypeNormalInt = 3,//普通Int
    PYStructureTypeNormalText = 4,//普通Text
};
@interface PYStructure : NSObject
@property(nonatomic,strong)NSMutableArray *structureArray;
@property(nonatomic,strong)NSDictionary *structureDictory;


-(void)addWithField:(NSString *)field andType:(PYStructureType)type;
-(NSArray *)fieldsArray;
-(NSString *)fieldsString;
@end

