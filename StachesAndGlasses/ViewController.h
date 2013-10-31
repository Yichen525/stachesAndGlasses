//
//  ViewController.h
//  StachesAndGlasses
//
//  Created by Yu Yichen on 5/11/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoodleView.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property    UIImagePickerController *picker1;
@property    UIImagePickerController *picker2;
@property    UIImage *image;

- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)choosePhoto:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *view6;
@property (weak, nonatomic) IBOutlet UIImageView *view5;
@property (weak, nonatomic) IBOutlet UIImageView *view4;
@property (weak, nonatomic) IBOutlet UIImageView *view3;
@property (weak, nonatomic) IBOutlet UIImageView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *view1;
- (IBAction)tapToChange:(UITapGestureRecognizer *)sender;
- (IBAction)tapToChange2:(UITapGestureRecognizer *)sender;
- (IBAction)tapToChange3:(UITapGestureRecognizer *)sender;
- (IBAction)tapToChange4:(UITapGestureRecognizer *)sender;
- (IBAction)tapToChange5:(UITapGestureRecognizer *)sender;
- (IBAction)tapToChange6:(UITapGestureRecognizer *)sender;

@property DoodleView *doodleView;


@property CIImage *output2;
@property CIImage *output3;
@property CIImage *output4;
@property CIImage *output5;
@property CIImage *output6;
- (IBAction)saveButton:(UIButton *)sender;
- (IBAction)stachesButton:(UIButton *)sender;
- (IBAction)saveLocal:(UIButton *)sender;
- (IBAction)uploadButton:(UIButton *)sender;
- (IBAction)info:(UIButton *)sender;

@property UIWindow *window;


    



@end
