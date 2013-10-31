//
//  ViewController.m
//  StachesAndGlasses
//
//  Created by Yu Yichen on 5/11/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import "ViewController.h"
#import "DoodleView.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <CoreImage/CoreImage.h>
#import <Social/Social.h>


@interface ViewController ()
{
    BOOL isCartoon;
    float TOP;
    float TOPABS;
    float WIDTH;
    float LEFT;
    
    UIImageView *imageView;
    UIView *glassAndStachView;
}

@end

@implementation ViewController
@synthesize picker1;
@synthesize picker2;
@synthesize image;

@synthesize scroll;
@synthesize view1;
@synthesize view2;
@synthesize view3;
@synthesize view4;
@synthesize view5;
@synthesize view6;
@synthesize output2;
@synthesize output3;
@synthesize output4;
@synthesize output5;
@synthesize output6;
@synthesize doodleView;
@synthesize window;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSString *version=[[UIDevice currentDevice] systemVersion];
    
    if (screenBounds.size.height == 568) {
        // code for 4-inch screen
        TOP=40.0;
        WIDTH=320.0;
        LEFT=0.0;
        TOPABS=60.0;
       
    } else {
        // code for 3.5-inch screen
        TOP=30.0;
        WIDTH=280.0;
        LEFT=20.0;
        TOPABS=50.0;
    }
    
    if ([[version substringToIndex:1] isEqualToString:@"7"])
        TOP+=20;
    
    

    imageView= [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP, WIDTH, WIDTH)];
    imageView.image=[UIImage imageNamed:@"big1"];
    [self.view addSubview:imageView];
    
    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(662, 132)];
    
    glassAndStachView=[[UIView alloc] initWithFrame:CGRectMake(LEFT, TOP, WIDTH, WIDTH)];
    [self.view addSubview:glassAndStachView];
   
    doodleView = [[DoodleView alloc] initWithFrame:CGRectMake(LEFT, TOP, WIDTH, WIDTH)];
    [self.view addSubview:self.doodleView];
    
    
   
//    [self.doodleView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    isCartoon=YES;
    
    view1.image=[UIImage imageNamed:@"small1"];
    view2.image=[UIImage imageNamed:@"small2"];
    view3.image=[UIImage imageNamed:@"small3"];
    view4.image=[UIImage imageNamed:@"small4"];
    view5.image=[UIImage imageNamed:@"small5"];
    view6.image=[UIImage imageNamed:@"small6"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    picker1=[[UIImagePickerController alloc]init];
    picker1.delegate=self;
    [picker1 setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker1 animated:YES completion:NULL];
 
    
}

- (IBAction)choosePhoto:(UIButton *)sender {
    picker2=[[UIImagePickerController alloc]init];
    picker2.delegate=self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
}

//UIImagePickerController delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    isCartoon=NO;

    image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    view1.image=image;
    
    CIImage *test=[[CIImage alloc]initWithCGImage:image.CGImage options:nil];
    CIFilter *filter2=[CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, test,@"inputIntensity",@0.8,nil];
    self.output2=[filter2 outputImage];
    UIImage *final2=[UIImage imageWithCIImage:output2 scale:image.scale orientation:image.imageOrientation];
    
    view2.image=final2;
  
    CIFilter *filter3=[CIFilter filterWithName:@"CIColorInvert" keysAndValues:kCIInputImageKey, test,nil];
    self.output3=[filter3 outputImage];
    UIImage *final3=[UIImage imageWithCIImage:output3 scale:image.scale orientation:image.imageOrientation];
    
    view3.image=final3;
    
    CIFilter *filter4=[CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey, test,@"inputRadius",@20.0,nil];
    self.output4=[filter4 outputImage];
    UIImage *final4=[UIImage imageWithCIImage:output4 scale:image.scale orientation:image.imageOrientation];
    
    view4.image=final4;
    
    
   
    CIFilter *filter5=[CIFilter filterWithName:@"CIBloom" keysAndValues:kCIInputImageKey, test, @"inputRadius",@50.0,@"inputIntensity",@5.0,nil];
    self.output5=[filter5 outputImage];
    UIImage *final5=[UIImage imageWithCIImage:output5 scale:image.scale orientation:image.imageOrientation];
    
    view5.image=final5;
    
    
    CIColor *color=[CIColor colorWithRed:1.0 green:0.4 blue:0.4 alpha:1.0];
    CIFilter *filter6=[CIFilter filterWithName:@"CIWhitePointAdjust" keysAndValues:kCIInputImageKey, test, @"inputColor",color,nil];
    self.output6=[filter6 outputImage];
    UIImage *final6=[UIImage imageWithCIImage:output6 scale:image.scale orientation:image.imageOrientation];
    
    view6.image=final6;

    
    
    
    [imageView setImage:image];
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL]; 
}


- (IBAction)tapToChange:(UITapGestureRecognizer *)sender {
    
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if(isCartoon)
        [imageView setImage:[UIImage imageNamed:@"big1"]];
    else
        [imageView setImage:self.image];
    
}

- (IBAction)tapToChange2:(UITapGestureRecognizer *)sender {

    
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    
    if(isCartoon)
        [imageView setImage:[UIImage imageNamed:@"big2"]];
    else
    {
    
    UIImage *final2=[UIImage imageWithCIImage:output2];
    
    [imageView setImage:final2 ];
    }
    
    
}

- (IBAction)tapToChange3:(UITapGestureRecognizer *)sender {
    
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    if(isCartoon)
        [imageView setImage:[UIImage imageNamed:@"big3"]];
    else
    {
        
    UIImage *final3=[UIImage imageWithCIImage:output3];

    [imageView setImage:final3];
    }
}

- (IBAction)tapToChange4:(UITapGestureRecognizer *)sender {
   
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    if(isCartoon)
        [imageView setImage:[UIImage imageNamed:@"big4"]];
    else
    {
        
    UIImage *final4=[UIImage imageWithCIImage:output4];
    
    [imageView setImage:final4];
    }
}

- (IBAction)tapToChange5:(UITapGestureRecognizer *)sender {
   
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    if(isCartoon)
        [imageView setImage:[UIImage imageNamed:@"big5"]];
    else
    {
        
    UIImage *final5=[UIImage imageWithCIImage:output5];
    
    [imageView setImage:final5];
    }
}

- (IBAction)tapToChange6:(UITapGestureRecognizer *)sender {
    
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    if(isCartoon)
        [imageView setImage:[UIImage imageNamed:@"big6"]];
    else
    {
        
    UIImage *final6=[UIImage imageWithCIImage:output6];
    
    [imageView setImage:final6];
    }
}

//make sure the shake motion can be detected
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    //if (motion != UIEventSubtypeMotionShake) return;
//}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //    if ([super respondsToSelector:@selector(motionEnded:withEvent:)])
    //    {
    //        [super motionEnded:motion withEvent:event];
    //    }
    
    
    if (motion == UIEventTypeMotion && event.type == UIEventSubtypeMotionShake) {
        
        NSLog(@"Motion Ended on %@", [NSDate date]);
        
        [self.doodleView clear];
        
        for (UIView *view in glassAndStachView.subviews)
        {
            [view removeFromSuperview];
        }
    }

}
//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//}




- (IBAction)saveButton:(UIButton *)sender {
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CGRect myImageArea = CGRectMake(LEFT, TOPABS, WIDTH, WIDTH);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], myImageArea);
    UIImage *imageInFrame = [UIImage imageWithCGImage:imageRef];
    
    
    UIImageWriteToSavedPhotosAlbum(imageInFrame, nil, nil, nil);
}

- (IBAction)stachesButton:(UIButton *)sender {
    
    [self markFaces:imageView];
//    [self.doodleView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    
}

- (IBAction)saveLocal:(UIButton *)sender {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CGRect myImageArea = CGRectMake(LEFT, TOPABS, WIDTH, WIDTH);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], myImageArea);
    UIImage *imageInFrame = [UIImage imageWithCGImage:imageRef];
    
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *photoArray;
    NSMutableArray *dateArray;
    if ([defaults objectForKey:@"PhotoArray"]==nil)
        photoArray=[[NSMutableArray alloc]init];
    else
        photoArray=[[defaults objectForKey:@"PhotoArray"] mutableCopy];
    
    if ([defaults objectForKey:@"DateArray"]==nil)
        dateArray=[[NSMutableArray alloc]init];
    else
        dateArray=[[defaults objectForKey:@"DateArray"] mutableCopy];
    

    [photoArray addObject:UIImagePNGRepresentation(imageInFrame)];
    [dateArray addObject:[NSDate date]];
    
    [defaults setObject:photoArray forKey:@"PhotoArray"];
    [defaults setObject:dateArray forKey:@"DateArray"];
    [defaults synchronize];

    
        

    
   
}

- (IBAction)uploadButton:(UIButton *)sender {
    
    
    
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sharing options"
                                                    message:@"Choose the platform in which you want to share your image:" delegate:self cancelButtonTitle: @"Cancel"
                                          otherButtonTitles: @"Twitter",@"Facebook",nil];
   
    
    [alert show];
    
    
    
          
    

}

- (IBAction)info:(UIButton *)sender {
    
    [self showActionSheet];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CGRect myImageArea = CGRectMake(LEFT, TOPABS, WIDTH, WIDTH);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], myImageArea);
    UIImage *imageInFrame = [UIImage imageWithCGImage:imageRef];
        
    if (buttonIndex == 1) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *workSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [workSheet addImage:imageInFrame];
            [workSheet setInitialText:@"Photo"];
            
            
            [self presentViewController:workSheet animated:YES completion:nil];

       
        }
        
    }
    
    
    if (buttonIndex == 2) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *workSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [workSheet addImage:imageInFrame];
            [workSheet setInitialText:@"Photo"];
            
            
            [self presentViewController:workSheet animated:YES completion:nil];
            
            
        }
        
    }

    
    
    
}



-(void)markFaces:(UIImageView *)facePicture


{
    
    
    for (UIView *view in glassAndStachView.subviews)
    {
        [view removeFromSuperview];
    }
    
   

    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    CGRect myImageArea = CGRectMake(LEFT, TOPABS, WIDTH, WIDTH);
    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], myImageArea);
    UIImage *tempImage = [UIImage imageWithCGImage:imageRef];
    
    
//    facePicture.image=tempImage;
    
    
    
    // draw a CI image with the previously loaded face detection picture
    CIImage* imageOfFace = [CIImage imageWithCGImage:tempImage.CGImage];
    
    // create a face detector - since speed is not an issue we'll use a high accuracy
    // detector
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    // create an array containing all the detected faces from the detector
    NSArray* features = [detector featuresInImage:imageOfFace];
    
    // we'll iterate through every detected face.  CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected.  Also provided are BOOL's for the eye's and
    // mouth so we can check if they already exist.
    for(CIFaceFeature* faceFeature in features)
    {
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;
        
        // create a UIView using the bounds of the face
        UIView* faceView = [[UIView alloc] initWithFrame:faceFeature.bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        // add the new view to create a box around the face
        
 
        
        
        if(faceFeature.hasLeftEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the leftEyeView based on the face
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            // round the corners
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            // add the view to the window
            
            [glassAndStachView addSubview:leftEyeView];
        }
        
        if(faceFeature.hasRightEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* rightEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [rightEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the rightEyeView based on the face
            [rightEyeView setCenter:faceFeature.rightEyePosition];
            // round the corners
            rightEyeView.layer.cornerRadius = faceWidth*0.15;
            // add the new view to the window
            
            [glassAndStachView addSubview:rightEyeView];
        }
        
               
        if(faceFeature.hasMouthPosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.1, faceFeature.mouthPosition.y-faceWidth*0.4, faceWidth*0.2, faceWidth*0.4)];
          
            [mouth setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];

            
                     

            
            [glassAndStachView addSubview:mouth];
           

        }
    }
 
    [glassAndStachView setTransform:CGAffineTransformMakeScale(1, -1)];
}


-(void)showActionSheet
{
    UIActionSheet *menu=[[UIActionSheet alloc]initWithTitle:@"New:Take a new photo from camera.\nAlbum:Select a photo from album.\nLibrary:Save the image to library.\nHome:Save the image to your homepage.\nYou can draw on top of the image.\nShake your iphone to clear the drawing." delegate:self cancelButtonTitle:@"Thank you" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [menu showInView:self.view];
}








@end
