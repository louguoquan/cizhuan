//
//  YSAPI.h
//  PXH
//
//  Created by yu on 16/6/4.
//  Copyright © 2016年 yu. All rights reserved.
//

#ifndef YSAPI_h
#define YSAPI_h

//static NSString * BASE_URL = @"http://mobile.zjpxny.com:80/";

//static NSString * BASE_URL = @"http://jiaoyisuo.whitecao.cn";


static NSString * BASE_URL = @"http://mobile.machdary.org";
//static NSString * BASE_URL = @"http://192.168.0.145:8080";




static NSString * kUploadImage_URL = @"/mobile/member/uploadImg";

static NSString * kCustomerService_URL = @"https://kefu.easemob.com/webim/im.html?configId=4e70db49-e0db-4b14-b0a7-f52f44ec4bb6";

#pragma mark - 消息

static NSString *kMessage_URL = @"/mobile/message/messageRecords";

static NSString *kMessageTotle_URL = @"/mobile/message/totalMessageCount";

#pragma mark - 城市相关

//全部省份
static NSString * kAllProvince_URL = @"/mobile/city/getProvinces";

static NSString * kAllCitys_URL = @"/mobile/city/getCities";

static NSString * kAllCity_URL = @"/mobile/city/getAllCitys1";

static NSString * kAllRegion_URL = @"/mobile/city/getAllCity";

static NSString * kStreetList_URL = @"/mobile/city/getStreets";

static NSString * kSetDefaultAddress_URL = @"/mobile/address/setDefaultAddress";

static NSString * kDeleteAddress_URL = @"/mobile/address/deleteAddress";

#pragma mark - 用户相关

static NSString * kupload_URL = @"/mobile/appclient/saveAppClientId";

static NSString *kCleanCID_URL = @"/mobile/appclient/cleanClientId";

static NSString * kSendCode_URL = @"/mobile/code/sendCode";

static NSString * kRegister_URL = @"/mobile/member/reg";

static NSString * kLogin_URL = @"/mobile/member/login";

static NSString * kMemberDetail_URL = @"/mobile/member/getMember";

static NSString * kUpdateUserInfo_URL = @"/mobile/member/changeUserInfo";

static NSString * kFansList_URL = @"/mobile/member/myFans";

static NSString * kSigninData_URL = @"mobile/sign/list";

static NSString * kSignin_URL = @"mobile/sign/sign";

static NSString * kAmountDetail_URL = @"/mobile/member/amountDetail";

static NSString * kScoreRule_URL = @"/mobile/sign/scoreRole";

//微信绑定手机号
static NSString * kphone_URL = @"/mobile/member/wxBindMobile";

static NSString * kResetPsw_URL = @"/mobile/member/forgetPassword";

static NSString * kChangePsw_URL = @"/mobile/member/updatePassword";

static NSString * kChangePayPsw_URL = @"/mobile/member/updatePayPassword";

#pragma mark - 收货地址

static NSString * kSaveAddress_URL = @"/mobile/address/addAddress";

static NSString * kAddressList_URL = @"/mobile/address/memberAddresses";

#pragma mark - 分类

static NSString * kFirstCate_URL = @"/mobile/index/category";

static NSString * kAllCate_URL = @"/mobile/product/category/getCategory";

static NSString * kChildCate_URL = @"/mobile/product/category/getChildrenCategory";

#pragma mark - 产品

static NSString * kIndexData_URL = @"/mobile/index/headData";

static NSString * kSearchProduct_URL = @"/coin/info/list";

static NSString * kProductDetail_URL = @"/mobile/product/productDetail";

static NSString * kStandardDetail_URL = @"/mobile/product/getNormal";

static NSString * kCartProductList_URL = @"/mobile/carItem/getMemberCars";

static NSString * kCartProductNum_URL = @"/mobile/member/cartNum";

static NSString * kChangeProductCount_URL = @"/mobile/carItem/updateNum";

static NSString * kDeleteCartProduct_URL = @"/mobile/carItem/delete";

static NSString * kSeckillProduct_URL = @"/mobile/limitBuy/getLimitCountProduct";

static NSString * kPanicBuyProduct_URL = @"/mobile/limitBuy/getLimitBuyProduct";

static NSString * kProductCommentList_URL = @"/mobile/product/comment/getComments";

static NSString * kBrands_URL = @"/mobile/product/category/getBrands";

static NSString * kCollect_URL = @"/mobile/collect/doCollect";

static NSString * kCollectList_URL = @"/mobile/collect/collects";

#pragma mark - 订单

static NSString * kBuyNow_URL = @"/mobile/order/buyNowConfirmOrder";

static NSString * kCartSettle_URL = @"/mobile/order/carToOrderConfirmOrder";

static NSString * kAddToCart_URL = @"/mobile/carItem/addProduct";

static NSString * kServiceStationByAddress_URL = @"/mobile/address/getService";

static NSString * kBuyNowCreateOrder_URL = @"/mobile/order/buyNowCreateOrder";

static NSString * kCartCreateOrder_URL = @"/mobile/order/carToOrder";

static NSString * kOrderList_URL = @"/mobile/order/myOrder";

static NSString * kOrderDetail_URL = @"mobile/order/orderDetail";

static NSString * kDeliverDetail_URL = @"/mobile/order/getExpressInfo";

static NSString * kLimitBuyTime_URL = @"mobile/limitBuy/getLimitBuyTime";

static NSString * kRecharge_URL = @"/mobile/coffers/recharge";

static NSString * kOrderPay_URL = @"/mobile/order/singleOrderPay";

static NSString * kCancelOrder_URL = @"/mobile/order/cancelOrder";

static NSString * kConfirmReceipt_URL = @"/mobile/order/confirmGet";

static NSString * kDeleteOrder_URL = @"/mobile/order/deleteOrder";

static NSString * kOrderComment_URL = @"/mobile/product/comment/doComment";

static NSString * kRefundsApply_URL = @"/mobile/order/customerService/apply";

static NSString * kRefundsDetail_URL = @"/mobile/order/customerService/getCustomerServiceInfo";
static NSString * kCancelRefunds_URL = @"/mobile/order/customerService/cancelRefund";

static NSString * kOrderCount_URL = @"/mobile/order/orderCount";

#pragma mark - 生活圈

static NSString * kLifeCircle_URL = @"mobile/life/data";

static NSString * kShopDetail_URL = @"/mobile/life/shopDetail";

static NSString * kCouponsList_URL = @"/mobile/member/myCoupons";

static NSString * kCouponExchange_URL = @"/mobile/life/couponExchange";

static NSString * kCouponUse_URL = @"/mobile/life/useCoupon";

static NSString * kMerchantsList_URL = @"/mobile/life/getShopByLifeCatId";

static NSString * kCouponComment_URL = @"/mobile/life/couponComment";

static NSString * kCouponDetail_URL = @"/mobile/life/couponDetail";

static NSString * KGetCouponComment_URL = @"/mobile/life/getCouponComment";

//提现
static NSString * kWithDraw_URL = @"/mobile/member/withdraw";
//分润记录
static NSString * kCommissionRecord = @"/mobile/member/commissionRecord";


//新建充值订单
static NSString * kCreateRechargeOrder = @"/mobile/order/createRechargeOrder";
//订单列表
static NSString * kOrderList = @"/mobile/order/orderList";
//自选币种收藏或者解除
static NSString * kCollectCoin = @"/coin/info/collectCoin";
//取消订单
static NSString * kCancelOrder = @"/mobile/order/cancelOrder";
//确认订单
static NSString * kPayOrder = @"/mobile/order/payOrder";
//我的币种账户
static NSString * kMyCoins = @"/mobile/trade/account/myCoins";

//自选币种重新排序
static NSString * kUpdateSort = @"/coin/info/updateSort";

//提现须知
static NSString * kWithdrawNotice = @"/mobile/withdraw/withdrawNotice";
//转账费用
static NSString * kWithdrawFee = @"/mobile/withdraw/withdrawFee";
//提交提现转账
static NSString * kWithdrawSub = @"/mobile/withdraw/withdrawSub";
//检查更新
static NSString * kVersionCheck = @"/mobile/member/version";

//检查更新
static NSString * kSystemTime = @"/date/getTime";



//挂单
static NSString * kMatchTradeBuy = @"/matchTrade/buy";
//撤销挂单
static NSString * kMatchTradeCancel = @"/matchTrade/cancel";
//挂单列表
static NSString * kMatchTrademyList = @"/matchTrade/myList";

//挂单右侧买卖列表
static NSString * kMatchTradeGuadanList = @"/matchTrade/guadanList";

//我的历史委托
static NSString * kMatchTradeMyHistoryList = @"/matchTrade/myHistoryList";

//我的所有历史委托
static NSString * kMatchTradeMyAllHistoryList = @"/matchTrade/myAllHistoryList";

//挂单所需信息
static NSString * kMatchTradeGuadaninfo = @"/matchTrade/guadaninfo";

//挂单所需信息
static NSString * kMatchTradeGuaDanInfoNoToken = @"/matchTrade/guaDanInfoNoToken";




//交易实时成交订单
static NSString * kMatchTradeTradeDetails = @"/matchTrade/tradeDetails";

//K线图
static NSString * kMatchTradekLineInfo = @"/kline/history";


//K线图头部
static NSString * kMatchKlineHead = @"/kline/klineHead";


//银行卡信息
static NSString * kMobileCmsBankCard = @"/mobile/cms/bankCard";


//USDT价格
static NSString * kMatchTradeGetUsdt = @"/matchTrade/getUsdt";





////转账费用
//static NSString * kWithdrawFee = @"/mobile/withdraw/withdrawFee";
//
////提交提现转账
//static NSString * kWithdrawSub = @"/mobile/withdraw/withdrawSub";

//根据币种id获取币种信息
static NSString * JYGetCoinById = @"/coin/info/getCoinById";

//提交提币
static NSString * JYSubmintCoinExc = @"/mobile/trade/coin/subExchanges";

//提币记录
static NSString * JYCoinExchangeRecord = @"/mobile/trade/coin/exchanges";

//充币记录
static NSString * JYCurrencyRecord = @"/coin/charge/records";

//充值提现记录
static NSString * JYOrderRecord = @"/mobile/order/orderRecord";

//修改资金密码
static NSString *JYSetUpPayPassWord_URL = @"/mobile/user/setPayPassword";

//修改登录密码
static NSString *JYSetUpLoginPassWord_URL = @"/mobile/user/setLoginPassword";

#endif /* YSAPI_h */
