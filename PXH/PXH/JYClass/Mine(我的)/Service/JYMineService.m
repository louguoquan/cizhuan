//
//  JYMineService.m
//  PXH
//
//  Created by LX on 2018/6/1.
//  Copyright © 2018年 ShengDai. All rights reserved.
//

#import "JYMineService.h"


static NSString *JYUploadImage_URL  = @"/imgae/upload/saveImages";

static NSString *JYGetReceivableAddressList_URL = @"/bank/address/getBankList";

static NSString *JYAddReceivableAddress_URL = @"/bank/address/saveBankCard";

static NSString *JYDelReceivableAddress_URL = @"/bank/address/delBank";

static NSString *JYCoinInfoCoinDesc = @"/coin/info/coinDesc";

static NSString *JYAddressList = @"/coin/address/getAddress";

static NSString *JYDelAddress = @"/coin/address/delAddress";

static NSString *JYSaveAddress = @"/coin/address/saveAddress";

static NSString *JYUserInfoStatus = @"/mobile/user/getUserInfoStatus";

static NSString *JYBindMobile = @"/mobile/user/bindMobile";

static NSString *JYBindEmail = @"/mobile/user/bindMail";

static NSString *JYCountryList = @"/countryListNoSort";

static NSString *JYUserAuthentication = @"/mobile/user/userAuthentication";

static NSString *JYCmsIndexList = @"/mobile/cms/cmsIndex";

static NSString *JYSmsContent = @"/mobile/cms/cmsContent";

static NSString *JYMyProfit = @"/mobile/user/myProfit";

static NSString *JYRecList = @"/mobile/user/recList";

static NSString *JYMyInviting = @"/mobile/user/myInviting";

static NSString *JYSetDefaultBankCard = @"/bank/address/setDefault";
static NSString *JYRevenueRanking = @"/mobile/user/revenueRanking";





@implementation JYMineService


+ (void)setUpLoginPassWord:(NSString *)payPassword
                    mobile:(NSString *)mobile
                 checkCode:(NSString *)checkCode
                completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"payPassword"] = [payPassword md5String];//
    parameters[@"mobile"] = mobile;
    parameters[@"checkCode"] = checkCode;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:JYSetUpLoginPassWord_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)setUpPayPassWord:(NSString *)payPassword
                  mobile:(NSString *)mobile
               checkCode:(NSString *)checkCode
              completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"payPassword"] = [payPassword md5String];//
    parameters[@"mobile"] = mobile;
    parameters[@"checkCode"] = checkCode;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:JYSetUpPayPassWord_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)uploadImage:(id)images
         completion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] POST:JYUploadImage_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        if ([images isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)images;
            for (int i = 0; i < arr.count; i++) {
                //获取当前时间戳
                NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval imageName = [date timeIntervalSince1970]*1000;
                
                UIImage *image = arr[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                NSString *fileName = [NSString stringWithFormat:@"%.f.jpg", imageName];
                
                [formData appendPartWithFileData:imageData
                                            name:@"images"//接口参数名称
                                        fileName:fileName
                                        mimeType:@"image/jpeg"];
            }
        }
        else {
            //获取当前时间戳
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval imageName = [date timeIntervalSince1970]*1000;
            
            NSData *imageData = UIImagePNGRepresentation(images);
            NSString *fileName = [NSString stringWithFormat:@"%f.png", imageName];
            
            [formData appendPartWithFileData:imageData
                                        name:@"images"
                                    fileName:fileName
                                    mimeType:@"image/png"];
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
            NSArray *imgArr = [JYImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            !completion?:completion(imgArr, nil);
        }
        else{
            NSArray *imgArr = @[[JYImageModel mj_objectWithKeyValues:responseObject[@"result"]]];
            !completion?:completion(imgArr, nil);
        }
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)getReceivableAddressListCompletion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:JYGetReceivableAddressList_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [JYGatherAddModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        !completion?:completion(arr, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
       [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)addReceivableAddressName:(NSString *)name
                        openBank:(NSString *)openBank
                     bankAddress:(NSString *)bankAddress
                         cardNum:(NSString *)cardNum
                      completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"name"] = name;
    parameters[@"openBank"] = openBank;
    parameters[@"bankAddress"] = bankAddress;
    parameters[@"cardNum"] = cardNum;
    
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:JYAddReceivableAddress_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)delReceivableAddressID:(NSString *)Id
                    Completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"id"] = Id;
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] POST:JYDelReceivableAddress_URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
         [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)coinInfoCoinDesc:(NSDictionary *)parameters page:(NSInteger)page completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    parameter[@"pageSize"] = @(10);
    [[SDDispatchingCenter sharedCenter].networkManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[JYAccountModel sharedAccount].token] forHTTPHeaderField:@"Authorization"];
    [[SDDispatchingCenter sharedCenter] GET:JYCoinInfoCoinDesc parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [JYMarketModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(array, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)coinAddressListCoinId:(NSString *)coinId page:(NSInteger)page completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:3];
    parameter[@"coinId"] = coinId;
//    parameter[@"page"] = @(page);
//    parameter[@"pageSize"] = @(10);
    
    [[SDDispatchingCenter sharedCenter] GET:JYAddressList parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = [JYPresentAddModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(arr, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)delCoinAddressId:(NSString *)addressId completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:1];
    parameter[@"addressId"] = addressId;
    
    [[SDDispatchingCenter sharedCenter] POST:JYDelAddress parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

+ (void)saveCoinAddressId:(NSString *)Id address:(NSString *)address remark:(NSString *)remark completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:3];
    parameter[@"id"] = Id;
    parameter[@"address"] = address;
    parameter[@"remark"] = remark;
    
    [[SDDispatchingCenter sharedCenter] GET:JYSaveAddress parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)getUserInfoStatusCompletion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] POST:JYUserInfoStatus parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject[@"result"];
        
        JYAccountModel *account = [JYAccountModel sharedAccount];
        account.isMobile        = dic[@"mobile"];
        account.isCertified     = dic[@"certified"];
        account.isPayPassword   = dic[@"payPassword"];
        account.isEmail         = dic[@"email"];
        [JYAccountModel saveAccount:account];
        
        !completion?:completion(dic, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)bindMobile:(NSString *)mobile checkCode:(NSString *)checkCode completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:2];
    parameter[@"mobile"] = mobile;
    parameter[@"checkCode"] = checkCode;
    
    [[SDDispatchingCenter sharedCenter] POST:JYBindMobile parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)bindEmail:(NSString *)mail checkCode:(NSString *)checkCode completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:2];
    parameter[@"mail"] = mail;
    parameter[@"checkCode"] = checkCode;
    
    [[SDDispatchingCenter sharedCenter] POST:JYBindEmail parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)getCountryListCompletion:(YSCompleteHandler)completion
{
    [[SDDispatchingCenter sharedCenter] GET:JYCountryList parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *arr = responseObject[@"result"];
        NSMutableDictionary *countryInfoMuDic = [NSMutableDictionary dictionary];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *firstLetter = [dic[@"firstletter"] capitalizedString];
            if ([countryInfoMuDic.allKeys containsObject:firstLetter]) {
                NSMutableArray *countryArr = countryInfoMuDic[firstLetter];
                [countryArr addObject:obj];
            }
            else {
                NSMutableArray *countryMuArr = [NSMutableArray array];
                [countryMuArr addObject:obj];
                [countryInfoMuDic setValue:countryMuArr forKey:firstLetter];
            }
        }];
        
        !completion?:completion(countryInfoMuDic, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)userAuthenticationWithProviceId:(NSString *)proviceId
                                   type:(NSString *)type
                                   name:(NSString *)name
                               idNumber:(NSString *)idNumber
                          certificatesA:(NSString *)certificatesA
                          certificatesB:(NSString *)certificatesB
                         certificatesAB:(NSString *)certificatesAB
                             completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:7];
    parameter[@"proviceId"] = proviceId;
    parameter[@"type"] = type;
    parameter[@"name"] = name;
    parameter[@"idNumber"] = idNumber;
    parameter[@"certificatesA"] = certificatesA;
    parameter[@"certificatesB"] = certificatesB;
    parameter[@"certificatesAB"] = certificatesAB;
    
    [[SDDispatchingCenter sharedCenter] POST:JYUserAuthentication parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}


+ (void)cmsIndexListWithId:(NSString *)Id page:(NSInteger)page completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:1];
    parameter[@"id"] = Id;
    parameter[@"page"] = @(page);
    parameter[@"pageSize"] = @(20);
    
    [[SDDispatchingCenter sharedCenter] GET:JYCmsIndexList parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *detailArr = [responseObject[@"result"] objectForKey:@"detail"];
        NSArray *arr = [JYCmsIndexModel mj_objectArrayWithKeyValuesArray:detailArr];
        
        !completion?:completion(arr, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

+ (void)cmsContentWithId:(NSString *)Id completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithCapacity:1];
    parameter[@"id"] = Id;
    
    [[SDDispatchingCenter sharedCenter] GET:JYSmsContent parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        JYCmsContentModel *model = [JYCmsContentModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

/**
 获取我的收益以及邀请码
 
 @param Id 列表Item对应id
 */
+ (void)fetchMyProfitCompletion:(YSCompleteHandler)completion{

    [[SDDispatchingCenter sharedCenter]POST:JYMyProfit parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        JYMyProfitModel *model = [JYMyProfitModel mj_objectWithKeyValues:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}




/**
 获取我的邀请名单
 
 */
+ (void)fetchRecListWithPage:(NSInteger )page completion:(YSCompleteHandler)completion
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    param[@"pageSize"] = @"20";
    [[SDDispatchingCenter sharedCenter]POST:JYRecList parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *model = [JYEarningsModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}


/**
 获取我的返佣名单
 
 */
+ (void)fetchMyInvitingWithPage:(NSInteger )page completion:(YSCompleteHandler)completion
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    param[@"pageSize"] = @"20";
    [[SDDispatchingCenter sharedCenter]POST:JYMyInviting parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *model = [JYCommissionModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

/**
 获取邀请排行榜
 
 */
+ (void)fetchRevenueRankingWithPage:(NSInteger )page completion:(YSCompleteHandler)completion
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(page);
    [[SDDispatchingCenter sharedCenter]POST:JYRevenueRanking parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *model = [JYBenefitsModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        !completion?:completion(model, nil);
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
    
}

+ (void)setUpDefaultBankCardWithId:(NSString *)Id completion:(YSCompleteHandler)completion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    param[@"id"] = Id;
    
    [[SDDispatchingCenter sharedCenter] POST:JYSetDefaultBankCard parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"result: %@", responseObject);
        !completion?:completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask *task, SDError *error) {
        [MBProgressHUD showErrorMessage:error.errorMessage toContainer:nil];
    }];
}

@end
