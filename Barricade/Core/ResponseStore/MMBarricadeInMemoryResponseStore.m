//
//  MMBarricadeInMemoryResponseStore.m
//
// Copyright (c) 2015 Mutual Mobile (http://www.mutualmobile.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MMBarricadeInMemoryResponseStore.h"


@interface MMBarricadeInMemoryResponseStore ()

@property (nonatomic, strong) NSMutableDictionary *currentResponseForSet;

@end


@implementation MMBarricadeInMemoryResponseStore

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentResponseForSet = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id<MMBarricadeResponse>)currentResponseForResponseSet:(MMBarricadeResponseSet *)responseSet {
    id<MMBarricadeResponse> response = self.currentResponseForSet[responseSet.requestName];
    if (response == nil) {
        response = responseSet.defaultResponse;
    }
    return response;
}

- (void)resetResponseSelections {
    [self.currentResponseForSet removeAllObjects];
}

- (void)selectCurrentResponseForResponseSet:(MMBarricadeResponseSet *)responseSet
                                   withName:(NSString *)name {
    
    id<MMBarricadeResponse> response = [responseSet responseWithName:name];
    if (response) {
        self.currentResponseForSet[responseSet.requestName] = response;
    }
}

@end
