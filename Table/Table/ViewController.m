
//  ViewController.m
//  Table
//
//  Created by Guest User on 09/12/15.
//  Copyright (c) 2015 Guest User. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize imageFile;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshFeeds];

    //add refresh control to the table view
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refreshFeedInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview: refreshControl];
}


-(void) refreshFeedInvoked:(id)sender forState:(UIControlState)state {
    [self refreshFeeds];
}

- (void)refreshFeeds{
    NSLog(@"Refreshing");
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"news" withExtension:@"xml"];
    NSURL *url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/rss.xml"];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    feeds=[[NSMutableArray alloc] init];
    //parser= [[NSXMLParser alloc] initWithData:data];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    // End Refreshing
    [refreshControl endRefreshing];
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
}


-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    if([element isEqualToString:@"item"]){
        
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];        
        pubDate = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        imageUrl = [[NSMutableString alloc] init];
    }
    if ( [element isEqualToString:@"media:thumbnail"] )
    {
        imageUrl = [attributeDict valueForKey:@"url"];
    }

}
-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }else if ([element isEqualToString:@"link"]){
        [link appendString:string];
    } else if ([element isEqualToString:@"pubDate"]){
        [pubDate appendString:string];
    } else if ([element isEqualToString:@"description"]){
        [description appendString:string];
    }
   
}


-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:description forKey:@"description"];
        if (feeds.count <= 19) {
            [feeds addObject:[item copy]];
        }
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{

    [self.tableView reloadData];
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    NSDictionary *userInfo = parseError.userInfo;
    NSNumber *lineNumber = userInfo[@"NSXMLParserErrorLineNumber"];
    NSNumber *errorColumn = userInfo[@"NSXMLParseErrorColumn"];
    NSString *errorMessage = userInfo[@"NSXMLParseErrorMessage"];
    NSLog(@"Error at line %@ and column %@: %@", lineNumber, errorColumn, errorMessage);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Mark : Table view delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [feeds count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *tableIdentifier = @"PrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil){        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    cell.imageView.image=[UIImage imageNamed:@"rsz_rssfeedimage.jpg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController * detailView= segue.destinationViewController;
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        detailView.detailViewControllerstr = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
        detailView.detailViewControllerDescriptionStr = [[feeds objectAtIndex:indexPath.row] objectForKey:@"description"];
    }
    
}
    

@end
