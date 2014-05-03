//
//  LPSFilterController.m
//  LibraryPhotoDisplayer
//
//  Created by Jonathan Fox on 5/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "LPDFilterController.h"

@interface LPDFilterController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation LPDFilterController
{
    UIScrollView * scrollView;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
    
    float wh;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        scrollView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
//        scrollView.contentSize = CGSizeMake((90*21), 100);
//        scrollView.scrollEnabled = YES;
//        
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];

        
        filterButtons = [@[] mutableCopy];
        filterNames = @[
                        @"CIColorInvert",
                        @"CIColorMonochrome",
                        @"CIColorPosterize",
                        @"CIFalseColor",
                        @"CIMaximumComponent",
                        @"CIMinimumComponent",
                        @"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade",
                        @"CIPhotoEffectInstant",
                        @"CIPhotoEffectMono",
                        @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess",
                        @"CIPhotoEffectTonal",
                        @"CIPhotoEffectTransfer",
                        @"CISepiaTone",
                        @"CIVignette"
                        ];
        
        scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:scrollView];
  
        
        // Use this to log the attributes of a filter
//        CIFilter *myFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
//        NSDictionary *myFilterAttributes = [myFilter attributes];
//        
//        NSLog(@"%@", myFilterAttributes);
    
    }
    return self;
}


// make the filter buttons

- (void)viewWillLayoutSubviews
{
    wh = self.view.frame.size.height - 20;
    
    for (NSString * filterName in filterNames)
    {
        int i = (int)[filterNames indexOfObject:filterName];
        int x = (wh + 10) * i + 10;
        
        UIButton * filterButton = [[UIButton alloc]initWithFrame:CGRectMake(x, 10, wh, wh)];
        filterButton.tag = i;
        filterButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
        
        [filterButtons addObject:filterButton];
        
        [scrollView addSubview:filterButton];
    }
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    scrollView.contentSize = CGSizeMake((wh + 10) * [filterNames count] + 10, self.view.frame.size.height);
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
{
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
    //    CIImage *image = [CIImage imageWithContentsOfURL:myURL];               // 2

    CIFilter * filter = [CIFilter filterWithName:filterName];
    //    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];           // 3

    
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    //    [filter setValue:image forKey:kCIInputImageKey];
    //    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    //    CIContext *context = [CIContext contextWithOptions:nil];               // 1

    
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
    //    CIImage *result = [filter valueForKey:kCIOutputImageKey];


    //    CGRect extent = [result extent];
//    CGImageRef cgImage = [context createCGImage:result fromRect:extent];  // 4 all these in below
//    return uiImage;
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}


-(void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
    
    for (UIButton *filterButton in filterButtons)
    {
        
        [filterButton setImage:nil forState:UIControlStateNormal];

        NSString * filterName = [filterNames objectAtIndex:filterButton.tag];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{
            
            UIImage * smallImage = [self shrinkImage:imageToFilter maxWH:wh];
            UIImage * image = [self filterImage:smallImage filterName:filterName];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                [filterButton setImage:image forState:UIControlStateNormal];
                filterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            });
        });
    }
}

-(void)switchFilter:(UIButton *)filterButton
{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    //UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    //[self.delegate updateCurrentImageWithFilteredImage:image];
    //[UIImage imageWithCGImage:[self filterImage:[self shrinkImage:self.imageFilter maxWH:SCREEN_WIDTH * 2] filterName:self.currentFilter];
    

    // Shrink the image to make it smaller, so it doesn't take long to process
    UIImage * shrinkedImage = [self shrinkImage:self.imageToFilter maxWH:SCREEN_WIDTH];
   
    // Now we need to apply filter to our shrinked image
    UIImage * filteredImage = [self filterImage:shrinkedImage filterName:self.currentFilter];
    
    // Now put our filtered image in our root VC :)
    [self.delegate updateCurrentImageWithFilteredImage:filteredImage];
     
}

-(UIImage *)shrinkImage:(UIImage *)image maxWH:(int)widthHeight
{
    CGSize size = CGSizeMake(widthHeight, widthHeight / image.size.width * image.size.height);
    
    if(image.size.height < image.size.width)
    {
        size = CGSizeMake(widthHeight / image.size.height * image.size.width, widthHeight);
    }
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect: CGRectMake(0, 0, size.width, size.height)];
    
    UIImage * destImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return destImage;
}

    
    // Do any additional setup after loading the view.
    
    
    
    //    CIContext *context = [CIContext contextWithOptions:nil];              // 1
    //    CIImage *image = [CIImage imageWithContentsOfURL:myURL];              // 2
    //    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];          // 3
    //    [filter setValue:image forKey:kCIInputImageKey];
    //    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    //    CIImage *result = [filter valueForKey:kCIOutputImageKey];              // 4
    //    CGRect extent = [result extent];
    //    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    
//    }



//-(void)createSquares
//{
//    for (int s = 0; s <= 20; s++)
//    {
//        float squareX = ((90) * s);
//        
//        UIButton * square = [[UIButton alloc]initWithFrame:CGRectMake(squareX, 10, 80, 80)];
//        // [addPhotoButton addTarget:self action:@selector(openFilter) forControlEvents:UIControlEventTouchUpInside]
//        
//        square.backgroundColor = [UIColor whiteColor];
//        
//        [scrollView addSubview:square];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)prefersStatusBarHidden {return YES;}

@end
