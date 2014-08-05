//
//  EsportyPostRemoteFetcher.m
//  Esporty
//
//  Created by George Villasboas on 8/6/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

#import "EsportyPostRemoteFetcher.h"

@implementation EsportyPostRemoteFetcher

#pragma mark -
#pragma mark Getters overriders

#pragma mark -
#pragma mark Setters overriders

#pragma mark -
#pragma mark Designated initializers

#pragma mark -
#pragma mark Public methods

+ (id)sharedFetcher
{
    static EsportyPostRemoteFetcher *sharedFetcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFetcher = [[self alloc] init];
    });
    return sharedFetcher;
}

- (void)updatePostsWithCompletionHandler:(EsportyUpdateCompletionHandler)completionHandler
{
    NSString *postsUrl = webserviceURL;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSManagedObjectContext *contextoTemporario = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    contextoTemporario.parentContext = self.managedObjectContext;
    
    [[session dataTaskWithURL:[NSURL URLWithString:postsUrl]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                // handle response
                if (!error) {
                    
                    [contextoTemporario performBlock:^{
                        
                        NSUInteger novosPosts = [self postsWithRemoteJSONData:data];
                        
                        [self.managedObjectContext performBlock:^{
                            
                            NSError *error;
                            if ([self.managedObjectContext hasChanges]) {
                                if (![self.managedObjectContext save:&error]) NSLog(@"ERRO SALVANDO CONTEXTO: %@", error.localizedDescription);
                                [self.managedObjectContext reset];
                            }
                            
                            if (completionHandler) {
                                BOOL temosNovosPosts = novosPosts > 0 ? YES : NO;
                                completionHandler(temosNovosPosts);
                            }
                            
                            NSLog(@"Posts atualizados: %lu", (unsigned long)novosPosts);
                            
                        }];
                    }];
                }
                else{
                    NSLog(@"ERROR: %@", error);
                }
            }] resume];
}

#pragma mark -
#pragma mark Private methods

/**
 *  Trata o retorno do servidor transformando e tratando o json
 *
 *  @param jsonData Dados vindos do servidor
 *
 *  @return Contagem de novos registros
 */
- (NSUInteger)postsWithRemoteJSONData:(NSData *)jsonData
{
    NSError *jsonError;
    NSArray *postsJSON = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&jsonError];
    // transforma os registros em managed objects
    
    for (NSDictionary *remoteData in postsJSON) {
        
        EsportyPost *post = [NSEntityDescription insertNewObjectForEntityForName:@"EsportyPost" inManagedObjectContext:self.managedObjectContext];
        
        post.autor = remoteData[@"autor"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
        post.dataHora = [dateFormatter dateFromString:remoteData[@"data_hora"]];
        
        if (![@"" isEqualToString:remoteData[@"imagem"]]) {
            post.image = [NSData dataWithContentsOfURL:[NSURL URLWithString:remoteData[@"imagem"]]];
        }
        post.comentario = remoteData[@"comments"];
        post.fetchedDate = [NSDate date]; // agora.
    }
    
    // retorna a contagem
    return postsJSON.count;
}

#pragma mark -
#pragma mark ViewController life cycle

#pragma mark -
#pragma mark Overriden methods

#pragma mark -
#pragma mark Storyboards Segues

#pragma mark -
#pragma mark Target/Actions

#pragma mark -
#pragma mark Delegates

#pragma mark -
#pragma mark Notification center


@end