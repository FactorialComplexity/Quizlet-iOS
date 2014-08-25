//
//  QZSetsViewController.m
//  ios_quizlet_client
//
//  Created by Maxim Bilan on 8/21/14.
//  Copyright (c) 2014 Maxim Bilan. All rights reserved.
//

#import "QZSetsViewController.h"
#import "QZExamplesViewController.h"

#import "Quizlet.h"

@interface QZSetsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (weak, nonatomic) IBOutlet UITextField *setIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation QZSetsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.logTextView.text = @"";
    self.hintLabel.text = @"";
    
    switch (self.exampleId) {
        case QZExamplesViewSet:
        case QZExamplesViewSetTerms:
        case QZExamplesDeleteSet:
        {
            self.setIdTextField.hidden = NO;
            self.submitButton.hidden = NO;
        }
        break;
        case QZExamplesSubmitSetPassword:
        {
            self.setIdTextField.hidden = NO;
            self.submitButton.hidden = NO;
            self.passwordTextField.hidden = NO;
        }
        break;
        
        case QZExamplesViewSets:
        {
            self.setIdTextField.hidden = NO;
            self.submitButton.hidden = NO;
            self.hintLabel.hidden = NO;
            self.hintLabel.text = @"Set ids separated by commas";
        }
        break;
        case QZExamplesAddSet:
        {
            NSDictionary *dict = @{
                                   @"title": @"set4",
                                   @"terms": @[@"yyyyy", @"ttttt", @"kkkkk"],
                                   @"definitions" : @[@"yy", @"tt", @"kk"],
                                   @"lang_terms" : @"en",
                                   @"lang_definitions" : @"en",
                                   @"description" : @"set3",
                                   @"allow_discussion" : @"true",
                                   @"visibility" : @"public",
                                   @"editable" : @"only_me"
                                   };
            [[Quizlet sharedQuizlet] addSetFromDictionary:dict success:^(id responseObject) {
                self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
            } failure:^(NSError *error) {
                self.logTextView.text = [error description];
            }];
        }
        break;
        case QZExamplesEditSet:
        {
            NSDictionary *dict = @{
                                   @"title": @"set4",
                                   @"terms": @[@"yyyyy1", @"ttttt1", @"kkkkk1"],
                                   @"definitions" : @[@"yy1", @"tt1", @"kk1"],
                                   @"lang_terms" : @"en",
                                   @"lang_definitions" : @"en",
                                   @"description" : @"set3",
                                   @"allow_discussion" : @"true",
                                   @"visibility" : @"public",
                                   @"editable" : @"only_me"
                                   };
            
            [[Quizlet sharedQuizlet] editSetWithDictionary:dict bySetId:@"46368667" success:^(id responseObject) {
                self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
            } failure:^(NSError *error) {
                self.logTextView.text = [error description];
            }];
        }
        break;
        case QZExamplesAddTermToSet:
        {
            NSDictionary *term = @{
                                   @"term" : @"mmmmmm",
                                   @"definition" : @"mmm"
                                   };
            [[Quizlet sharedQuizlet] addTermFromDictionary:term toSetBySetId:@"46367827" success:^(id responseObject) {
                self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
            } failure:^(NSError *error) {
                self.logTextView.text = [error description];
            }];
        }
        break;
        case QZExamplesEditTermFromSet:
        {
            NSDictionary *term = @{
                                   @"term" : @"lmlmlmlmlml",
                                   @"definition" : @"lmlm"
                                   };
            [[Quizlet sharedQuizlet] editTermWithDictionary:term fromSetBySetId:@"46367827" byTermId:@"1617289394" success:^(id responseObject) {
                self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
            } failure:^(NSError *error) {
                self.logTextView.text = [error description];
            }];
        }
        break;
        case QZExamplesDeleteTermFromSet:
        {
            [[Quizlet sharedQuizlet] deleteTermFromSetBySetId:@"46367827" byTermId:@"1617289394" success:^(id responseObject) {
                self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
            } failure:^(NSError *error) {
                self.logTextView.text = [error description];
            }];
        }
        break;
            
        default:
            break;
    }
}

- (IBAction)submitButtonAction:(UIButton *)sender
{
    [self.setIdTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    if (self.setIdTextField.text.length > 0) {
        switch (self.exampleId) {
            case QZExamplesViewSet:
            {
                [[Quizlet sharedQuizlet] viewSetBySetId:self.setIdTextField.text success:^(id responseObject) {
                    self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
                } failure:^(NSError *error) {
                    self.logTextView.text = [error description];
                }];
            }
            break;
            
            case QZExamplesViewSetTerms:
            {
                [[Quizlet sharedQuizlet] viewSetTermsBySetId:self.setIdTextField.text success:^(id responseObject) {
                    self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
                } failure:^(NSError *error) {
                    self.logTextView.text = [error description];
                }];
            }
            break;
                
            case QZExamplesSubmitSetPassword:
            {
                [[Quizlet sharedQuizlet] submitPassword:self.passwordTextField.text forSetBySetId:self.setIdTextField.text success:^(id responseObject) {
                    self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
                } failure:^(NSError *error) {
                    self.logTextView.text = [error description];
                }];
            }
            break;
                
            case QZExamplesViewSets:
            {
                [[Quizlet sharedQuizlet] viewSetsBySetIds:self.setIdTextField.text success:^(id responseObject) {
                    self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
                } failure:^(NSError *error) {
                    self.logTextView.text = [error description];
                }];
            }
            break;
                
            case QZExamplesDeleteSet:
            {
                [[Quizlet sharedQuizlet] deleteSetBySetId:self.setIdTextField.text success:^(id responseObject) {
                    self.logTextView.text = [NSString stringWithFormat:@"%@", responseObject];
                } failure:^(NSError *error) {
                    self.logTextView.text = [error description];
                }];
            }
            break;
                
            default:
                break;
        }
        
        self.setIdTextField.hidden = YES;
        self.submitButton.hidden = YES;
        self.passwordTextField.hidden = YES;
        self.hintLabel.hidden = YES;
    }
}

@end
