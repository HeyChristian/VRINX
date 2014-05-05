//
//  LoginViewController.m
//  VRINX
//
//  Created by Christian Vazquez on 5/4/14.
//  Copyright (c) 2014 Christian Vazquez. All rights reserved.
//

#import "LoginViewController.h"
#import  <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated   {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
}


- (IBAction)login:(id)sender {
    
    
    
    
    
    NSString *username = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password =[self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if( [username length] == 0 || [password length] ==0 ){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you enter a username and password!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }else{
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user,NSError *error) {
            
            
            if(error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
                
               // [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
            
            
            
        }];
        
        
    }

    
    
}
@end
