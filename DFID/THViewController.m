//
//  THViewController.m
//  DFID
//
//  Created by Tom Hartley on 29/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "THViewController.h"
#import "parseCSV.h"
#import "THAboutViewController.h"

@interface THViewController ()

@end

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *file = [[NSBundle mainBundle] pathForResource:@"DFID2010Comparison" ofType:@"csv"];
    CSVParser *parser = [[CSVParser alloc] init];
    [parser openFile:file];
    data = [parser parseFile];
    [parser closeFile];
    
    self.view.backgroundColor = [UIColor colorWithRed:116.0/255 green:186.0/255 blue:196.0/255 alpha:1];
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    topView.backgroundColor = [UIColor whiteColor];
    
    bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    //bottomView.image = [UIImage imageNamed:@"watercolorpink.png"];
    //bottomView.contentMode = UIViewContentModeBottom;
    //bottomView.clipsToBounds = YES;
    bottomView.backgroundColor = [UIColor blackColor];
    
    //backgroundView = [[KGNoiseView alloc] initWithFrame:self.view.frame];
    //backgroundView.backgroundColor = [UIColor lightGrayColor];
    //[self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    [self.view addSubview:topView];
    [self.view addSubview:bottomView];
    
    tvcCountries = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    tvcCountries.tableView.delegate = self;
    tvcCountries.tableView.dataSource = self;
    tvcCountries.tableView.rowHeight = 60;
    tvcCountries.clearsSelectionOnViewWillAppear = NO;
    [tvcCountries.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:NO];
    
    
    
    tvcProducts = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    tvcProducts.tableView.delegate = self;
    tvcProducts.tableView.dataSource = self;
    tvcProducts.tableView.rowHeight = 60;
    tvcProducts.clearsSelectionOnViewWillAppear = NO;
    [tvcProducts.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:NO];
    
    [self tableView:nil didSelectRowAtIndexPath:nil];
    
    controllerCountries = [[UIPopoverController alloc] initWithContentViewController:tvcCountries];
    controllerProducts = [[UIPopoverController alloc] initWithContentViewController:tvcProducts];
    controllerCountries.popoverContentSize = CGSizeMake(150, 300);
    controllerProducts.popoverContentSize = CGSizeMake(150, 300);
    
    [bar.topItem setLeftBarButtonItems:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"Country" style:UIBarButtonItemStylePlain target:self action:@selector(countryButtonClicked:)],[[UIBarButtonItem alloc] initWithTitle:@"Product" style:UIBarButtonItemStylePlain target:self action:@selector(productButtonClicked:)], nil] animated:NO];
    //Pink color: [UIColor colorWithRed:238.0/255 green:45.0/255 blue:119.0/255 alpha:1]
    //Dark blue color: [UIColor colorWithRed:14.0/255 green:112.0/255 blue:119.0/255 alpha:1]
    //Light blue background: [UIColor colorWithRed:116.0/255 green:186.0/255 blue:196.0/255 alpha:1]
    //Orange: [UIColor colorWithRed:255.0/255 green:162.0/255 blue:80.0/255 alpha:1]
    bar.tintColor = [UIColor colorWithRed:14.0/255 green:112.0/255 blue:119.0/255 alpha:1];
    
    THAboutViewController *cont = [[THAboutViewController alloc] initWithNibName:@"THAboutViewController" bundle:nil];
    controllerInfo = [[UIPopoverController alloc] initWithContentViewController:cont];
    controllerInfo.popoverContentSize = CGSizeMake(320, 310);
}

- (void)productButtonClicked:(UIBarButtonItem *)button {
    [controllerProducts presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [controllerCountries dismissPopoverAnimated:NO];
    [controllerInfo dismissPopoverAnimated:NO];
}

- (void)countryButtonClicked:(UIBarButtonItem *)button {
    [controllerCountries presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [controllerProducts dismissPopoverAnimated:NO];
    [controllerInfo dismissPopoverAnimated:NO];
}

- (IBAction)infoButtonClicked:(id)button {
    [controllerInfo presentPopoverFromBarButtonItem:infoButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [controllerProducts dismissPopoverAnimated:NO];
    [controllerCountries dismissPopoverAnimated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (tableView ==tvcCountries.tableView) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Canada";
                break;
            case 1:
                cell.textLabel.text = @"Ecuador";
                break;
            case 2:
                cell.textLabel.text = @"India";
                break;
            case 3:
                cell.textLabel.text = @"Nigeria";
                break;
            case 4:
                cell.textLabel.text = @"South Africa";
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Chicken";
                break;
            case 1:
                cell.textLabel.text = @"Soap";
                break;
            case 2:
                cell.textLabel.text = @"Water";
                break;
            case 3:
                cell.textLabel.text = @"Black Tea";
                break;
            case 4:
                cell.textLabel.text = @"Shoes";
                break;
            default:
                break;
        }
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:14.0/255 green:112.0/255 blue:119.0/255 alpha:1]];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //₹, $, R, ₦
    NSString *tarrifsMoney = [[data objectAtIndex:tvcProducts.tableView.indexPathForSelectedRow.row+6] objectAtIndex:tvcCountries.tableView.indexPathForSelectedRow.row+1];
    NSString *remainingMoney = [[data objectAtIndex:tvcProducts.tableView.indexPathForSelectedRow.row+1] objectAtIndex:tvcCountries.tableView.indexPathForSelectedRow.row+1];
    NSString *currencySymbol;
    NSString *countryName;
    float leftArrowX;
    float rightArrowX;
    switch (tvcCountries.tableView.indexPathForSelectedRow.row) {
        case 0:
            currencySymbol = @"$";
            countryName = @"Canada";
            leftArrowX = 191;
            rightArrowX = 544;
            break;
        case 1:
            currencySymbol = @"$";
            countryName = @"Ecuador";
            leftArrowX = 191;
            rightArrowX = 544;
            break;
        case 2:
            currencySymbol = @"₹";
            countryName = @"India";
            leftArrowX = 50;
            rightArrowX = 600;
            break;
        case 3:
            currencySymbol = @"₦";
            countryName = @"Nigeria";
            leftArrowX = 63;
            rightArrowX = 640;
            break;
        case 4:
            currencySymbol = @"R";
            countryName = @"South Africa";
            leftArrowX = 63;
            rightArrowX = 680;
            break;
        default:
            break;
    }
    
    leftArrow.frame = CGRectMake(leftArrowX, leftArrow.frame.origin.y, leftArrow.frame.size.width, leftArrow.frame.size.height);
    rightArrow.frame = CGRectMake(rightArrowX, rightArrow.frame.origin.y, rightArrow.frame.size.width, rightArrow.frame.size.height);
    
    NSString *productName;
    switch (tvcProducts.tableView.indexPathForSelectedRow.row) {
        case 0:
            productName = @"a chicken";
            break;
        case 1:
            productName = @"a bar of soap";
            break;
        case 2:
            productName = @"a bottle of water";
            break;
        case 3:
            productName = @"some black tea";
            break;
        case 4:
            productName = @"a pair of shoes";
            break;
        default:
            break;
    }
    
    remainingCosts.text = [NSString stringWithFormat:@"%@%@ of the average price of %@ from %@ is what's left over, going to places such as retailers, manufacturers and more.",currencySymbol,remainingMoney,productName,countryName];
    importCosts.text = [NSString stringWithFormat:@"%@%@ of the average price of %@ from %@ goes to tariffs such as import tax.",currencySymbol,tarrifsMoney,productName,countryName];
    float initialCostsValue = [remainingMoney floatValue];
    float importCostsValue = [tarrifsMoney floatValue];
    
    float topHeight = roundf((importCostsValue/(initialCostsValue+importCostsValue))*imageView.frame.size.height);
    float bottomHeight = imageView.frame.size.height-topHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        topView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, topHeight);
        bottomView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+topHeight, imageView.frame.size.width, bottomHeight);        
    }];
    
    [self.view sendSubviewToBack:topView];
    [self.view sendSubviewToBack:bottomView];
    [topView setNeedsDisplay];
    [bottomView setNeedsDisplay];
    
    switch (tvcCountries.tableView.indexPathForSelectedRow.row) {
        case 0:
            imageView.image = [UIImage imageNamed:@"dollar.png"];
            break;
        case 1:
            imageView.image = [UIImage imageNamed:@"dollar.png"];            
            break;
        case 2:
            imageView.image = [UIImage imageNamed:@"rupee.png"];
            break;
        case 3:
            imageView.image = [UIImage imageNamed:@"naira.png"];
            break;
        case 4:
            imageView.image = [UIImage imageNamed:@"rand.png"];
            break;
        default:
            break;
    }
    [[[bar.topItem leftBarButtonItems] objectAtIndex:0] setTitle:countryName];
    NSString *productTitle = [[[tvcProducts.tableView cellForRowAtIndexPath:tvcProducts.tableView.indexPathForSelectedRow] textLabel] text];
    [[[bar.topItem leftBarButtonItems] objectAtIndex:1] setTitle:productTitle];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }
    return NO;
}

@end
