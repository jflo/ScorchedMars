//
//  TFPerlineNoiseKen.h
//  TerrainFormer
//
//  Created by Peter Hood on 6/29/13.
//  Copyright (c) 2013 Hood, Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFPerlineNoiseKen : NSObject


- (float)perlinNoiseWithNumber:(float)x;

@property (nonatomic, assign) NSUInteger totalOctaves;
@property (nonatomic, assign) float persistence;

@end
