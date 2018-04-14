//
//  Product.h
//  CNstorm
//
//  Created by Zhang Lisheng on 14-7-2.
//  Copyright (c) 2014年 cnstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, readwrite) long long category_id;
@property (nonatomic, readwrite) int column;
@property (nonatomic, strong) NSString *date_added;
@property (nonatomic, strong) NSString *date_available;
@property (nonatomic, strong) NSString *date_modified;
@property (nonatomic, strong) NSString *desc;//描述description
@property (nonatomic, strong) NSString *ean;
@property (nonatomic, readwrite) float height;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, readwrite) float isbn;
@property (nonatomic, strong) NSString *jan;
@property (nonatomic, readwrite) float length;
@property (nonatomic, readwrite) int length_class_id;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, strong) NSString *manufacturer_id;
@property (nonatomic, strong) NSString *meta_description;
@property (nonatomic, strong) NSString *meta_keyword;
@property (nonatomic, readwrite) int minimum;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *mpn;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, readwrite) int points;
@property (nonatomic, readwrite) float price;
@property (nonatomic, readwrite) long long product_id;
@property (nonatomic, readwrite) int quantity;
@property (nonatomic, readwrite) int rating;
@property (nonatomic, readwrite) int reviews;
@property (nonatomic, readwrite) int reward;
@property (nonatomic, strong) NSString *sku;
@property (nonatomic, readwrite) int sort_order;
@property (nonatomic, strong) NSString *special;
@property (nonatomic, readwrite) int status;
@property (nonatomic, strong) NSString *stock_status;
@property (nonatomic, readwrite) int subtract;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, readwrite) int tax_class_id;
@property (nonatomic, strong) NSString *upc;
@property (nonatomic, readwrite) int viewed;
@property (nonatomic, readwrite) float weight;
@property (nonatomic, readwrite) int weight_class_id;
@property (nonatomic, readwrite) float width;

- (id) init;

@end

//"date_added" = "2014-06-18 10:37:54";
//"date_available" = "2014-06-17";
//"date_modified" = "0000-00-00 00:00:00";
//description = "";
//ean = "\U7ea2\U8272\U73b0\U8d27,\U9ed1\U8272\U73b0\U8d27,\U8367\U5149\U7eff\U3010\U73b0\U8d27\U3011";
//height = "0.00000000";
//image = "data/2222.jpg";
//isbn = "10.00";
//jan = "L,S,M";
//length = "0.00000000";
//"length_class_id" = 1;
//location = "http://item.taobao.com/item.htm?spm=a1z10.5.w4002-6903169730.44.gc9Xtf&amp;id=38139800124";
//manufacturer = "<null>";
//"manufacturer_id" = "<null>";
//"meta_description" = "";
//"meta_keyword" = "";
//minimum = 1;
//model = "\U6dd8\U5b9d\U7f51";
//mpn = "\U9a6c\U592a\U7f8e\U8863MATAISHOP";
//name = "2014 \U9a6c\U592a\U7f8e\U8863\U6781\U7b80\U65e0\U8896\U77ed\U88d9 \U80cc\U5fc3\U84ec\U84ec\U88d9 \U9ad8\U8170\U8ff7\U4f60\U8fde\U8863\U88d9 \U72ec\U5bb6\U5b9a\U5236";
//points = 0;
//price = "220.00";
//"product_id" = 181;
//quantity = 85;
//rating = 0;
//reviews = 0;
//reward = 0;
//sku = aHR0cDovL3d3dy50YW9iYW8uY29tL3dlYnd3Lz92ZXI9MSZ0b3VpZD1jbnRhb2JhbyVFNSVBRiVCQiVFNiU4OSVCRSVFOSU4MSU5NyVFNSVBNCVCMSVFNyU5QSU4NCVF;
//"sort_order" = 1;
//special = "<null>";
//status = 1;
//"stock_status" = "Out Of Stock";
//subtract = 1;
//tag = "";
//"tax_class_id" = 0;
//upc = "\U5bfb\U627e\U9057\U5931\U7684\U9a6c\U592a";
//viewed = 6;
//weight = "0.00000000";
//"weight_class_id" = 1;
//width = "0.00000000";

