//
//  ZLNewFilesUpLoadService.m
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2018/3/29.
//  Copyright © 2018年 caizilong. All rights reserved.
//

#import "ZLNewFilesUpLoadService.h"
@interface ZLNewFilesUpLoadService (){
    NSArray<ACMediaModel *>  *_imageArray;
    NSString *_name;
    NSData *_data;
    
}

@end
@implementation ZLNewFilesUpLoadService

- (instancetype)initWithImage:(NSArray<ACMediaModel *> *)imageArray{
    self = [super init];
    if (self) {
        _imageArray = imageArray;
    }
    return self;
}

- (NSString *)requestUrl {
    return River_BatchUploadUrl;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}


- (AFConstructingBlock)constructingBodyBlock {
    
    return ^(id<AFMultipartFormData> formData)
    {
        
        for (ACMediaModel *model in _imageArray) {
            NSData *imageDataW = nil;
            
            if (model.asset) {
                if ([self getHEFIWith:model.asset]) {
                    NSArray *nameArray = [model.name componentsSeparatedByString:@"."];
                    model.name = [NSString stringWithFormat:@"%@.jpg",nameArray.firstObject];
                }
                
                imageDataW = UIImageJPEGRepresentation(model.image, 0.8);
                NSData *data = imageDataW;
                NSString *name = model.name;
                NSString *formKey = @"file";
                NSString *type = @"image/jpeg";
                [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
            }
            

        }

    };
}


- (BOOL)getHEFIWith:(PHAsset *)phAsset{
    __block BOOL isHEIF = NO;
    if (isIOS9) {
        
        
        NSArray *resourceList = [PHAssetResource assetResourcesForAsset:phAsset];
        [resourceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAssetResource *resource = obj;
            NSString *UTI = resource.uniformTypeIdentifier;
            if ([UTI isEqualToString:@"public.heif"] || [UTI isEqualToString:@"public.heic"]) {
                isHEIF = YES;
                *stop = YES;
            }
        }];
    } else {
        NSString *UTI = [phAsset valueForKey:@"uniformTypeIdentifier"];
        isHEIF = [UTI isEqualToString:@"public.heif"] || [UTI isEqualToString:@"public.heic"];
    }
    return isHEIF;
}

@end
