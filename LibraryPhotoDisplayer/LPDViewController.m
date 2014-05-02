//
//  LPSViewController.m
//  LibraryPhotoDisplayer
//
//  Created by Jonathan Fox on 4/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "LPDViewController.h"
#import "LPDFilterController.h"
#import "LPDBlurVC.h"


@interface LPDViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, LPDFilterControllerDelegate, BlurViewControllerDelegate>

@property (nonatomic)UIImage * originalImage;

@end

@implementation LPDViewController
{
    UIImageView * imageView;
    LPDFilterController * filterVC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        header.backgroundColor = [UIColor blueColor];
        [self.view addSubview:header];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 420)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        [self.view addSubview:imageView];
        
        UIButton * addPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 100, 30)];
        [addPhotoButton setTitle:@"Add Photo" forState:UIControlStateNormal];
        [addPhotoButton addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
        addPhotoButton.backgroundColor = [UIColor darkGrayColor];
        addPhotoButton.layer.cornerRadius = 6;
        
        [header addSubview:addPhotoButton];
        
        UIView * frame = [[UIView alloc]initWithFrame:CGRectMake(0, 335, SCREEN_WIDTH, 40)];
        frame.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        
        [self.view addSubview:frame];
        
        filterVC = [[LPDFilterController alloc]initWithNibName:nil bundle:nil];
        filterVC.delegate =self;
        filterVC.view.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
        [self.view addSubview:filterVC.view];
    }
    return self;

}

-(void)updateCurrentImageWithFilteredImage:(UIImage *)image
{
    imageView.image = image;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPhoto
{
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)setOriginalImage:(UIImage *)originalImage
{
    _originalImage = originalImage;
    
    filterVC.imageToFilter = originalImage;
    imageView.image = originalImage;
    
}

-(BOOL)prefersStatusBarHidden {return YES;}


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
