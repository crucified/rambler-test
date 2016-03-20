//
//  RMLentaParser_Private.h
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMNewsParser.h"

@interface RMNewsParser()<NSXMLParserDelegate>

@property (strong, nonatomic) NSOperationQueue* parseQueue;

@end
