//
//  MJRefreshConst.h
//  MJRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// 文字颜色
#define MJRefreshLabelTextColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]

#define MJUpdatetimeLabelTextColor [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]

extern const CGFloat MJRefreshViewHeight;
extern const CGFloat MJRefreshAnimationDuration;

extern NSString *const MJRefreshBundleName;
#define kSrcName(file) [MJRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const MJRefreshFooterPullToRefresh;
extern NSString *const MJRefreshFooterReleaseToRefresh;
extern NSString *const MJRefreshFooterRefreshing;

extern NSString *const MJRefreshHeaderPullToRefresh;
extern NSString *const MJRefreshHeaderReleaseToRefresh;
extern NSString *const MJRefreshHeaderRefreshing;
extern NSString *const MJRefreshHeaderTimeKey;

extern NSString *const MJRefreshContentOffset;
extern NSString *const MJRefreshContentSize;