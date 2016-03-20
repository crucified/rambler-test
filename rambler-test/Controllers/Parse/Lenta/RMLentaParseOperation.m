//
//  RMParseOperation.m
//  rambler-test
//
//  Created by Denis Kharitonov on 20.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMLentaParseOperation.h"
#import "RMNewsItem.h"

@interface RMLentaParseOperation()<NSXMLParserDelegate>
@property (strong, nonatomic) NSMutableArray* operationalParsedItems;
@property (strong, nonatomic) RMNewsItem* currentItem;
@property (assign, nonatomic) RMParseState state;
@property (strong, nonatomic) NSDateFormatter* dateFormatter;
@property (strong, nonatomic) NSXMLParser* parser;
@end

@implementation RMLentaParseOperation
@synthesize parseError = _parseError;

+(instancetype) operationWithParser:(NSXMLParser *)parser completion:(RMParseCompletion)completion
{
    RMLentaParseOperation* op = [RMLentaParseOperation new];
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
    self.isRunning = YES;
    self.state = RMParseStateIdle;
    self.operationalParsedItems = [NSMutableArray new];
    [self.parser parse];
    
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
