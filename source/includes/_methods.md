# API Methods

## DDC.API.subscribe(key, name, callback(ev))

> Usage

```javascript
DDC.API.subscribe('your-integration-key', 'event-name-and-version', function(ev) {
  console.log(ev.payload);
});
```
Please see the <a href="#event-subscriptions">specific event documentation</a> for more detail on the available events and the data payload sent to your callback function.

## DDC.API.inject(key, name, callback(elem, meta))

> Usage

```javascript
DDC.API.inject('your-integration-key', 'event-name-and-version', function(elem, meta) {
  console.log(elem); // The DOM element where the markup should be inserted.
  console.log(meta); // The standard vehicle payload object for the current insertion point.
});
```

The inject method allows you to append markup into specific set locations on some pages. These locations are commonly used areas you may want to target. If you find there are target areas outside of the currently available options, please let us know your use case and we will work to accommodate your needs.

When activated, inject will call a callback function you define with the `elem` and `meta` parameters.

Field Name | Purpose | Field Format
-------------- | -------------- | --------------
elem | The DOM element where the markup should be inserted. | Element
meta | The standard vehicle payload object for the current insertion point. | Object

## DDC.API.create(key, type, data)

> Create a Button

```javascript
(function(API) {
  var button = API.create('your-integration-key', 'button', {
    text: 'Visit Google',
    src: 'https://www.google.com/',
    classes: 'btn btn-primary',
    style: 'border: 2px solid #c00'
  });
  console.log(button);
  // The above outputs: <a href="https://www.google.com/" class="btn btn-primary" style="border: 2px solid rgb(204, 0, 0);">Visit Google</a>
})(window.DDC.API);
```

The create method can be used to generate markup which adheres to our standard practices. This allows you to simply "create a button", for example, without having to know the inner workings of how buttons should be created on sites.

Currently only the "button" type is supported, however other types will soon be added. Please let us know if there are particular types of elements you want to create so we can work to incorporate your feedback into this API.

## DDC.API.append(key, targetEl, appendEl)

> Usage

```javascript
DDC.API.append('your-integration-key', targetEl, appendEl);
```

> For example, used in conjunction with the `inject` and the `create` methods your code might look similar to this:

```javascript
(function(API) {
  var key = 'your-integration-key';
  API.inject(key, 'target-location-name', function(elem, meta) {
    var lowPrice = Math.round(meta.finalPrice - 1000);
    var highPrice = Math.round(meta.finalPrice + 1000);
    var button = API.create(key, 'button', {
      text: 'Search This Price Range',
      src: '/new-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
      classes: 'btn btn-primary',
      style: 'margin-top: 12px;'
    })
    API.append(key, elem, button);
  });
})(window.DDC.API);
```

When calling the inject method, the goal is to insert some markup into a location on the page. Once you have constructed the element(s) you wish to insert, you may call the `append` method to complete the process.

## DDC.API.load(key, resourceUrl)

> Usage

```javascript
DDC.API.load('your-integration-key', 'https://www.company.com/script.js') // Loads a JavaScript file
DDC.API.load('your-integration-key', 'https://www.company.com/integration.css') // Loads a CSS stylesheet
```

The load method is an easy way to include additional scripts or stylesheets required for your integration.
