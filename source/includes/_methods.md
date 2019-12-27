# API Methods

## subscribe(name, callback(event))

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.subscribe('event-name-and-version', function(event) {
    API.log(event);
  });
})(window.DDC.API);
```
Please see the <a href="#event-subscriptions">specific event documentation</a> for more detail on the available events and the data payload sent to your callback function.

## insert(name, callback(elem, meta))

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.insert('location-name', function(elem, meta) {
    API.log(elem); // The DOM element where markup may be inserted.
    API.log(meta); // The payload object for the current insertion point.
  });
})(window.DDC.API);
```

The insert method allows you to append markup into specific set locations on some pages. These locations are commonly used areas you may want to target. If you find there are target areas outside of the currently available options, please let us know your use case and we will work to accommodate your needs.

When activated, `insert` will call a callback function you define with the `elem` and `meta` parameters.

Field Name | Purpose | Field Format
-------------- | -------------- | --------------
`elem` | The DOM element where the markup should be inserted. | Element
`meta` | The payload object for the current insertion point. | Object

## create(type, data)

> Create a Button

```javascript
(function(WPAPI) {
  var API = new WPAPI();
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

## append(targetEl, appendEl)

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  API.append(targetEl, appendEl);
})(window.DDC.API);
```

> For example, used in conjunction with the `insert` and the `create` methods your code might look similar to this:

```javascript
(function(WPAPI) {
  var API = new WPAPI();
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

## loadJS(resourceUrl)

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  // Loads a JavaScript file
  API.loadJS('https://www.company.com/script.js')
    .then(function() {
      // Code to execute after your JavaScript file has loaded.
    });
})(window.DDC.API);
```

The loadJS method is a simple way to include additional JavaScript files required for your integration. The method returns a JavaScript Promise which you can use to know when file loading is complete, to then run any necessary initialization functions, etc.

## loadCSS(resourceUrl)

> Usage

```javascript
(function(WPAPI) {
  var API = new WPAPI();
  // Loads a CSS stylesheet
  API.loadCSS('https://www.company.com/integration.css')
    .then(function() {
      // Code to execute after your stylesheet has loaded.
    });
})(window.DDC.API);
```

The loadCSS method is a simple way to include an additional CSS stylesheet file required for your integration. The method returns a JavaScript Promise which you can use to know when stylesheet loading is complete, to then insert markup that depends on that styling to avoid display a flash of unstyled content.
