//
// Color Tests
// http://www.cocos2d-iphone.org
//
//  Created by Andy Korth on 12/12/13.
//

#import "cocos2d.h"
#import "TestBase.h"

@interface ColorTest : TestBase @end

@implementation ColorTest

- (void) setUp
{
	[[CCFileUtils sharedFileUtils] setSearchPath: @[ @"Images", kCCFileUtilsDefaultSearchPath] ];
}

- (CCSprite *) loadAndDisplayImageNamed:(NSString*) fileName withTitle:(NSString*) title{

	self.subTitle = title;
	
	CGSize s = [[CCDirector sharedDirector] viewSize];
	
	CCSprite *img = [CCSprite spriteWithImageNamed:fileName];
	img.position = ccp( s.width/2.0f, s.height/2.0f);
	[self.contentNode addChild:img];
	return img;
}

-(void) setupTintRedTest
{
	CCSprite * img = [self loadAndDisplayImageNamed: @"powered.png" withTitle: @"Tint image red"];
	[img setColor:[UIColor redColor]];
}


-(void) setupNormalColorTest
{
	CCSprite * img = [self loadAndDisplayImageNamed: @"powered.png" withTitle: @"Image should be normal colored"];
	[img setColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
}

-(void) setupHalfTransparentTest
{
	CCSprite * img = [self loadAndDisplayImageNamed: @"powered.png" withTitle: @"50% alpha, via Color"];
	[img setColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f]];
}

-(void) setupHalfTransparentViaOpacityTest
{
	CCSprite * img = [self loadAndDisplayImageNamed: @"powered.png" withTitle: @"50% alpha, via SetOpacity"];
	[img setOpacity:0.5f];
}

-(void) setupDoNotCascadeColorTest
{
	CGSize s = [[CCDirector sharedDirector] viewSize];
	
	// add parent with two children sprites.
	CCSprite *parent = [self loadAndDisplayImageNamed: @"powered.png" withTitle: @""];
	[parent setPosition:ccp(s.width/2, s.height/3*2)];
	
	
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"powered.png"];
	[parent addChild:sprite];
	[sprite setPosition:ccp(-parent.contentSize.width, -100)];
	
	sprite = [CCSprite spriteWithImageNamed:@"powered.png"];
	[parent addChild:sprite];
	[sprite setPosition:ccp(2* parent.contentSize.width, -100)];
	
	parent.cascadeColorEnabled = NO;
	[parent setColor:[CCColor redColor]];
	
	self.subTitle = @"Parent should be red, children normal. (Color cascade off)";
}

-(void) setupCascadeColorTest
{
	CGSize s = [[CCDirector sharedDirector] viewSize];

	// add parent with two children sprites.
	CCSprite *parent = [self loadAndDisplayImageNamed: @"powered.png" withTitle: @""];
	[parent setPosition:ccp(s.width/2, s.height/3*2)];
	
	
	CCSprite *sprite = [CCSprite spriteWithImageNamed:@"powered.png"];
	[parent addChild:sprite];
	[sprite setPosition:ccp(-parent.contentSize.width, -100)];
	
	sprite = [CCSprite spriteWithImageNamed:@"powered.png"];
	[parent addChild:sprite];
	[sprite setPosition:ccp(2* parent.contentSize.width, -100)];
	
	parent.cascadeColorEnabled = YES;
	[parent setColor:[CCColor redColor]];
	
	self.subTitle = @"Parent and 2 children sprites should all be red. (Color cascade)";
}

@end
