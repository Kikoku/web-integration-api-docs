# Events

By subscribing to events we publish, you can easily obtain the data you need to integrate your solution into the website. These events provide site and page data as well as vehicle data for the current page view.

At present, there are two types of events and each has a consistent data format.

# Event Types

## Page Event

> Example Payload

```javascript
{
  accountId: 'futuredemodealer',
  siteId: 'futuredemodealer',
  defaultDomain: 'www.roimotors.com',
  dealershipName: 'ROI Motors',
  dealershipAddress1: '1 Howard Street',
  dealershipAddress2: '',
  dealershipCity: 'Burlington',
  dealershipCountry: 'US',
  dealershipName: 'ROIMOTORS Honda',
  dealershipPostalCode: '05401',
  dealershipStateProvince: 'VT',
  dealershipCountry: 'US',
  indexPage: true,
  searchPage: false,
  detailPage: false,
  pageTitle: 'Welcome to ROI Motors!',
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
`dealershipName` | `ROI Motors` | `String`
`dealershipAddress1` | `1 Howard Street` | `String`
`dealershipAddress2` | | `String`
`dealershipCity` | `Burlington` | `String`
`dealershipCountry` | `US` | `String`
`dealershipName` | `ROIMOTORS Honda` | `String`
`dealershipPostalCode` | `05401` | `String`
`dealershipStateProvince` | `VT` | `String`
`dealershipCountry` | `US` | `String`
`indexPage` | `false` | `Boolean`
`searchPage` | `true` | `Boolean`
`detailPage` | `false` | `Boolean`
`pageTitle` | `Welcome to ROI Motors!` | `String`
`pageName` | `INDEX` | `String`
`layoutType` | `desktop` | `String`
`locale` | `en_US | String`


## Vehicle Event

> Example Payload

```javascript
{
  accountId: "futuredemodealer"
  bodyStyle: "Sedan"
  certified: "false"
  cityFuelEfficiency: 30
  classification: "primary"
  doors: "4-door"
  driveLine: "FWD"
  engine: "I-4 cyl"
  exteriorColor: "Platinum White Pearl"
  finalPrice: 28360
  fuelType: "Regular Unleaded"
  highwayFuelEfficiency: 38
  interiorColor: ""
  internetPrice: 28360
  inventoryType: "new"
  make: "Honda"
  model: "Accord"
  modelYear: "2018"
  msrp: 28360
  odometer: 5
  status: "Live"
  stockNumber: "00180772"
  transmission: "Variable"
  trim: "EX"
  uuid: "ab119e0e0a0a00f944d6f3031cd34854"
  vin: "1HGCV1F42JA141468"
}
```

Field Key | Example Value | Field Format
-------------- | -------------- | --------------
`accountId` | `futuredemodealer` | `String`
`bodyStyle` | `Sedan` | `String`
`certified` | `false` | `String`
`cityFuelEfficiency` | `30` | `Integer`
`classification` | `primary` | `String`
`doors` | `4-door` | `String`
`driveLine` | `FWD` | `String`
`engine` | `I-4 cyl` | `String`
`exteriorColor` | `Platinum White Pearl` | `String`
`finalPrice` | `28360` | `Integer`
`fuelType` | `Regular Unleaded` | `String`
`highwayFuelEfficiency` | `38` | `Integer`
`interiorColor` | `Black` | `String`
`internetPrice` | `0` | `Integer`
`inventoryType` | `new` | `String`
`make` | `Honda` | `String`
`model` | `Accord` | `String`
`modelYear` | `2018` | `Integer`
`msrp` | `28360` | `Integer`
`odometer` | `5` | `Integer`
`status` | `Live` | `String`
`stockNumber` | `00180772` | `String`
`transmission` | `Variable` | `String`
`trim` | `EX` | `String`
`uuid` | `ab119e0e0a0a00f944d6f3031cd34854` | `String`
`vin` | `1HGCV1F42JA141468` | `String`

# Event Subscriptions

To receive data for events, you must opt-in to event subscriptions. Each event is named and versioned to ensure it continues to operate in a consistent manner over time. As newer events supercede these, older events may be deprecated but will not be removed if still in use.

## Page Load V1

> Usage

> The event key is `page-load-v1`

```javascript
DDC.API.subscribe('your-integration-key', 'page-load-v1', function(ev) {
  console.log(ev.payload);
});
```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`key` | `your-integration-key` | `String`
`event-id` | `page-load-v1` | `String`
`callback` | `function(ev) { console.log(ev); }` | `function`

> This event passes the standard <a href="#page-event">Page Event</a> object to your callback function.

The page load event is useful to determine the context of the current page. By mapping our siteId or domain field to a customer ID in your system, you can determine the site your code is executing on as well as relevant information about the current page type and user's device type. This approach eliminates the need for configuration in our system beyond simply enabling or disabling your integration for each site.

## Vehicle Clicked V1

> Usage

```javascript
DDC.API.subscribe('your-integration-key', 'vehicle-clicked-v1', function(ev) {
  console.log(ev.payload);
});
```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`key` | `your-integration-key` | `String`
`event-id` | `vehicle-clicked-v1` | `String`
`callback` | `function(ev) { console.log(ev); }` | `function`

> This event passes the standard <a href="#vehicle-event">Vehicle Event</a> object to your callback function.

This event is fired when the user clicks on a vehicle to view more details. This typically occurs on website index pages and search results pages.

## Vehicle Shown V1

> Usage

```javascript
DDC.API.subscribe('your-integration-key', 'vehicle-shown-v1', function(ev) {
  console.log(ev.payload);
});
```

Parameter Name | Example Value | Parameter Type
-------------- | -------------- | --------------
`key` | `your-integration-key` | `String`
`event-id` | `vehicle-shown-v1` | `String`
`callback` | `function(ev) { console.log(ev); }` | `function`

> This event passes the standard <a href="#vehicle-event">Vehicle Event</a> object to your callback function.

This event is sent for each vehicle present on the current page. For search results pages, a dozen or more such events may be fired. In the future, dynamic in-page updates to vehicle results will cause potentially hundreds of events to be fired on a single page view as new vehicles are displayed.

On a vehicle deals page, a single event is fired because you are viewing a single vehicle. This is useful for capturing details about the vehicles that a user has viewed, or to take a particular action for a certain type or class of vehicles.
