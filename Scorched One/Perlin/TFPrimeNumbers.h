//
//  TFPrimeNumbers.h
//  TerrainFormer
//
//  Created by Peter Hood on 6/30/13.
//  Copyright (c) 2013 Hood, Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFPrimeNumbers : NSObject

+ (NSUInteger)generateFiveDigitPrime;
+ (NSUInteger)generateTenDigitPrime;

+ (NSUInteger)totalFiveDigitPrimes;
+ (NSUInteger)totalTenDigitPrimes;

@end
