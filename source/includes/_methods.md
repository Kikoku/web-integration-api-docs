# API Methods

## subscribe(key, name, callback(ev))

> Usage

```JavaScript
(function(API) {
  var key = 'your-integration-key';
  API.subscribe(key, 'event-name-and-version', function(ev) {
    API.log(key, ev);
  });
})(window.DDC.API);
```
Please see the <a href="#event-subscriptions">specific event documentation</a> for more detail on the available events and the data payload sent to your callback function.

## insert(key, name, callback(elem, meta))

> Usage

```javascript
(function(API) {
  var key = 'your-integration-key';
  API.insert(key, 'location-name', function(elem, meta) {
    API.log(key, elem); // The DOM element where markup may be inserted.
    API.log(key, meta); // The payload object for the current insertion point.
  });
})(window.DDC.API);
```

The insert method allows you to append markup into specific set locations on some pages. These locations are commonly used areas you may want to target. If you find there are target areas outside of the currently available options, please let us know your use case and we will work to accommodate your needs.

When activated, `insert` will call a callback function you define with the `elem` and `meta` parameters.

Field Name | Purpose | Field Format
-------------- | -------------- | --------------
`elem` | The DOM element where the markup should be inserted. | Element
`meta` | The payload object for the current insertion point. | Object

## create(key, type, data)

> Create a Button

```javascript
(function(API) {
  var key = 'your-integration-key';
  var button = API.create(key, 'button', {
    text: 'Visit Google',
    src: 'https://www.google.com/',
    classes: 'btn btn-primary',
    style: 'border: 2px solid #c00',
    attributes: {
      'target': '_blank'
    }
  });
  API.log(key, button);
  // The above outputs: <a href="https://www.google.com/" class="btn btn-primary" style="border: 2px solid rgb(204, 0, 0);">Visit Google</a>
})(window.DDC.API);
```

The create method can be used to generate markup which adheres to our standard practices. This allows you to simply "create a button", for example, without having to know the inner workings of how buttons should be created on different types of sites.

Currently only the "button" type is supported, however other types will soon be added. Please let us know if there are particular types of elements you want to create so we can work to incorporate your feedback into this API.

## append(key, targetEl, appendEl)

> Usage

```javascript
window.DDC.API.append('your-integration-key', targetEl, appendEl);
```

> For example, used in conjunction with the `insert` and the `create` methods your code might look similar to this:

```javascript
(function(API) {
  var key = 'your-integration-key';
  API.insert(key, 'target-location-name', function(elem, meta) {
    var lowPrice = Math.round(meta.finalPrice - 1000);
    var highPrice = Math.round(meta.finalPrice + 1000);
    var button = API.create(key, 'button', {
      text: 'Search This Price Range',
      src: '/new-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
      classes: 'btn btn-primary',
      style: 'margin-top: 12px;',
      attributes: {
        'target': '_blank'
      }
    })
    API.append(key, elem, button);
  });
})(window.DDC.API);
```

When calling the insert method, the goal is to insert some markup into a location on the page. Once you have constructed the element(s) you wish to insert, you may call the `append` method to complete the process.

## load(key, resourceUrl)

> Usage

```javascript
window.DDC.API.load('your-integration-key', 'https://www.company.com/script.js'); // Loads a JavaScript file
window.DDC.API.load('your-integration-key', 'https://www.company.com/integration.css'); // Loads a CSS stylesheet
```

The load method is an easy way to include additional scripts or stylesheets required for your integration. Stylesheets and JavaScript files are automatically loaded in an optimal way for each type of asset.