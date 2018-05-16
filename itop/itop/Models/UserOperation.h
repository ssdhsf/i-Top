//
//  UserOperation.h
//  itop
//
//  Created by huangli on 2018/5/15.
//  Copyright © 2018年 i-Top. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UserOperation  <NSObject>

@end

@interface UserOperation : JSONModel

@property (nonatomic, strong) NSNumber <Optional>*message_count;
@property (nonatomic, strong) NSNumber <Optional>*comment_count;
@property (nonatomic, strong) NSNumber <Optional>*follow_count;

@end
