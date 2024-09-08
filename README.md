#  Places

## How to run the Places app

The Places app can be run in the simulator without any setup. Run from Xcode on you preferred device.
There are two screens: 
- One that displays a list of locations
- One that can be used to add a location

## How to modify the Wikipedia app for coordinate deep links

The deep links to the Wikipedia app use the following structure:

`wikipedia://places?WMFLatitude=[lat]&WMFLongitude=[long]`

An example:

`wikipedia://places?WMFLatitude=52.3547498&WMFLongitude=4.8339215`

To make sure the deep links work with the Wikipedia app, I've made the following changes:

### 1. Update *NSUserActivity+WMFExtensions* 
I added a new method to capture the latitude and longitude parameters from the URL:

```objc
+ (instancetype)wmf_placesActivityWithCoordinates:(NSURL *)activityCoordinates {
    NSURLComponents *components = [NSURLComponents componentsWithURL:activityCoordinates resolvingAgainstBaseURL:NO];
    double latitude = 0.0;
    double longitude = 0.0;
    for (NSURLQueryItem *item in components.queryItems) {
        if ([item.name isEqualToString:@"WMFLatitude"]) {
            latitude = [item.value doubleValue];
        }
        if ([item.name isEqualToString:@"WMFLongitude"]) {
            longitude = [item.value doubleValue];
        }
    }
    NSUserActivity *activity = [self wmf_pageActivityWithNameAndCoordinates:@"Places" latitude:latitude longitude:longitude];
    return activity;
}
```

And another method to create an NSUserActivity:

```objc
+ (instancetype)wmf_pageActivityWithNameAndCoordinates:(NSString *)pageName latitude:(double)latitude longitude:(double)longitude {
    NSUserActivity *activity = [self wmf_activityWithType:[pageName lowercaseString]];
    activity.title = wmf_localizationNotNeeded(pageName);

    activity.userInfo = @{
        @"WMFPage": pageName,
        @"WMFLatitude": @(latitude),
        @"WMFLongitude": @(longitude)
    };

    NSMutableSet *set = [activity.keywords mutableCopy];
    [set addObjectsFromArray:[pageName componentsSeparatedByString:@" "]];
    activity.keywords = set;

    return activity;
}
```

I also changed 
`return [self wmf_placesActivityWithURL:url];` to. `return [self wmf_placesActivityWithCoordinates:url];` to make use of the new method.

### 2. Update *WMFAppViewController*
I changed the code inside the *WMFUserActivityTypePlaces* switch case (line 1202) to the following:

```objc
[self dismissPresentedViewControllers];
[self setSelectedIndex:WMFAppTabTypePlaces];
[self.currentTabNavigationController popToRootViewControllerAnimated:animated];
double latitude = [activity.userInfo[@"WMFLatitude"] doubleValue];
double longitude = [activity.userInfo[@"WMFLongitude"] doubleValue];
if (latitude && longitude) {
    // For "View on a map" action to succeed, view mode has to be set to map.
    [[self placesViewController] updateViewModeToMap];
    [[self placesViewController] showCoordinateURLWithLatitude:latitude longitude:longitude];
}
```

This way it uses the new activity to view the correct location on the map.

### 3. Update *PlacesViewController* 
I added these functions to make sure the view controller is able to handle a request using coordinates and react accordingly:

```objc
@objc public func showCoordinateURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    let region = self.region(thatFits: coordinates)
    currentSearch = PlaceSearch(filter: .top, type: .location, origin: .user, sortStyle: .links, string: nil, region: region, localizedDescription: nil, searchResult: nil)
}

func region(thatFits coordinates: CLLocationCoordinate2D) -> MKCoordinateRegion {
    let initialRegion = [coordinates].wmf_boundingRegion(with: 50)
    return [coordinates].wmf_boundingRegion(with: 0.25 * initialRegion.width)
}
```


