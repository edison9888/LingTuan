#import "HistoryController.h"

@implementation HistoryController

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
  if (self = [super init]) {
      self.title = NSLocalizedString(@"history",nil);
      UIImage* image = [UIImage imageNamed:@"gt_images23.png"];
      self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:3] autorelease];
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

@end
