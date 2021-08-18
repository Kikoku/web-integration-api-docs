# Utility Methods

In addition to the event based system for working with sites, some utility methods are available to directly access data needed to make decisions in your code. Rather than waiting for a particular event to fire, you can query the information directly at any point in your code to ensure it is in context at the point where you need it. All utility methods return a JavaScript Promise so you can ensure the data is available before proceeding with the rest of your code.

## API.utils.getAttributeForVehicles(attribute)

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.subscribe('vehicle-data-updated-v1', data => {

    API.log(data.payload.pageData); // Logs the Page Data object
    API.log(data.payload.vehicleData); // Logs the updated Vehicle Data object

    API.utils.getAttributeForVehicles('vin').then(vins => {
      // With the updated list of VINs, you could query your service
      // to determine which VINs are supported by your service before
      // placing relevant content such as buttons or iframes.

      // Code to query your service goes here.

      // Output an array of VINs for vehicles currently displayed on the page.
      API.log(vins);
    });
  })
})(window.DDC.APILoader);
```

This can be used to obtain an array of attributes for the currently displayed vehicles on a page. For example, passing the attribute 'finalPrice' would return an array of all of the final prices on the page. Passing 'vin' would return an array of vehicle vins. You can pass any of the attributes that are present on the <a href="#vehicle-event">Vehicle Event object</a> and have this return an array.

## API.utils.getConfig(testConfig)

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  const testConfig = {
    dealerId: "12345",
    showOnSRP: true,
    showOnVDP: false,
    apiKey: "abcd12349876zyxw"
  }
  API.utils.getConfig(testConfig).then(config => {
    // Output the configuration object for your integration (if defined).
    API.log(config);
  });
})(window.DDC.APILoader);
```

This fetches a JavaScript object of your integration's configuration for the current website and page. Not all integrations have configuration options in our system (aside from enabled/disabled), but if your integration does, you can use this to obtain the configuration data.

`testConfig` is an optional parameter you can send into the `getConfig` method. The format should be a JavaScript object. Using the `testConfig`, you can specify any key/value pairs you need for configuration data for your integration to test various scenarios. The `testConfig` is only applied when `?_integrationMode=debug` is in the URL of the site you are testing, and that site does not already have your integration configured. If the site does have your integration configured, you can override the config specified on our side by also including `&_integrationConfig=override` in the URL.

## API.utils.getDealerData()

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.utils.getDealerData().then(dealerData => {
    // Logs the Dealership Info Event object for the current website.
    API.log(dealerData);
  });
})(window.DDC.APILoader);
```

This fetches the <a href="#dealership-info-event">Dealership Info Event object</a> for the current website.

## API.utils.getJwtForSite()

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.utils.getJwtForSite().then(jwtObject => {
    API.log(jwtObject);
    // Returns a data structure like this:
    // {
    //   jwt: "eyJraWQiOiIya0k0XzIyZoLUUi...KpSUf6vJ8b9Z1NDRcIgv0GrZoiqPhTunw" // String
    // }
  });
})(window.DDC.APILoader);
```

This fetches an object containing a Java Web Token which can be used to secure/verify the request from our site to your service. This tool offers the capability for you to validate that the request for content from your service originated from our platform and enables you to determine whether or not the content should be served. For more details regarding how to use this with your service, please refer to the <a href="#jwt-usage-documentation">JWT usage documentation</a>.


## API.utils.getJwtForVehicles()

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.utils.getJwtForVehicles().then(jwtObject => {
    API.log(jwtObject);
    // Returns a data structure like this:
    // {
    //   vins: ["1HGCV1F51LA013850", "1HGCV1F16LA029720", "1HGCV1F32LA011829"], // Array
    //   jwt: "eyJraWQiOiIya0k0XzIyZoLUUi...KpSUf6vJ8b9Z1NDRcIgv0GrZoiqPhTunw" // String
    // }
  });
})(window.DDC.APILoader);
```

This fetches an object containing the array of VINs on the current page and a corresponding Java Web Token which can be used to secure/verify the request from our site to your service. This tool offers the capability for you to validate that the request for content from your service originated from our platform and enables you to determine whether or not the content should be served. For more details regarding how to use this with your service, please refer to the <a href="#jwt-usage-documentation">JWT usage documentation</a>.

## API.utils.getPageData()

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.utils.getPageData().then(pageData => {
    // Outputs the Page Data Object for the current page.
    API.log(pageData);
  });
})(window.DDC.APILoader);
```

This fetches the <a href="#page-event">Page Event object</a> for the current website and page.

## API.utils.getUrlParams()

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  const urlParams = API.utils.getUrlParams(); // Returns the current URL parameters as object attributes, so you can easily access the values.
  API.log(urlParams); // Log the entire object.
  API.log(urlParams.query); // Access just the `query` parameter, for example.
})(window.DDC.APILoader);
```

NOTE: This method returns synchronously, not as a Promise, because the URL Params are already available and do not require asynchronous behavior for performance.

Running this function at a URL such as this:

[https://www.roimotors.com/?query=This%20is%20the%20query&hello=world&foo=bar](https://www.roimotors.com/?query=This%20is%20the%20query&hello=world&foo=bar)

Will return the following object:

`
{
  query: "This is the query",
  hello: "world",
  foo: "bar"
}
`

## API.utils.getVehicleData()

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  const config = API.utils.getVehicleData().then(vehicleData => {
    // Outputs the current set of vehicle data.
    API.log(vehicleData);
  });
})(window.DDC.APILoader);
```

## API.utils.getUnlockedVehicles()
The utility method `getUnlockedVehicles` returns an array of vehicle UUIDs where the vehicle's pricing has already been unlocked.

This can be useful when paired with the `unlockPricing` method. When `vehicle-data-updated-v1` triggers, a list of currently displayed vehicles is provided. You could gather the list of vehicles, skip the ones which are already unlocked, and then call your service for a smaller subset of vehicles which may need to be unlocked.

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.subscribe('vehicle-data-updated-v1', data => {
    const unlockedUuids = await API.utils.getUnlockedVehicles();
  });
})(window.DDC.APILoader);
```

> Another example:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.subscribe('vehicle-data-updated-v1', data => {
    // Get the list of unlocked vehicles
    const unlockedUuids = await API.utils.getUnlockedVehicles();

    // Get the list of all vehicles
    const uuids = API.utils.getAttributeForVehicles('uuid');

    // Filter the unlocked UUIDs from the UUIDs.
    const finalUuids = uuids.filter((el) => !unlockedUuids.includes(el));

    // Call your service with the list of finalUuids here, to reduce network overhead.
    // Note: `callToYourService` is just an example here and not an implemented function in the API.
    const uuidsToUnlock = await callToYourService(finalUuids);

    // Unlock vehicles which are not already unlocked, and your service indicates should be unlocked.
    API.utils.unlockPricing(uuidsToUnlock);

  });
})(window.DDC.APILoader);
```

## API.utils.unlockPricing(uuids)
The utility method `unlockPricing` is used to unlock special pricing for specific vehicles on a page.

You can provide the vehicles to unlock by passing an array of vehicle UUIDs to the method. If you would like to unlock all vehicles on the page, omit the `uuids` parameter from the function call.

The method must be called on each page where you want the vehicles to be unlocked. If a vehicle has been previously unlocked, it will be initially displayed unlocked on a subsequent view of the vehicle. However, when faceting and searching vehicles it is common for a mix of locked and unlocked vehicles to be rendered. Therefore, it is necessary to call the function each time the `vehicle-data-updated-v1` event is triggered.

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.subscribe('vehicle-data-updated-v1', data => {
    // You could call a service here to determine the list of vehicles to unlock based on the set
    // of vehicles presented on the current view, then construct the array of uuids accordingly.
    const uuids = [
      'f4b436e10a0e09a844d99ec8c92cf29c',
      '1db75afc0a0e09713efa52d69381e2f1',
      '808bb6a00a0e09716fa39a4a8b079353'
    ];
    API.utils.unlockPricing(uuids);
  });
})(window.DDC.APILoader);
```
