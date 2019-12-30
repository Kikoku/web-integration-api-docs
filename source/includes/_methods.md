# API Methods

## API.subscribe(name, callback(event))

> Usage

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  API.subscribe('event-name-and-version', function(event) {
    API.log(event);
  });
})(window.DDC.API);
```
Please see the <a href="#event-subscriptions">specific event documentation</a> for more detail on the available events and the data payload sent to your callback function.

## API.insert(name, callback(elem, meta), subscribe = true)

> Usage

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  API.insert('location-name', function(elem, meta) {
    API.log(elem); // The DOM element where markup may be inserted.
    API.log(meta); // The payload object for the current insertion point.
  }, false); // Set `subscribe` to false if you do not want this to behave as a subscription.
})(window.DDC.API);
```

> Here is an example of how you could use `API.insert` with `subcription` set to `false`:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('vehicle-data-updated-v1', function(ev) {
    API.utils.getAttributeForVehicles('vin').then(function(vins) {
      API.log("Calling service with these VINs: " + vins.join(','));
      fetch('https://www.yourdomain.com/api/endpoint-that-returns-json?vins=' + vins.join(','))
      .then(function(response) {
        return response.json();
      })
      .then(function(serviceData) {
        API.log("Data returned from service!");
        API.log(serviceData);
        API.insert('vehicle-pricing', function (elem, meta) {
          // Verify my service has data for this vehicle
          if (serviceData.hasOwnProperty(meta.vin)) {
            var button = API.create('button', {
              'text': 'My Custom Button',
              'classes': 'btn btn-primary btn-sm btn-block',
              'style': 'margin-top: 12px;',
              'src': 'https://www.yourdomain.com/search?q=' + meta.vin
            })
            API.log("Adding a button to vehicle: " + meta.vin);
            API.append(elem, button);
          } else {
            API.log("Skipping vehicle " + meta.vin + " because it does not have service data.");
          }
        }, false); // Add this 'false' parameter after you define your callback function.
      });
    });
  });
})(window.DDC.API);
```

The insert method allows you to append markup to specific locations on some pages of Dealer sites. These locations are commonly targeted areas where you may want to place content.

When activated, `API.insert` will call the callback function you define with the `elem` and `meta` parameters. It will call this for each relevant location on the page. For example, if you specify `vehicle-media` as the location and you are viewing a search results page with 30 vehicles, `API.insert` will be called 30 times, once per vehicle, with the relevant location and vehicle data in the payload.

This acts as an event subscription, so when the page updates dynamically (a single page application) and new vehicle items are presented, new events are fired and your callback is automatically called for each of those new items. This works well for a basic use case where you want to place content on every item with that location, or every item matching specific criteria available in the callback payload.

You may prefer to only call `API.insert` when you are ready, after performing other functions. For example, if you need to make a service call to your system with a list of vehicles to determine which ones have data on your side, and only then decorate specific vehicles with appropriate content, you can include a third parameter (`false`) on your `API.insert` call to disable the subscription behavior. With the subscription disabled, you'll need to invoke `API.insert` inside of a `vehicle-data-updated-v1` subscription so that your code is triggered each time the list of vehicles is changed on a page (and on initial page load) rather than only once.


Field Name | Purpose | Field Format
-------------- | -------------- | --------------
`location` | The DOM element where the markup should be inserted. | Element
`callback(elem, meta)` | The DOM element where the markup should be inserted, and the payload object for the current insertion point. | Element, Object
`subscription` | Subscribe to all events as they happen (true), or call on demand (false) | Boolean (default value: `true`)

## API.create(type, data)

> Create a Button

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  var button = API.create('button', {
    text: 'Visit Google',
    src: 'https://www.google.com/',
    classes: 'btn btn-primary',
    style: 'border: 2px solid #c00',
    attributes: {
      'target': '_blank'
    }
  });
  API.log(button);
  // The above outputs: <a href="https://www.google.com/" class="btn btn-primary" style="border: 2px solid rgb(204, 0, 0);" target="_blank">Visit Google</a>
})(window.DDC.API);
```

The create method can be used to generate markup which adheres to our standard practices. This allows you to simply "create a button", for example, without having to know the inner workings of how buttons should be created on different types of sites.

Currently only the "button" type is supported, however other types will soon be added. Please let us know if there are particular types of elements you want to create so we can work to incorporate your feedback into this API.

## API.append(targetEl, appendEl)

> Usage

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  API.append(targetEl, appendEl);
})(window.DDC.API);
```

> For example, used in conjunction with the `insert` and the `create` methods your code might look similar to this:

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  API.insert('target-location-name', function(elem, meta) {
    var lowPrice = Math.round(meta.finalPrice - 1000);
    var highPrice = Math.round(meta.finalPrice + 1000);
    var button = API.create('button', {
      text: 'Search This Price Range',
      src: '/new-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
      classes: 'btn btn-primary',
      style: 'margin-top: 12px;',
      attributes: {
        'target': '_blank'
      }
    })
    API.append(elem, button);
  });
})(window.DDC.API);
```

When calling the insert method, the goal is to insert some markup into a location on the page. Once you have constructed the element(s) you wish to insert, you may call the `append` method to complete the process.

## API.loadJS(resourceUrl)

> Usage

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  // Loads a JavaScript file
  API.loadJS('https://www.company.com/script.js')
    .then(function() {
      // Code to execute after your JavaScript file has loaded.
    });
})(window.DDC.API);
```

The loadJS method is a simple way to include additional JavaScript files required for your integration. The method returns a JavaScript Promise which you can use to know when file loading is complete, to then run any necessary initialization functions, etc.

## API.loadCSS(resourceUrl)

> Usage

```javascript
(function(WIAPI) {
  var API = new WIAPI();
  // Loads a CSS stylesheet
  API.loadCSS('https://www.company.com/integration.css')
    .then(function() {
      // Code to execute after your stylesheet has loaded.
    });
})(window.DDC.API);
```

The loadCSS method is a simple way to include an additional CSS stylesheet file required for your integration. The method returns a JavaScript Promise which you can use to know when stylesheet loading is complete, to then insert markup that depends on that styling to avoid display a flash of unstyled content.
