//
//  EsportyPostRemoteFetcher.h
//  Esporty
//
//  Created by George Villasboas on 8/6/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EsportyPost.h"

// Endereço do seu webservice
// Repositório do server side: https://github.com/ghvillasboas/EsportyAppServerSide
// Ao executar no device, certifique-se de que o endereço seja um IP da sua rede
// e não localhost, caso contrário seu device não poderá encontrar o serviço.
#define webserviceURL @"http://localhost:3000/posts/random.json";

typedef void (^EsportyUpdateCompletionHandler)(BOOL recebeuNovosPosts);

@interface EsportyPostRemoteFetcher : NSObject

///---------------------------------------
/// @name Atributos
///---------------------------------------

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

///---------------------------------------
/// @name Singlegon
///---------------------------------------

/**
 *  Singleton do fetcher
 *
 *  @return instancetype
 */
+ (id)sharedFetcher;

///---------------------------------------
/// @name Fetching
///---------------------------------------

/**
 *  Efetua o fetch remoto dos posts a partir do webservice
 *
 *  @param completionHandler Handler a ser executado ao finalizar a requisicao
 */
- (void)updatePostsWithCompletionHandler:(EsportyUpdateCompletionHandler)completionHandler;

@end
