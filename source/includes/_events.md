# Events

By subscribing to events we publish, you can easily obtain the data you need to integrate your solution into the website. These events provide data about the website your integration is loading on and the current page the user is viewing.

There are currently three types of events and each has a consistent data format.

# Event Types

## Page Event

> Example Payload

```javascript
{
  accountId: 'futuredemodealer',
  siteId: 'futuredemodealer',
  defaultDomain: 'www.roimotors.com',
  indexPage: true,
  searchPage: false,
  detailPage: false,
  franchises: ['honda'],
  design: {
    variationId: 'v9_GLOBAL_0011_V2',
    themekit: 'BLUE_WHITE'
  },
  pageName: 'INDEX',
  layoutType: 'desktop',
  locale: 'en_US'
}
```

Field Key | Example Value | Field Format
-------------- | -------------- | --------------
`accountId` | `futuredemodealer` | `String`
`siteId` | `futuredemodealer` | `String`
`defaultDomain` | `www.roimotors.com` | `String`
`indexPage` | `true` | `Boolean`
`searchPage` | `false` | `Boolean`
`detailPage` | `false` | `Boolean`
`design` | `{variationId: 'v9_GLOBAL_0011_V2', themekit: 'BLUE_WHITE'}` | `Object`
`franchises` | `['honda']` | `Array`
`pageName` | `INDEX` | `String`
`layoutType` | `desktop` | `String`
`locale` | `en_US` | `String`

## Dealership Info Event

> Example Payload

```javascript
{
  dealershipName: 'ROI Motors',
  dealershipAddress1: '1 Howard Street',
  dealershipAddress2: '',
  dealershipCity: 'Burlington',
  dealershipPostalCode: '05401',
  dealershipStateProvince: 'VT',
  dealershipCountry: 'US'
}
```

Field Key | Example Value | Field Format
-------------- | -------------- | --------------
`dealershipName` | `ROI Motors` | `String`
`dealershipAddress1` | `1 Howard Street` | `String`
`dealershipAddress2` | | `String`
`dealershipCity` | `Burlington` | `String`
`dealershipPostalCode` | `05401` | `String`
`dealershipStateProvince` | `VT` | `String`
`dealershipCountry` | `US` | `String`

## Vehicle Event

> Example Payload

```javascript
{
  accountId: "futuredemodealer",
  bodyStyle: "Sedan",
  certified: "false",
  cityFuelEconomy: 30,
  classification: "primary",
  doors: "4-door",
  driveLine: "FWD",
  engine: "I-4 cyl",
  exteriorColor: "Platinum White Pearl",
  finalPrice: 28360,
  fuelType: "Regular Unleaded",
  highwayFuelEconomy: 38,
  interiorColor: "Black",
  internetPrice: 28360,
  inventoryType: "new",
  make: "Honda",
  model: "Accord",
  msrp: 28360,
  odometer: 5,
  status: "Live",
  stockNumber: "00180772",
  transmission: "Variable",
  trim: "EX",
  uuid: "ab119e0e0a0a00f944d6f3031cd34854",
  vin: "1HGCV1F42JA141468",
  year: 2018
}
```

Field Key | Example Value | Field Format
-------------- | -------------- | --------------
`accountId` | `futuredemodealer` | `String`
`bodyStyle` | `Sedan` | `String`
`certified` | `false` | `String`
`cityFuelEconomy` | `30` | `Integer`
`classification` | `primary` | `String`
`doors` | `4-door` | `String`
`driveLine` | `FWD` | `String`
`engine` | `I-4 cyl` | `String`
`exteriorColor` | `Platinum White Pearl` | `String`
`finalPrice` | `28360` | `Integer`
`fuelType` | `Regular Unleaded` | `String`
`highwayFuelEconomy` | `38` | `Integer`
`interiorColor` | `Black` | `String`
`internetPrice` | `28360` | `Integer`
`inventoryType` | `new` | `String`
`make` | `Honda` | `String`
`model` | `Accord` | `String`
`msrp` | `28360` | `Integer`
`odometer` | `5` | `Integer`
`status` | `Live` | `String`
`stockNumber` | `00180772` | `String`
`transmission` | `Variable` | `String`
`trim` | `EX` | `String`
`uuid` | `ab119e0e0a0a00f944d6f3031cd34854` | `String`
`vin` | `1HGCV1F42JA141468` | `String`
`year` | `2018` | `Integer`

# Event Subscriptions

To receive data for events, you must opt-in to event subscriptions. Each event is named and versioned to ensure it continues to operate in a consistent manner over time. As newer events supercede these, older events may be deprecated but will not be removed if still in use.

## Page Load V1

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('page-load-v1', function(ev) {
    API.log(ev);
  });
})(window.DDC.API);

```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`event-id` | `page-load-v1` | `String`
`callback` | `function(ev) { API.log(ev); }` | `function`

> This event passes the standard <a href="#page-event">Page Event</a> object to your callback function.

The page load event is useful to determine the context of the current page. By mapping our siteId or domain field to a customer ID in your system, you can determine the site your code is executing on as well as relevant information about the current page type and user's device type. This approach eliminates the need for configuration in our system beyond simply enabling or disabling your integration for each site.

## Dealership Info V1

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('dealership-info-v1', function(ev) {
    API.log(ev);
  });
})(window.DDC.API);

```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`event-id` | `dealership-info-v1` | `String`
`callback` | `function(ev) { API.log(ev); }` | `function`

> This event passes the standard <a href="#dealership-info-event">Dealership Info Event</a> object to your callback function.

The dealership info event is useful if you need to know the name and address of the dealership.

## Vehicle Shown V1

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('vehicle-shown-v1', function(ev) {
    API.log(ev);
  });
})(window.DDC.API);
```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`event-id` | `vehicle-shown-v1` | `String`
`callback` | `function(ev) { API.log(ev); }` | `function`

> This event passes the standard <a href="#vehicle-event">Vehicle Event</a> object to your callback function.

This event is sent for each vehicle present on the current page. For search results pages, a dozen or more such events may be fired. In the future, dynamic in-page updates to vehicle results will cause potentially hundreds of events to be fired on a single page view as new vehicles are displayed.

On a vehicle deals page, a single event is fired because you are viewing a single vehicle. This is useful for capturing details about the vehicles that a user has viewed, or to take a particular action for a certain type or class of vehicles.

## Vehicle Data Updated V1

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('vehicle-data-updated-v1', function(ev) {
    API.log(data.payload.pageData); // Outputs the Page Data object to the console.
    API.log(data.payload.vehicleData); // Outputs the updated Vehicle Data object to the console.
  });
})(window.DDC.API);
```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`event-id` | `vehicle-data-updated-v1` | `String`
`callback` | `function(ev) { API.log(ev); }` | `function`

> This event passes the standard <a href="#page-event">Page Event</a> object to your callback function as well as the full array of <a href="#vehicle-event">Vehicle Event</a> data objects.

This is useful for coding your application to work with our modern Search Results Page which is a dynamic single page application. When the list of vehicles is refreshed/updated, this event is fired with the Page and Vehicle payload of data for you to use as needed. Any subsequent methods/subscriptions/insertions can occur within this event, to ensure that when vehicles are updated your code immediately executes to decorate those vehicle cards with your content.