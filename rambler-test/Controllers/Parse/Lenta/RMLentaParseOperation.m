//
//  RMParseOperation.m
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMLentaParseOperation.h"
#import "RMLentaParseOperation_Private.h"
#import "RMNewsItem.h"
#import "NSError+CustomErrors.h"

@implementation RMLentaParseOperation
@synthesize parseError = _parseError;

+(instancetype) operationWithParser:(NSXMLParser *)parser
                      dateFormatter:(NSDateFormatter *)formatter
                         completion:(RMParseCompletion)completion
{
    RMLentaParseOperation* op = [RMLentaParseOperation new];
    parser.delegate = op;
    op.parser = parser;
    op.dateFormatter = formatter;
    op.completion = completion;
    
    return op;
}

-(void) start
{
    if ([self.parser isKindOfClass:[NSXMLParser class]]) {
        self.isRunning = YES;
        self.state = RMParseStateIdle;
        self.operationalParsedItems = [NSMutableArray new];
        [self.parser parse];
        [self finishOperation];
    }
    else{
        _parseError = [NSError badServerResponseError];
        [self finishOperation];
    }
}


-(void) finishOperation
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    self.isRunning = NO;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
}

-(NSArray*) parsedItems
{
    return self.operationalParsedItems;
}

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"item"]) {
        self.currentItem = [RMNewsItem new];
    }
    else if ([elementName isEqualToString:@"title"]){
        self.state = RMParseStateTitle;
    }
    else if ([elementName isEqualToString:@"description"]){
        self.state = RMParseStateDescription;
    }
    else if ([elementName isEqualToString:@"pubDate"]){
        self.state = RMParseStateDate;
    }
    else if ([elementName isEqualToString:@"enclosure"]) {
        self.state = RMParseStateImagePath;
        NSString* imagePath = [attributeDict objectForKey:@"url"];
        if ([imagePath isKindOfClass:[NSString class]]) {
            self.currentItem.imagePath = imagePath;
        }
    }
    else {
        self.state = RMParseStateIdle;
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        self.currentItem.sourceType = RMParseSourceTypeLenta;
        [self.operationalParsedItems addObject:self.currentItem];
        self.currentItem = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.state == RMParseStateTitle){
        if (!self.currentItem.title) {
            self.currentItem.title = string;
        }
        else {
            self.currentItem.title = [self.currentItem.title stringByAppendingString:string];
        }
    }
    else if (self.state == RMParseStateDate){
        NSDate* date = [self.dateFormatter dateFromString:string];
        if (date){
            self.currentItem.date = date;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    if (self.state == RMParseStateDescription){
        NSString* descStr = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        self.currentItem.newsDescription = descStr;
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    _parseError = parseError;
    _operationalParsedItems = nil;
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    _parseError = validationError;
    _operationalParsedItems = nil;
}

@end
