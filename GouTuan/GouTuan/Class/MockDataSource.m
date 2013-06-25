
#import "MockDataSource.h"
#import "ShareData.h"

@interface MockAddressBook ()
- (void) loadNames;
@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MockAddressBook

@synthesize names = _names, namePY=_namePY,fakeSearchDuration = _fakeSearchDuration, fakeLoadingDuration = _fakeLoadingDuration;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)fakeSearch:(NSString*)text {
  self.names = [NSMutableArray array];

  if (text.length) {
    text = [text lowercaseString];
    for (id allNameDic in _allNames) {
      NSDictionary *nameDic = allNameDic;
        NSString *name = [nameDic objectForKey:@"py"];
      if ([[name lowercaseString] rangeOfString:text].location == 0) {
          
        [_names addObject:allNameDic];
      }
    }
  }

  [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

- (void)fakeSearchReady:(NSTimer*)timer {
  _fakeSearchTimer = nil;

  NSString* text = timer.userInfo;
  [self fakeSearch:text];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithNames:(NSArray*)names {
  if (self = [super init]) {
    _delegates = nil;
    _allNames = [names copy];
    _names = nil;
    _fakeSearchTimer = nil;
    _fakeSearchDuration = 0;
  }
  return self;
}

- (void)dealloc {
  TT_INVALIDATE_TIMER(_fakeSearchTimer);
  TT_INVALIDATE_TIMER(_fakeLoadingTimer)
  TT_RELEASE_SAFELY(_delegates);
  TT_RELEASE_SAFELY(_allNames);
  TT_RELEASE_SAFELY(_names);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModel

- (NSMutableArray*)delegates {
  if (!_delegates) {
    _delegates = TTCreateNonRetainingArray();
  }
  return _delegates;
}

- (BOOL)isLoadingMore {
  return NO;
}

- (BOOL)isOutdated {
  return NO;
}

- (BOOL)isLoaded {
  return !!_names;
}

- (BOOL)isLoading {
  return !!_fakeSearchTimer || !!_fakeLoadingTimer;
}

- (BOOL)isEmpty {
  return !_names.count;
}

- (void) fakeLoadingReady {
  _fakeLoadingTimer = nil;
    
  [self loadNames];

  [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
  if (_fakeLoadingDuration) {
    TT_INVALIDATE_TIMER(_fakeLoadingTimer);
    _fakeLoadingTimer = [NSTimer scheduledTimerWithTimeInterval:_fakeLoadingDuration target:self
                                                       selector:@selector(fakeLoadingReady) userInfo:nil repeats:NO];
    [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
  } else {
    [self loadNames];
    [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
  }
}

- (void)invalidate:(BOOL)erase {
}

- (void)cancel {
  if (_fakeSearchTimer) {
    TT_INVALIDATE_TIMER(_fakeSearchTimer);
    [_delegates perform:@selector(modelDidCancelLoad:) withObject:self];
  } else if(_fakeLoadingTimer) {
    TT_INVALIDATE_TIMER(_fakeLoadingTimer);
    [_delegates perform:@selector(modelDidCancelLoad:) withObject:self];    
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (void)loadNames {
  TT_RELEASE_SAFELY(_names);
  _names = [_allNames mutableCopy];
}

- (void)search:(NSString*)text {
  [self cancel];

  TT_RELEASE_SAFELY(_names);
  if (text.length) {
    if (_fakeSearchDuration) {
      TT_INVALIDATE_TIMER(_fakeSearchTimer);
      _fakeSearchTimer = [NSTimer scheduledTimerWithTimeInterval:_fakeSearchDuration target:self
                                selector:@selector(fakeSearchReady:) userInfo:text repeats:NO];
      [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
    } else {
      [self fakeSearch:text];
      [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
    }
  } else {
    [_delegates perform:@selector(modelDidChange:) withObject:self];
  }
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MockDataSource

@synthesize addressBook = _addressBook;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
    _addressBook = [[MockAddressBook alloc] initWithNames:nil];
    self.model = _addressBook;
  }
  return self;
}

- (id)init:(NSMutableArray*)fakeNamesArray {
    if (self = [super init]) {
        //cityArray = [fakeNamesArray copy];
        _addressBook = [[MockAddressBook alloc] initWithNames:fakeNamesArray];
        self.model = _addressBook;
    }
    return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_addressBook);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UITableViewDataSource

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView {
  return [TTTableViewDataSource lettersForSectionsWithSearch:NO summary:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView*)tableView {
  self.items = [NSMutableArray array];
  self.sections = [NSMutableArray array];

  NSMutableDictionary* groups = [NSMutableDictionary dictionary];
  for (id addressNameDic in _addressBook.names) {
    NSDictionary *nameDic = addressNameDic;
    NSString *cityCenterLatitude = [nameDic objectForKey:@"lat"];
    NSString *cityCenterLongtitude = [nameDic objectForKey:@"lng"];
    NSString *cityid = [nameDic objectForKey:@"id"];
    NSString *name = [nameDic objectForKey:@"py"];
    NSString *nameItem =  [nameDic objectForKey:@"name"];
    if ([nameItem isEqualToString:[ShareData sharedInstance].sStrCity]) {
        int intCityId = [cityid intValue];
        [ShareData sharedInstance].sIntCity = intCityId;
        [[NSUserDefaults standardUserDefaults] setInteger:intCityId forKey:@"intcity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    NSString* upperletter = [NSString stringWithFormat:@"%C", [name characterAtIndex:0]];
    NSString* letter = [upperletter uppercaseString];
    NSMutableArray* section = [groups objectForKey:letter];
    if (!section) {
      section = [NSMutableArray array];
      [groups setObject:section forKey:letter];
    }

    TTTableItem* item = [TTTableTextItem itemWithText:nameItem withID:cityid withLatitude:cityCenterLatitude withLongtitude:cityCenterLongtitude];
    [section addObject:item];
  }

  NSArray* letters = [groups.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
  for (NSString* letter in letters) {
    NSArray* items = [groups objectForKey:letter];
    [_sections addObject:letter];
    [_items addObject:items];
  }
}

- (void)tableView:(UITableView*)tableView cell:(UITableViewCell*)cell
willAppearAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *strCell = cell.textLabel.text;
    if ([strCell isEqualToString:[ShareData sharedInstance].sStrCity]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}

- (id<TTModel>)model {
  return _addressBook;
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MockSearchDataSource

@synthesize addressBook = _addressBook;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithDuration:(NSTimeInterval)duration {
  if (self = [super init]) {
    _addressBook = [[MockAddressBook alloc] initWithNames:[MockAddressBook fakeNames]];
    _addressBook.fakeSearchDuration = duration;
    self.model = _addressBook;
  }
  return self;
}

- (id)init {
  return [self initWithDuration:0];
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_addressBook);
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView*)tableView {
  self.items = [NSMutableArray array];

  for (NSString* name in _addressBook.names) {
    TTTableItem* item = [TTTableTextItem itemWithText:name URL:@"http://google.com"];
    [_items addObject:item];
  }
}

- (void)search:(NSString*)text {
  [_addressBook search:text];
}

- (NSString*)titleForLoading:(BOOL)reloading {
  return @"Searching...";
}

- (NSString*)titleForNoData {
  return @"No names found";
}

@end
