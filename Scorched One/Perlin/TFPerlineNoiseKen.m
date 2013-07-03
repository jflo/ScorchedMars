//
//  TFPerlineNoiseKen.m
//  TerrainFormer
//
//  Created by Peter Hood on 6/29/13.
//  Copyright (c) 2013 Hood, Peter. All rights reserved.
//
//  http://freespace.virgin.net/hugo.elias/models/m_perlin.htm

#import "TFPerlineNoiseKen.h"
#import "TFPrimeNumbers.h"

typedef NS_ENUM(NSInteger, TFInterpolationMode)
{
    TFInterpolationModeLinear = 0,
    TFInterpolationModeCosine,
    TFInterpolationModeCubic
};


@interface TFPerlineNoiseKen()
{
    NSMutableArray *_primeNumbers;
    NSInteger _currentOctave;
}

@end

@implementation TFPerlineNoiseKen

- (id)init
{
    self = [super init];
    if(self)
    {
        _totalOctaves = 1;
        _persistence = .5;
        
        [self generatePrimeNumbers];

        _currentOctave = 0;
    }
    
    return self;
}


- (void)setTotalOctaves:(NSUInteger)totalOctaves
{
    _totalOctaves = totalOctaves;
    [self generatePrimeNumbers];
}

- (void)generatePrimeNumbers
{
    _primeNumbers = [[NSMutableArray alloc] init];
    for(int i=0; i < _totalOctaves; ++i)
    {
        NSArray *primes = [[NSArray alloc] initWithObjects:[NSNumber numberWithUnsignedInteger:[TFPrimeNumbers generateFiveDigitPrime]],
                           [NSNumber numberWithUnsignedInteger:[TFPrimeNumbers generateFiveDigitPrime]],
                           [NSNumber numberWithUnsignedInteger:[TFPrimeNumbers generateTenDigitPrime]],
                           [NSNumber numberWithUnsignedInteger:[TFPrimeNumbers generateTenDigitPrime]],
                           nil];
        [_primeNumbers addObject:primes];
    }
}


- (float)perlinNoiseWithNumber:(float)x
{
    float total = 0;
    for(_currentOctave = 0; _currentOctave < _totalOctaves; ++_currentOctave)
    {
        float frequency = pow(2, _currentOctave);
        float amplitude = pow(_persistence, _currentOctave);
        
        total += [self interpolateNoiseWithNumber:x*frequency] * amplitude;
    }
    
    return total;
}

- (float)interpolateNoiseWithNumber:(float)x
{
    int xInt = (int)x;
    float xFraction = x - xInt;
    float v1 = [self smoothedNoiseWithNumber:xInt];
    float v2 = [self smoothedNoiseWithNumber:xInt+1];
    
//    NSLog(@" ** x=%d, x+1=%d", xInt, xInt+1);
//    NSLog(@" ** v1=%f, v2=%f", v1, v2);
    
    return [self interpolateWithA:v1 withB:v2 withX:xFraction withMode:TFInterpolationModeCosine];
}


- (float)smoothedNoiseWithNumber:(float)x
{
    return [self noiseWithNumber:x]/2 + [self noiseWithNumber:x-1]/4 + [self noiseWithNumber:x+1]/4;
}

- (float)noiseWithNumber:(int)x
{
    NSArray *primes = _primeNumbers[_currentOctave];
    int prime0 = [((NSNumber*)primes[0]) intValue];
    int prime1 = [((NSNumber*)primes[1]) intValue];
    int prime2 = [((NSNumber*)primes[2]) intValue];
    float prime3 = [((NSNumber*)primes[3]) floatValue];

    x = (x<<13) ^ x;
    return ( 1.0 - ( (x * (x * x * prime0 + prime1) + prime2) & 0x7fffffff) / prime3);
}


- (float)interpolateWithA:(float)a withB:(float)b withX:(float)x withMode:(TFInterpolationMode)mode
{
    if(mode == TFInterpolationModeLinear)
    {
        return a*(1-x) + b*x;
    }
    else if(mode == TFInterpolationModeCosine)
    {
        float ft = x * M_PI;
        float f = (1 - cos(ft)) * .5;
        
        return  a*(1-f) + b*f;
    }
    
    return 0;
}


@end
