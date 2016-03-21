//
//  RMLentaParseOperation_Private.h
//  rambler-test
//
//  Created by Denis Kharitonov on 21.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMLentaParseOperation.h"

@interface RMLentaParseOperation()<NSXMLParserDelegate>
@property (strong, nonatomic) NSMutableArray* operationalParsedItems;
@property (strong, nonatomic) RMNewsItem* currentItem;
@property (assign, nonatomic) RMParseState state;
@property (strong, nonatomic) NSDateFormatter* dateFormatter;
@property (strong, nonatomic) NSXMLParser* parser;
@end
