//
//  RMParseOperation.m
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMGazetaParseOperation.h"
#import "RMNewsItem.h"
#import "NSError+CustomErrors.h"
#import "RMGazetaParseOperation_Private.h"

@implementation RMGazetaParseOperation
@synthesize parseError = _parseError;


+(instancetype) operationWithParser:(NSXMLParser *)parser completion:(RMParseCompletion)completion
{
    RMGazetaParseOperation* op = [RMGazetaParseOperation new];
    parser.delegate = op;
    op.parser = parser;
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"EEE, dd MM yyyy HH:mm:SS ZZZ";
    op.dateFormatter = dateFormatter;
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
    else {
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
    else {
        self.state = RMParseStateIdle;
    }
    //картиночек вроде как в газете нету :(
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        self.currentItem.sourceType = RMParseSourceTypeGazeta;
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
    else if (self.state == RMParseStateDescription){
        if (!self.currentItem.newsDescription) {
            self.currentItem.newsDescription = string;
        }
        else {
            self.currentItem.newsDescription = [self.currentItem.newsDescription stringByAppendingString:string];;
        }
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
