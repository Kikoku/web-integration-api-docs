# Example Implementation

```javascript
(function(API) {
  var integrationKey = 'your-integration-key';
  API.subscribe(integrationKey, 'page-load-v1', function (ev) {
    if (ev.payload.searchPage) {
      API.insert(integrationKey, 'vehicle-pricing', function (elem, meta) {
        var lowPrice = Math.round(meta.finalPrice - 1000);
        var highPrice = Math.round(meta.finalPrice + 1000);
        var button = API.create(integrationKey, 'button', {
          text: 'Search This Price Range',
          src: '/new-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
          classes: 'btn btn-primary',
          style: 'margin-top: 12px;'
        })
        API.append(integrationKey, elem, button);
      });
    }
  });
})(window.DDC.API);
```

Some parts of the example to the right have been used in the above documentation. In its entirety, the 20 lines of code perform the following steps:

1. Subscribe to the `page-load-v1` event to get context for this page view.
2. If this is the vehicle search page, subscribe to the `vehicle-pricing` location inserter.
3. For each vehicle pricing area on the current page, generate the button markup using the `create` method.
4. Finally, use the `append` method to insert the new button into each pricing area.
