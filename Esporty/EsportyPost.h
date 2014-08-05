//
//  EsportyPost.h
//  Esporty
//
//  Created by George Villasboas on 8/6/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EsportyPost : NSManagedObject

@property (nonatomic, retain) NSString * autor;
@property (nonatomic, retain) NSString * comentario;
@property (nonatomic, retain) NSDate * dataHora;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSDate * fetchedDate;

@end
