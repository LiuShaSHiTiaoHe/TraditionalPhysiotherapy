//
//  ProjectInfo.m
//  TraditionalPhysiotherapy
//
//  Created by Gu GuiJun on 2018/1/29.
//  Copyright © 2018年 Gu GuiJun. All rights reserved.
//

#import "ProjectInfo.h"

@implementation ProjectInfo


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.projectid forKey:@"projectid"];
    [encoder encodeObject:self.sectionid forKey:@"sectionid"];
    [encoder encodeObject:self.projectprice forKey:@"projectprice"];
    [encoder encodeObject:self.vipprice forKey:@"vipprice"];
    [encoder encodeObject:self.projectname forKey:@"projectname"];
    [encoder encodeObject:self.projectdescription forKey:@"projectdescription"];
    [encoder encodeObject:self.projectimages forKey:@"projectimages"];
    [encoder encodeObject:self.isdelete forKey:@"isdelete"];
    
    
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.projectid = [decoder decodeObjectForKey:@"projectid"];
        self.sectionid = [decoder decodeObjectForKey:@"sectionid"];
        self.projectprice = [decoder decodeObjectForKey:@"projectprice"];
        self.projectname = [decoder decodeObjectForKey:@"projectname"];
        self.projectdescription = [decoder decodeObjectForKey:@"projectdescription"];
        self.projectimages = [decoder decodeObjectForKey:@"projectimages"];
        self.isdelete = [decoder decodeObjectForKey:@"isdelete"];
        self.vipprice = [decoder decodeObjectForKey:@"vipprice"];
    }
    
    return self;
}


@end
