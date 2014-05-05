//
//  SignupViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>


@interface SignupViewController ()

@end

@implementation SignupViewController



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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SignUp:(id)sender {
    
    
    NSString *username = [self.emailAddressField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password =[self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *repassword = [self.rePasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
   
    if( [username length] == 0 || [password length] ==0 || [repassword length] ==0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a email and password!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alertView show];
    }else {
        
        if(![password isEqualToString:repassword]){
            
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                                    message:@"The Password does match!"
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            
            
        }else{
        
        
        
        
            PFUser *newUser = [PFUser user];
            newUser.username=username;
            newUser.password=password;
            newUser.email=username;
            [newUser addObject:nil forKey:@"FirstName"];
            [newUser addObject:nil forKey:@"LastName"];
            [newUser addObject:nil forKey:@"Mobile"];
            [newUser addObject:nil forKey:@"ProfilePicture"];
            
            
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded,NSError *error){
                
                
                if(error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                        message:[error.userInfo objectForKey:@"error"]
                                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    
                }else{
                    //Continue for Registration
                    //[self dismissViewControllerAnimated:YES completion:nil];
                    [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:YES completion:nil];
                   // [self performSegueWithIdentifier:@"continue" sender:self];
                }
                
                
            }];
        }
        
    }
}

    
- (IBAction)Close:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    
}


@end
