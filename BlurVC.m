//
//  BlurVC.m
//  
//
//  Created by Jonathan Fox on 5/2/14.
//
//

#import "BlurVC.h"

@interface BlurVC ()

@end

@implementation BlurVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 25, 250, 50)];
    
    slider.minimumValue = 0.0;
    slider.maximumValue = 20.0;
    slider.value = 10;
    
    [slider addTarget:self action:@selector(blurToggle) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
    
    
    UISwitch * toggleSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(280, 25, 20, 50)];
    [toggleSwitch addTarget:self action:@selector(blurToggle) forControlEvents:UIControlEventTouchUpInside];
    
    toggleSwitch.onTintColor = [UIColor blueColor];
    
    [self.view addSubview:toggleSwitch];
}

- (void)blurToggle{
{
    toggleSwitch.on = YES;
    
        if (toggleSwitch.on = YES)
            
        {
            self.currentFilter = @"CIBoxBlur";
            [filter setValue:@(slideValue) forKeyPath:kCIInputImageKey];

        }else{
            self.currentFilter = @"CIGaussianBlur"
            [filter setValue:@(slideValue) forKeyPath:kCIInputImageKey];
        }
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
}
    
    
-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
    {
        float slideValue = slider.value;
        
        CIImage * CiImage = [CIImage imageWithCGImage:image.CGImage];
        
        CIFilter * filter = [CIFilter filterWithName:filterName];
        [filter setValue:@(slideValue) forKeyPath:kCIInputImageKey];
        
        CIContext * ciContext = [CIContext contextWithOptions:nil];
        CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
        
        return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
    }
    
-(void)setImageToFilter:(UIImage *)imageToFilter
    {
        _imageToFilter = imageToFilter;
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
