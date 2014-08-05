//
//  PostsTableViewController.h
//  Esporty
//
//  Created by George Villasboas on 8/5/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "EsportyPostRemoteFetcher.h"

@interface PostsTableViewController : CoreDataTableViewController

///---------------------------------------
/// @name Atributos
///---------------------------------------

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
