//
//  ViewController.h
//  Table
//
//  Created by Guest User on 09/12/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>{
    
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *pubDate;
    NSMutableString *description;
    NSMutableString *imageUrl;
    NSString *element;
    UIRefreshControl *refreshControl; 
}

@property(nonatomic, retain) NSArray *list;
@property(atomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSString *imageFile;

@end

