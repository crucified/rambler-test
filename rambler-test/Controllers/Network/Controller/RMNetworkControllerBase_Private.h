//
//  RMNetworkControllerBase_RMNetworkControllerBase_Private.h
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNetworkControllerBase.h"

#import <AFNetworking/AFNetworking.h>

@interface RMNetworkControllerBase()

@property (weak, nonatomic) AFHTTPRequestOperationManager* HTTPmanager;
@property (strong, nonatomic) NSOperation* currentOperation;

@end

