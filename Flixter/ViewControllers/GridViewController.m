//
//  GridViewController.m
//  Flixter
//
//  Created by Hugo Gomez Herrera on 6/17/22.
//

#import "GridViewController.h"
#import "MovieCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"


@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *movies;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flow;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation GridViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // Do any additional setup after loading the view.
    
    [self fetchMovies];
}

-(void)fetchMovies{
    //1.Create URL
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=be8ebdc33fc75796144aeb3d56c7d1f8"];
    
    //2.Create Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    //3.Create Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    //4.Create our session task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                              message:@"The internet connection appears to be offline."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                  handler:^(UIAlertAction * action) {}];
                
               [alert addAction:defaultAction];
               [self presentViewController:alert animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
              // NSLog(@"%@", dataDictionary);
               

               // TODO: Get the array of movies
               self.movies= dataDictionary[@"results"];
               for (NSDictionary *movie in self.movies) {
                   NSLog(@"%@", movie[@"title"]);
               }
               
               [self.collectionView reloadData];
               // TODO: Store the movies in a property to use elsewhere
               
               // TODO: Reload your table view data
               
           }

       }];
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Movie Collection Cell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.row];
  //  cell.textLabel.text = movie[@"title"];
 
    NSString *baseUrRLString = @"https://image.tmdb.org/t/p/w500/";
    NSString *posterURLString = movie[@"poster_path"];
    //NSLog(posterURLString);
    NSString *fullPosterURLString = [baseUrRLString stringByAppendingString:posterURLString];
    //NSLog(fullPosterURLString);
    NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
    cell.poster.image = nil;
    
    [cell.poster setImageWithURL:posterURL];
    return cell;
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
