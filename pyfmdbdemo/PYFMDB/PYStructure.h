//
//  PYStructure.h
//  pyfmdbdemo
//
//  Created by terry peng on 15/12/2.
//  Copyright © 2015年 pengyong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PYStructureType) {
    PYStructureTypeAutoInc = 0,//AUTO INCREAMNT && PRIMARY KEY INT
    PYStructureTypePrimaryInt = 1,//PRIMARY KEY INT
    PYStructureTypePrimaryText = 2,//PRIMARY KEY TEXT
    PYStructureTypeNormalInt = 3,//COMMON COLUMN KEY INT
    PYStructureTypeNormalText = 4,//COMMON COLUMN KEY TEXT
};
@interface PYStructure : NSObject
@property(nonatomic,strong)NSMutableArray *structureArray;
@property(nonatomic,strong)NSDictionary *structureDictory;


-(void)addWithField:(NSString *)field andType:(PYStructureType)type;
-(NSArray *)fieldsArray;
-(NSString *)fieldsString;
@end

