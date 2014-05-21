//
//  MAPViewController.m
//  Maps
//
//  Created by Jonathan Fox on 5/21/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "MAPViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MAPAnnotation.h"

@interface MAPViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation MAPViewController
{
    CLLocationManager * lmanager;
    MKMapView * myMapView;
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
        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [myMapView removeAnnotations:myMapView.annotations];

    for (CLLocation * location in locations) {
        
        MAPAnnotation * annotation = [[MAPAnnotation alloc]initWithCoordinate:location.coordinate];
        
        annotation.title = @"YOU ARE HERE";
        annotation.subtitle = @"Wahooey!";
        
        [myMapView addAnnotation:annotation];
        
        //[mapView setCenterCoordinate:location.coordinate animated:YES];
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.2, 0.2));  // zooms to 69 X 69 mile perimeter.
        
        [myMapView setRegion:region animated:YES];
        
       // MKAnnotationView * annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        
        [myMapView selectAnnotation:annotation animated:YES];
        
        NSLog(@"%@", location);
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
        
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError * error)
        {
            
            for (CLPlacemark * placemark in placemarks)
            {
                NSLog(@"%@", placemark.addressDictionary);
                
                NSString * cityState = [NSString stringWithFormat:@"%@, %@, %@", placemark.addressDictionary[@"Street"],placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                                        
                    [annotation setTitle:cityState];
                    [annotation setSubtitle:placemark.country];
            }
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myMapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    myMapView.delegate = self;

    [self.view addSubview:myMapView];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
   // MKPinAnnotationView * annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    
    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }else{
        annotationView.annotation = annotation;
    }
                                            
    annotationView.draggable = YES;
    annotationView.canShowCallout = YES;

    //annotationView.image = [UIImage imageNamed:@"smilies1.png"];   // add an image
    
    return annotationView;
}


-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"%@", view.annotation.title);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"new state : %d and old state %d", (int)newState, (int)oldState);
    
    switch ((int)newState)
    {
        case 0: //not dragging
        {
            [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
            
            CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
            
            CLLocation * location = [[CLLocation alloc]initWithLatitude:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
            
            [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError * error) {
                
                for (CLPlacemark * placemark in placemarks)
                {
                    NSLog(@"%@", placemark.addressDictionary);
                    
                    NSString * cityState = [NSString stringWithFormat:@"%@, %@, %@", placemark.addressDictionary[@"Street"],placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                    
                    [(MAPAnnotation *)view.annotation setTitle:cityState];
                    [(MAPAnnotation *)view.annotation setSubtitle:placemark.country];
                }
            }];
        }
            break;
        case 1: //starting drag
            
            break;
        case 2: //dragging
            
            break;
        case 4: //end drag
            
            break;
            
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
