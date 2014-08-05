//
//  PostsTableViewController.m
//  Esporty
//
//  Created by George Villasboas on 8/5/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

#import "PostsTableViewController.h"
#import "AppDelegate.h"
#import "EsportyPost.h"
#import "EsportyCellTableViewCell.h"

@interface PostsTableViewController ()

@end

@implementation PostsTableViewController

#pragma mark -
#pragma mark Getters overriders

- (NSManagedObjectContext *)managedObjectContext
{
    if (!_managedObjectContext) {
        AppDelegate *mainApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _managedObjectContext = mainApp.managedObjectContext;
    }
    
    return _managedObjectContext;
}

#pragma mark -
#pragma mark Setters overriders

#pragma mark -
#pragma mark Designated initializers

#pragma mark -
#pragma mark Public methods

#pragma mark -
#pragma mark Private methods

/**
 *  Efetua o setup do NSFetchResultController
 */
- (void)setupFetchedResultsController
{
    if (self.managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EsportyPost"];
        request.predicate = [NSPredicate predicateWithFormat:@"dataHora > %@", [[NSDate alloc] initWithTimeIntervalSinceNow:-60]];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dataHora" ascending:NO]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

/**
 *  Chama o remote fetcher para pegar dados
 *
 *  @param completionHandler Acao a ser executada ao concluir (usualmente atualizacao da UI)
 */
- (void)updateWithCompletionHandler:(void (^)(void))completionHandler
{
    [[EsportyPostRemoteFetcher sharedFetcher] updatePostsWithCompletionHandler:^(BOOL recebeuNovosPosts) {
        if (recebeuNovosPosts) {
            [self.refreshControl endRefreshing];
            
            if (completionHandler) {
                completionHandler();
            }
        }
    }];
}

/**
 *  Metodo de conveniencia para chamar o metodo de update sem completion handler
 */
- (void)updatePosts
{
    [self updateWithCompletionHandler:nil];
}

#pragma mark -
#pragma mark ViewController life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    
    [refreshControl addTarget:self action:@selector(updatePosts) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
    self.refreshControl.tintColor = [UIColor colorWithRed:138/255.f green:194/255.f blue:79/255.f alpha:1.0];
    
    [self setupFetchedResultsController];
}

#pragma mark -
#pragma mark Overriden methods

#pragma mark -
#pragma mark Storyboards Segues

#pragma mark -
#pragma mark Target/Actions

#pragma mark -
#pragma mark Delegates and DataSources

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EsportyCellTableViewCell *cell = (EsportyCellTableViewCell *)[tableView
                                                                  dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    EsportyPost *post = (EsportyPost *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.post = post;
    
    return cell;
}

#pragma mark -
#pragma mark Notification center

@end
