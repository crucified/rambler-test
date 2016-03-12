//
//  RMLentaParser.m
//  rambler-test
//
//  Created by Denis Kharitonov on 12.03.16.
//  Copyright © 2016 dp. All rights reserved.
//

#import "RMLentaParser.h"

typedef enum : NSUInteger {
    RMParseStateIdle,
    RMParseStateTitle,
    RMParseStateDescription,
    RMParseStateImagePath,
    RMParseStateDate
} RMParseState;

@interface RMLentaParser()<NSXMLParserDelegate>

@property (copy, nonatomic) RMParseCompletion completion;
@property (strong, nonatomic) NSMutableArray* parsedItems;
@property (strong, nonatomic) RMNewsItem* currentItem;
@property (assign, nonatomic) RMParseState state;
@property (strong, nonatomic) NSDateFormatter* dateFormatter;

@end


@implementation RMLentaParser

-(instancetype) init
{
    self = [super init];
    if (self) {
        NSDateFormatter* dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"EEE, dd MM yyyy HH:mm:SS ZZZ";
        _dateFormatter = dateFormatter;
    }
    return self;
}

-(void) parseNewsFromXMLParser:(NSXMLParser *)xmlParser completion:(RMParseCompletion)completion
{
    self.state = RMParseStateIdle;
    self.parsedItems = [NSMutableArray new];
    self.completion = completion;
    xmlParser.delegate = self;
    dispatch_queue_t aQueue = dispatch_queue_create("parseQueue", NULL);

    dispatch_async(aQueue, ^{
        [xmlParser parse];
    });
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
        [self.parsedItems addObject:self.currentItem];
        self.currentItem = nil;
    }
}

-(void) parserDidEndDocument:(NSXMLParser *)parser
{
    if (self.completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
          self.completion(self.parsedItems, nil);
        });
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
    if (self.completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completion(nil, parseError);
        });
    }
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    if (self.completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completion(nil, validationError);
        });
    }
}


@end

