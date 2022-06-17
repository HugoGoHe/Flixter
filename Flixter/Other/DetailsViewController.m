//
//  DetailsViewController.m
//  Flixter
//
//  Created by Hugo Gomez Herrera on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *BigPosterView;
@property (weak, nonatomic) IBOutlet UIImageView *SmallPosterView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.BigPosterView = movieInfo[@""]
    self.TitleLabel.text = self.movieInfo[@"title"];
    self.DescriptionLabel.text = self.movieInfo[@"overview"];
    
    NSString *baseUrRLString = @"https://image.tmdb.org/t/p/w500/";
    NSString *posterURLString = self.movieInfo[@"poster_path"];
    NSString *fullPosterURLString = [baseUrRLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
    self.BigPosterView.image = nil;
    
    [self.BigPosterView setImageWithURL:posterURL];
    
    self.SmallPosterView.image = nil;
    
    [self.SmallPosterView setImageWithURL:posterURL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
