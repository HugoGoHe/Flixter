//
//  MovieViewController.m
//  Flixter
//
//  Created by Hugo Gomez Herrera on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *movies;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
    
}

-(void)fetchMovies{
    [self.activityIndicator startAnimating];
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
               
               [self.tableView reloadData];
               // TODO: Store the movies in a property to use elsewhere
               
               // TODO: Reload your table view data
               
           }
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
       }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
  //  cell.textLabel.text = movie[@"title"];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    NSString *baseUrRLString = @"https://image.tmdb.org/t/p/w500/";
    NSString *posterURLString = movie[@"poster_path"];
    //NSLog(posterURLString);
    NSString *fullPosterURLString = [baseUrRLString stringByAppendingString:posterURLString];
    //NSLog(fullPosterURLString);
    NSURL *posterURL = [NSURL URLWithString: fullPosterURLString];
    cell.posterView.image = nil;
    
    [cell.posterView setImageWithURL:posterURL];
    return cell;
}

#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
    //you'll need to have gotten an index with indexPathForCell
    NSDictionary *dataToPass = self.movies[myIndexPath.row];
    DetailsViewController *detailVC  = [segue destinationViewController];
    detailVC.movieInfo = dataToPass;
    // Pass the selected object to the new view controller.
}

@end
