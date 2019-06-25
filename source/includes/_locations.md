# Inject Locations

Inject locations are areas of pages where you can safely insert markup. These exist in commonly used locations, such as below vehicle pricing on search and detail pages. This section details the current available locations. Please let us know if there are other locations you want to target beyond those listed here.

See the <a href="#ddc-api-inject-key-name-callback-elem-meta">inject documentation</a> for more details on the inject method.

## vehicle-media-bottom

> Usage:

```javascript
DDC.API.inject('your-integration-key', 'vehicle-media-bottom', function(elem, meta) {
  // This element is positioned below the vehicle image area on vehicle search pages.
});
```

This element is positioned below the vehicle image area on vehicle search pages.

## vehicle-badge-bottom

> Usage:

```javascript
DDC.API.inject('your-integration-key', 'vehicle-badge-bottom', function(elem, meta) {
  // This element is positioned below the vehicle tech specs area on vehicle search and detail pages.
});
```

This element is positioned below the vehicle tech specs area on vehicle search and detail pages.


## vehicle-pricing-bottom

> Usage:

```javascript
DDC.API.inject('your-integration-key', 'vehicle-pricing-bottom', function(elem, meta) {
  // This element is positioned below the vehicle pricing area on vehicle search and detail pages.
});
```

This element is positioned below the vehicle pricing area on vehicle search and detail pages.

## vehicle-media-container

> Usage:

```javascript
DDC.API.inject('your-integration-key', 'vehicle-media-container', function(elem, meta) {
  // This element is the media gallery container on vehicle deals pages.
  // Injecting into this location will replace the media gallery with the elements you insert.
});
```

This element is the media gallery container on vehicle deals pages. Injecting into this location will replace the media gallery with the elements you insert.
