# Utility Methods

In addition to the event based system for working with sites, some utility methods are available to directly access data needed to make decisions in your code. Rather than waiting for a particular event to fire, you can query the information directly at any point in your code to ensure it is in context at the point where you need it. All utility methods return a JavaScript Promise so you can ensure the data is available before proceeding with the rest of your code.

## API.utils.getAttributeForVehicles(attribute)

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('vehicle-data-updated-v1', function(data) {

    API.log(data.payload.pageData); // Logs the Page Data object
    API.log(data.payload.vehicleData); // Logs the updated Vehicle Data object

    API.utils.getAttributeForVehicles('vin').then(function(vins) {
      // With the updated list of VINs, you could query your service
      // to determine which VINs are supported by your service before
      // placing relevant content such as buttons or iframes.

      // Code to query your service goes here.

      // Output an array of VINs for vehicles currently displayed on the page.
      API.log(vins);
    });
  })
})(window.DDC.API);
```

This can be used to obtain an array of attributes for the currently displayed vehicles on a page. For example, passing the attribute 'finalPrice' would return an array of all of the final prices on the page. Passing 'vin' would return an array of vehicle vins. You can pass any of the attributes that are present on the <a href="#vehicle-event">Vehicle Event object</a> and have this return an array.

## API.utils.getConfig()

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI('test-integration');
  API.utils.getConfig().then(function(config) {
    // Output the configuration object for your integration (if defined).
    API.log(config);
  });
})(window.DDC.API);
```

This fetches a JavaScript object of your integration's configuration for the current website and page. Not all integrations have configuration options in our system (aside from enabled/disabled), but if your integration does, you can use this to obtain the configuration data.

## API.utils.getDealerData()

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.utils.getDealerData().then(function(dealerData) {
    // Logs the Dealership Info Event object for the current website.
    API.log(dealerData);
  });
})(window.DDC.API);
```

This fetches the <a href="#dealership-info-event">Dealership Info Event object</a> for the current website.

## API.utils.getJwtForVehicles()

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.utils.getJwtForVehicles().then(function(jwtObject) {
    API.log(jwtObject);
    // Returns a data structure like this:
    // {
    //   vins: ["1HGCV1F51LA013850", "1HGCV1F16LA029720", "1HGCV1F32LA011829"], // Array
    //   jwt: "eyJraWQiOiIya0k0XzIyZoLUUi...KpSUf6vJ8b9Z1NDRcIgv0GrZoiqPhTunw" // String
    // }
  });
})(window.DDC.API);
```

This fetches an object containing the array of VINs on the current page and a corresponding Java Web Token which can be used to secure/verify the request from our site to your service. This tool offers the capability for you to validate that the request for content from your service originated from our platform and enables you to determine whether or not the content should be served up. For more details regarding how to use this with your service, please refer to our JWT documentation.

## API.utils.getPageData()

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.utils.getPageData().then(function(pageData) {
    // Outputs the Page Data Object for the current page.
    API.log(pageData);
  });
})(window.DDC.API);
```

This fetches the <a href="#page-event">Page Event object</a> for the current website and page.

## API.utils.getUrlParams()

NOTE: This method does not return a promise as the URL Params are immediately available and do not require Promise behavior.

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  var urlParams = API.utils.getUrlParams();
  API.log(urlParams); // Logs the configuration object for your integration (if there is one).
})(window.DDC.API);
```

## API.utils.getVehicleData()

> Usage:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  var config = API.utils.getVehicleData().then(function(vehicleData) {
    // Outputs the current set of vehicle data.
    API.log(vehicleData);
  });
})(window.DDC.API);
```
