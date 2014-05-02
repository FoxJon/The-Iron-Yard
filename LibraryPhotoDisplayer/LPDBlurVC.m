//
//  BlurVC.m
//  
//
//  Created by Jonathan Fox on 5/2/14.
//
//

#import "LPDBlurVC.h"

@interface LPDBlurVC ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation LPDBlurVC
{
    UISwitch * toggleSwitch;
    UISlider * slider;
}


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
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 25, 250, 50)];
    
    slider.minimumValue = 0.0;
    slider.maximumValue = 20.0;
    slider.value = 10;
    
    [slider addTarget:self action:@selector(blurToggle) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
    
    
    toggleSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(280, 25, 20, 50)];
    toggleSwitch.on = YES;
    [toggleSwitch addTarget:self action:@selector(blurToggle) forControlEvents:UIControlEventTouchUpInside];
    
    toggleSwitch.onTintColor = [UIColor blueColor];
    
    [self.view addSubview:toggleSwitch];
}

- (void)blurToggle
{
    if (toggleSwitch.on == YES)
    
        {
            self.currentFilter = @"CIBoxBlur";

        }else{
            self.currentFilter = @"CIGaussianBlur";
        }
    
    UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    
    [self.delegate updateCurrentImageWithFilteredImage:image];
}
    
    
-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
    {
        float slideValue = slider.value;
        
        CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
        
        CIFilter * filter = [CIFilter filterWithName:filterName];
        
        [filter setValue:ciImage forKey:kCIInputImageKey];
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
