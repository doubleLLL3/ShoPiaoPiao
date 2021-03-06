YYModel
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYModel/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/YYModel.svg?style=flat)](http://cocoapods.org/?q= YYModel)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YYModel.svg?style=flat)](http://cocoapods.org/?q= YYModel)&nbsp;
[![Build Status](https://travis-ci.org/ibireme/YYModel.svg?branch=master)](https://travis-ci.org/ibireme/YYModel)&nbsp;
[![codecov.io](https://codecov.io/github/ibireme/YYModel/coverage.svg?branch=master)](https://codecov.io/github/ibireme/YYModel?branch=master)

High performance model framework for iOS/OSX.<br/>
(It's a component of [YYKit](https://github.com/ibireme/YYKit))


Performance
==============

Time cost (process GithubUser 10000 times on iPhone 6):

![Benchmark result](https://raw.github.com/ibireme/YYModel/master/Benchmark/Result.png
)

See `Benchmark/ModelBenchmark.xcodeproj` for more benchmark case.


Features
==============
- **High performance**: The conversion performance is close to handwriting code.
- **Automatic type conversion**: The object types can be automatically converted.
- **Type Safe**: All data types will be verified to ensure type-safe during the conversion process.
- **Non-intrusive**: There is no need to make the model class inherit from other base class.
- **Lightwight**: This library contains only 5 files.
- **Docs and unit testing**: 100% docs coverage, 99.6% code coverage.

Usage
==============

###Simple model json convert

	// JSON:
	{
	    "uid":123456,
	    "name":"Harry",
	    "created":"1965-07-31T00:00:00+0000"
	}

	// Model:
	@interface User : NSObject
	@property UInt64 uid;
	@property NSString *name;
	@property NSDate *created;
	@end
	@implementation User
	@end

	
	// Convert json to model:
	User *user = [User yy_modelWithJSON:json];
	
	// Convert model to json:
	NSDictionary *json = [user yy_modelToJSONObject];


If the type of an object in JSON/Dictionary cannot be matched to the property of the model, the following automatic conversion is performed. If the automatic conversion failed, the value will be ignored.
<table>
  <thead>
    <tr>
      <th>JSON/Dictionary</th>
      <th>Model</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>NSString</td>
      <td>NSNumber,NSURL,SEL,Class</td>
    </tr>
    <tr>
      <td>NSNumber</td>
      <td>NSString</td>
    </tr>
    <tr>
      <td>NSString/NSNumber</td>
      <td>C number (BOOL,int,float,NSUInteger,UInt64,...)<br/>
      NaN and Inf will be ignored</td>
    </tr>
    <tr>
      <td>NSString</td>
      <td>NSDate parsed with these formats:<br/>
      yyyy-MM-dd<br/>
yyyy-MM-dd HH:mm:ss<br/>
yyyy-MM-dd'T'HH:mm:ss<br/>
yyyy-MM-dd'T'HH:mm:ssZ<br/>
EEE MMM dd HH:mm:ss Z yyyy
      </td>
    </tr>
    <tr>
      <td>NSDate</td>
      <td>NSString formatted with ISO8601:<br/>
      "YYYY-MM-dd'T'HH:mm:ssZ"</td>
    </tr>
    <tr>
      <td>NSValue</td>
      <td>struct (CGRect,CGSize,...)</td>
    </tr>
    <tr>
      <td>NSNull</td>
      <td>nil,0</td>
    </tr>
    <tr>
      <td>"no","false",...</td>
      <td>@(NO),0</td>
    </tr>
    <tr>
      <td>"yes","true",...</td>
      <td>@(YES),1</td>
    </tr>
  </tbody>
</table>



###Match model property to different JSON key

	// JSON:
	{
	    "n":"Harry Pottery",
	    "p": 256,
	    "ext" : {
	        "desc" : "A book written by J.K.Rowing."
	    },
	    "ID" : 100010
	}

	// Model:
	@interface Book : NSObject
	@property NSString *name;
	@property NSInteger page;
	@property NSString *desc;
	@property NSString *bookID;
	@end
	@implementation Book
	+ (NSDictionary *)modelCustomPropertyMapper {
	    return @{@"name" : @"n",
	             @"page" : @"p",
	             @"desc" : @"ext.desc",
	             @"bookID" : @[@"id",@"ID",@"book_id"]};
	}
	@end

You can map a json key (key path) or an array of json key (key path) to one or multiple property name. If there's no mapper for a property, it will use the property's name as default.

###Nested model

	// JSON
	{
	    "author":{
	        "name":"J.K.Rowling",
	        "birthday":"1965-07-31T00:00:00+0000"
	    },
	    "name":"Harry Potter",
	    "pages":256
	}

	// Model: (no need to do anything)
	@interface Author : NSObject
	@property NSString *name;
	@property NSDate *birthday;
	@end
	@implementation Author
	@end
	
	@interface Book : NSObject
	@property NSString *name;
	@property NSUInteger pages;
	@property Author *author;
	@end
	@implementation Book
	@end
	
	

### Container property

	@class Shadow, Border, Attachment;

	@interface Attributes
	@property NSString *name;
	@property NSArray *shadows; //Array<Shadow>
	@property NSSet *borders; //Set<Border>
	@property NSMutableDictionary *attachments; //Dict<NSString,Attachment>
	@end

	@implementation Attributes
	+ (NSDictionary *)modelContainerPropertyGenericClass {
		// value should be Class or Class name.
	    return @{@"shadows" : [Shadow class],
	             @"borders" : Border.class,
	             @"attachments" : @"Attachment" };
	}
	@end




### Whitelist and blacklist

	@interface User
	@property NSString *name;
	@property NSUInteger age;
	@end
	
	@implementation Attributes
	+ (NSArray *)modelPropertyBlacklist {
	    return @[@"test1", @"test2"];
	}
	+ (NSArray *)modelPropertyWhitelist {
	    return @[@"name"];
	}
	@end

###Data validate and custom transform
	
	// JSON:
	{
		"name":"Harry",
		"timestamp" : 1445534567
	}
	
	// Model:
	@interface User
	@property NSString *name;
	@property NSDate *createdAt;
	@end

	@implementation User
	- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
	    NSNumber *timestamp = dic[@"timestamp"];
	    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
	    _createdAt = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
	    return YES;
	}
	- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
	    if (!_createdAt) return NO;
	    dic[@"timestamp"] = @(n.timeIntervalSince1970);
	    return YES;
	}
	@end

###Coding/Copying/hash/equal/description

	@interface YYShadow :NSObject <NSCoding, NSCopying>
	@property (nonatomic, copy) NSString *name;
	@property (nonatomic, assign) CGSize size;
	@end

	@implementation YYShadow
	- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
	- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
	- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
	- (NSUInteger)hash { return [self yy_modelHash]; }
	- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
	- (NSString *)description { return [self yy_modelDescription]; }
	@end


Installation
==============

### CocoaPods

1. Add `pod 'YYModel'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \<YYModel/YYModel.h\>.


### Carthage

1. Add `github "ibireme/YYModel"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<YYModel/YYModel.h\>.


### Manually

1. Download all the files in the YYModel subdirectory.
2. Add the source files to your Xcode project.
3. Import `YYModel.h`.


Documentation
==============
Full API documentation is available on [CocoaDocs](http://cocoadocs.org/docsets/YYModel/).<br/>
You can also install documentation locally using [appledoc](https://github.com/tomaz/appledoc).


Requirements
==============
This library requires `iOS 6.0+` and `Xcode 7.0+`.


License
==============
YYModel is provided under the MIT license. See LICENSE file for details.


<br/><br/>
---
????????????
==============
????????? iOS/OSX ?????????????????????<br/>
(???????????? [YYKit](https://github.com/ibireme/YYKit) ????????????)


??????
==============
?????? GithubUser ?????? 10000 ??????????????? (iPhone 6):

![Benchmark result](https://raw.github.com/ibireme/YYModel/master/Benchmark/Result.png
)

?????????????????????????????? `Benchmark/ModelBenchmark.xcodeproj`???


??????
==============
- **?????????**: ?????????????????????????????????????????????
- **??????????????????**: ?????????????????????????????????????????????????????????
- **????????????**: ????????????????????????????????????????????????????????????????????????????????????????????????????????????
- **????????????**: ????????????????????????????????????
- **??????**: ??????????????? 5 ????????? (??????.h??????)???
- **?????????????????????**: ???????????????100%, ???????????????99.6%???

????????????
==============

###????????? Model ??? JSON ????????????

	// JSON:
	{
	    "uid":123456,
	    "name":"Harry",
	    "created":"1965-07-31T00:00:00+0000"
	}

	// Model:
	@interface User : NSObject
	@property UInt64 uid;
	@property NSString *name;
	@property NSDate *created;
	@end
	@implementation User
	@end

	
	// ??? JSON (NSData,NSString,NSDictionary) ????????? Model:
	User *user = [User yy_modelWithJSON:json];
	
	// ??? Model ????????? JSON ??????:
	NSDictionary *json = [user yy_modelToJSONObject];

??? JSON/Dictionary ????????????????????? Model ?????????????????????YYModel ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
<table>
  <thead>
    <tr>
      <th>JSON/Dictionary</th>
      <th>Model</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>NSString</td>
      <td>NSNumber,NSURL,SEL,Class</td>
    </tr>
    <tr>
      <td>NSNumber</td>
      <td>NSString</td>
    </tr>
    <tr>
      <td>NSString/NSNumber</td>
      <td>???????????? (BOOL,int,float,NSUInteger,UInt64,...)<br/>
      NaN ??? Inf ????????????</td>
    </tr>
    <tr>
      <td>NSString</td>
      <td>NSDate ?????????????????????:<br/>
      yyyy-MM-dd<br/>
yyyy-MM-dd HH:mm:ss<br/>
yyyy-MM-dd'T'HH:mm:ss<br/>
yyyy-MM-dd'T'HH:mm:ssZ<br/>
EEE MMM dd HH:mm:ss Z yyyy
      </td>
    </tr>
    <tr>
      <td>NSDate</td>
      <td>NSString ???????????? ISO8601:<br/>
      "YYYY-MM-dd'T'HH:mm:ssZ"</td>
    </tr>
    <tr>
      <td>NSValue</td>
      <td>struct (CGRect,CGSize,...)</td>
    </tr>
    <tr>
      <td>NSNull</td>
      <td>nil,0</td>
    </tr>
    <tr>
      <td>"no","false",...</td>
      <td>@(NO),0</td>
    </tr>
    <tr>
      <td>"yes","true",...</td>
      <td>@(YES),1</td>
    </tr>
  </tbody>
</table>


###Model ???????????? JSON ?????? Key ?????????

	// JSON:
	{
	    "n":"Harry Pottery",
	    "p": 256,
	    "ext" : {
	        "desc" : "A book written by J.K.Rowing."
	    },
	    "ID" : 100010
	}

	// Model:
	@interface Book : NSObject
	@property NSString *name;
	@property NSInteger page;
	@property NSString *desc;
	@property NSString *bookID;
	@end
	@implementation Book
	//???????????? Dict?????? Model ????????????????????? JSON ??? Key???
	+ (NSDictionary *)modelCustomPropertyMapper {
	    return @{@"name" : @"n",
	             @"page" : @"p",
	             @"desc" : @"ext.desc",
	             @"bookID" : @[@"id",@"ID",@"book_id"]};
	}
	@end
	
??????????????????????????? json key (key path) ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????

??? json->model ???????????????????????????????????????????????? json key??????????????????????????????????????????????????????????????????????????????
	
??? model->json ???????????????????????????????????????????????? json key (key path)?????????????????????????????????????????? json key (key path)??????????????????????????????????????? json key??????????????????????????????????????????????????????????????????

###Model ???????????? Model

	// JSON
	{
	    "author":{
	        "name":"J.K.Rowling",
	        "birthday":"1965-07-31T00:00:00+0000"
	    },
	    "name":"Harry Potter",
	    "pages":256
	}

	// Model: ??????????????????????????????????????????
	@interface Author : NSObject
	@property NSString *name;
	@property NSDate *birthday;
	@end
	@implementation Author
	@end
	
	@interface Book : NSObject
	@property NSString *name;
	@property NSUInteger pages;
	@property Author *author; //Book ?????? Author ??????
	@end
	@implementation Book
	@end
	
	

###???????????????

	@class Shadow, Border, Attachment;

	@interface Attributes
	@property NSString *name;
	@property NSArray *shadows; //Array<Shadow>
	@property NSSet *borders; //Set<Border>
	@property NSMutableDictionary *attachments; //Dict<NSString,Attachment>
	@end

	@implementation Attributes
	// ??????????????????????????????????????????????????? (??? Class ??? Class Name ?????????)???
	+ (NSDictionary *)modelContainerPropertyGenericClass {
	    return @{@"shadows" : [Shadow class],
	             @"borders" : Border.class,
	             @"attachments" : @"Attachment" };
	}
	@end




###?????????????????????

	@interface User
	@property NSString *name;
	@property NSUInteger age;
	@end
	
	@implementation Attributes
	// ?????????????????????????????????????????????????????????????????????????????????
	+ (NSArray *)modelPropertyBlacklist {
	    return @[@"test1", @"test2"];
	}
	// ?????????????????????????????????????????????????????????????????????????????????
	+ (NSArray *)modelPropertyWhitelist {
	    return @[@"name"];
	}
	@end

###??????????????????????????????
	
	// JSON:
	{
		"name":"Harry",
		"timestamp" : 1445534567
	}
	
	// Model:
	@interface User
	@property NSString *name;
	@property NSDate *createdAt;
	@end

	@implementation User
	// ??? JSON ?????? Model ????????????????????????????????????
	// ?????????????????????????????????????????????????????????????????????????????? NO????????? Model ???????????????
	// ??????????????????????????????????????????????????????????????????
	- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
	    NSNumber *timestamp = dic[@"timestamp"];
	    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
	    _createdAt = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
	    return YES;
	}
	
	// ??? Model ?????? JSON ????????????????????????????????????
	// ?????????????????????????????????????????????????????????????????????????????? NO????????? Model ???????????????
	// ??????????????????????????????????????????????????????????????????
	- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
	    if (!_createdAt) return NO;
	    dic[@"timestamp"] = @(n.timeIntervalSince1970);
	    return YES;
	}
	@end

###Coding/Copying/hash/equal/description

	@interface YYShadow :NSObject <NSCoding, NSCopying>
	@property (nonatomic, copy) NSString *name;
	@property (nonatomic, assign) CGSize size;
	@end

	@implementation YYShadow
	// ??????????????????????????????????????????
	- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
	- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
	- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
	- (NSUInteger)hash { return [self yy_modelHash]; }
	- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
	- (NSString *)description { return [self yy_modelDescription]; }
	@end


??????
==============

### CocoaPods

1. ??? Podfile ????????? `pod 'YYModel'`???
2. ?????? `pod install` ??? `pod update`???
3. ?????? \<YYModel/YYModel.h\>???


### Carthage

1. ??? Cartfile ????????? `github "ibireme/YYModel"`???
2. ?????? `carthage update --platform ios` ??????????????? framework ????????????????????????
3. ?????? \<YYModel/YYModel.h\>???


### ????????????

1. ?????? YYModel ??????????????????????????????
2. ??? YYModel ?????????????????????(??????)??????????????????
3. ?????? `YYModel.h`???


??????
==============
???????????? [CocoaDocs](http://cocoadocs.org/docsets/YYModel/) ???????????? API ????????????????????? [appledoc](https://github.com/tomaz/appledoc) ?????????????????????


????????????
==============
????????????????????? `iOS 6.0` ??? `Xcode 7.0`???


?????????
==============
YYModel ?????? MIT ????????????????????? LICENSE ?????????

????????????
==============

[iOS JSON ?????????????????????](http://blog.ibireme.com/2015/10/23/ios_model_framework_benchmark/)

