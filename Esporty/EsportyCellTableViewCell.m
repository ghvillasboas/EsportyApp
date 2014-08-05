//
//  EsportyCellTableViewCell.m
//  Esporty
//
//  Created by George Villasboas on 8/5/14.
//  Copyright (c) 2014 CocoaHeads Brasil. All rights reserved.
//

#import "EsportyCellTableViewCell.h"

@interface EsportyCellTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *autorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *comentarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataHoraLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSTimer *timerCelulaLida;
@end

@implementation EsportyCellTableViewCell

#pragma mark -
#pragma mark Getters overriders

#pragma mark -
#pragma mark Setters overriders

- (void)setPost:(EsportyPost *)post
{
    if (![post isEqual:_post]) {
        _post = post;
        
        [self setupUIComPost:_post];
        
        if ([_post.fetchedDate timeIntervalSinceDate:[NSDate date]] < -5) {
            self.backgroundColor = [UIColor whiteColor];
        }
        else{
            self.backgroundColor = [UIColor colorWithRed:170/255.f green:237/255.f blue:99/255.f alpha:1.0];
            
            // configura um timer para mudanca do fundo
            self.timerCelulaLida = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(mudaCorCell:) userInfo:nil repeats:NO];
            
        }
    }
}

#pragma mark -
#pragma mark Designated initializers

#pragma mark -
#pragma mark Public methods

#pragma mark -
#pragma mark Private methods

/**
 *  Faz o setup da UI dado um post
 *
 *  @param post Post com os dados
 */
- (void)setupUIComPost:(EsportyPost *)post
{
    self.autorLabel.text = post.autor;
    self.comentarioLabel.text = post.comentario;
    self.dataHoraLabel.text = [self dateToString:post.dataHora];
    self.imagem.image = nil;
    [self.spinner startAnimating];
    self.imagem.image = [UIImage imageWithData:post.image];
}

/**
 *  Altera a cor da cell para branco (geralmente chamado por um timer)
 *
 *  @param timer NSTimer
 */
- (void)mudaCorCell:(NSTimer *)timer
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.backgroundColor = [UIColor whiteColor];
                     }
                     completion:nil];
}

/**
 *  Transforma um NSDate em um NSString
 *
 *  @param date Objeto NSDate
 *
 *  @return NSString no formato dd/MMM/yyyy HH:mm:ss
 */
- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd/MMM/yyyy HH:mm:ss";
    
    return [formatter stringFromDate:date];
}

#pragma mark -
#pragma mark View life cycle

#pragma mark -
#pragma mark Overriden methods

#pragma mark -
#pragma mark Delegates

@end
