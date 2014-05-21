//
//  SFADisplayViewController.m
//  SFASmileyFace
//
//  Created by Jonathan Fox on 5/19/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SFADisplayViewController.h"
#import "SFAData.h"
#import "STTwitter.h"
#import "MAPAnnotation.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SFADisplayViewController () <CLLocationManagerDelegate>

@end

@implementation SFADisplayViewController
{
    int bigSmiliesTag;
    UITextField * tweetField;
    STTwitterAPI * twitter;
    UIButton * twitterButton;
    UIImageView * bigSmileyFrame;
    
    CLLocationManager * lmanager;
    MKMapView * myMapView;
    
    NSString * latitude;
    NSString * longitude;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        lmanager = [[CLLocationManager alloc]init];
        lmanager.delegate = self;
        
        lmanager.distanceFilter = 100;
        lmanager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [lmanager startUpdatingLocation];
        
        twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
        
        
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            
            NSLog(@"%@", username);
            
        } errorBlock:^(NSError *error) {
            
            NSLog(@"%@", error.userInfo);
            
        }];
        
        NSArray * bigSmilies = @[@"yellow1", @"yellow2", @"yellow3", @"yellow4", @"yellow5", @"yellow6", @"yellow7", @"yellow8", @"yellow9"];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        bigSmiliesTag = [SFAData mainData].bigSmiley;

        bigSmileyFrame = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-96, 125, 192, 192)];
        bigSmileyFrame.image = [UIImage imageNamed: bigSmilies[bigSmiliesTag]];
        [self.view addSubview:bigSmileyFrame];
        
        tweetField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 100, 325, 200, 165)];
        tweetField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        tweetField.delegate = self;
        tweetField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [self.view addSubview:tweetField];
        
        twitterButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -88, 64, 48, 48)];
        twitterButton.backgroundColor = [UIColor lightGrayColor];
        [twitterButton addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        [twitterButton setImage:[UIImage imageNamed: @"sm_twitter_g.png"] forState:UIControlStateNormal];
        [twitterButton setImage:[UIImage imageNamed: @"sm_twitter.png"] forState:UIControlStateSelected];
        twitterButton.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:twitterButton];
        
        UIButton * facebook;facebook = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -24, 64, 48, 48)];
        facebook.backgroundColor = [UIColor lightGrayColor];
        [facebook setImage:[UIImage imageNamed: @"sm_facebook_g.png"] forState:UIControlStateNormal];
        [facebook setImage:[UIImage imageNamed: @"sm_facebook.png"] forState:UIControlStateSelected];
        [facebook addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        facebook.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:facebook];
        
        UIButton * google = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+40, 64, 48, 48)];
        google.backgroundColor = [UIColor lightGrayColor];
        [google addTarget:self action:@selector(socialSelector:) forControlEvents:UIControlEventTouchUpInside];
        [google setImage:[UIImage imageNamed: @"sm_google_g.png"] forState:UIControlStateNormal];
        [google setImage:[UIImage imageNamed: @"sm_google.png"] forState:UIControlStateSelected];

        google.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:google];
        
        UIButton * check = [[UIButton alloc]initWithFrame:CGRectMake(128, 500, 64, 40)];
        check.backgroundColor = [UIColor lightGrayColor];
        [check addTarget:self action:@selector(postTweet) forControlEvents:UIControlEventTouchUpInside];
        [check setImage:[UIImage imageNamed: @"check.png"] forState:UIControlStateNormal];
        check.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:check];
        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [myMapView removeAnnotations:myMapView.annotations];
    
    for (CLLocation * location in locations) {
        
        MAPAnnotation * annotation = [[MAPAnnotation alloc]initWithCoordinate:location.coordinate];
        
        [myMapView addAnnotation:annotation];
        
        //[mapView setCenterCoordinate:location.coordinate animated:YES];
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.2, 0.2));  // zooms to 69 X 69 mile perimeter.
        
        [myMapView setRegion:region animated:YES];
        
        // MKAnnotationView * annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        
        [myMapView selectAnnotation:annotation animated:YES];
        
        latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    }
}

-(void)postTweet
{
    if (twitterButton.selected) {
        NSLog(@"I'm On!");
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentPath = paths[0];
        NSData * imageData = UIImagePNGRepresentation(bigSmileyFrame.image);
        NSString* imagePath = [documentPath stringByAppendingPathComponent:@"big_smilie.png"];
        [imageData writeToFile:imagePath atomically:YES];
        NSURL * url = [NSURL fileURLWithPath:imagePath];
        
        NSLog(@"latitude: %@", latitude);
        NSLog(@"longitude %@", longitude);
        
    [twitter postStatusUpdate:tweetField.text inReplyToStatusID:nil mediaURL:url placeID:nil latitude:latitude longitude:longitude uploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        
        NSLog(@"Post Me!");
        NSLog(@"%@", tweetField.text);

        
    } successBlock:^(NSDictionary *status) {
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@", error.userInfo);
    }];
    }
}

-(void)socialSelector:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

-(BOOL)prefersStatusBarHidden{return YES;}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textColor = [UIColor blackColor];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.textColor = [UIColor blackColor];
    textField.placeholder = @"Enter here";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{         // for the return button
    [tweetField resignFirstResponder];
    return YES;
}


@end
