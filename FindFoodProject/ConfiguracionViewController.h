//
//  ConfiguracionViewController.h
//  FindFood
//
//  Created by Ariana Cisneros on 01/12/14.
//  Copyright (c) 2014 Steve Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface ConfiguracionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)guardarDistancia:(id)sender;
@property (strong,nonatomic) Singleton *objetoSingleton;

@end
