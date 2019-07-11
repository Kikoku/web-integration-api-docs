# Insert Locations

Insert locations are areas of pages where you can safely insert markup. These exist in commonly used areas, such as below vehicle pricing on search and detail pages. This section details the current available locations. Please let us know if there are other locations you want to target beyond those listed here.

See the <a href="#ddc-api-insert-key-name-callback-elem-meta">insert documentation</a> for more details on the insert method.

## Vehicle Media

> Usage:

```javascript
DDC.API.insert('your-integration-key', 'vehicle-media', function(elem, meta) {
  // This element is positioned below the vehicle image area on vehicle search pages.
});
```

This element is positioned below the vehicle image area on vehicle search pages.

## Vehicle Badge

> Usage:

```javascript
DDC.API.insert('your-integration-key', 'vehicle-badge', function(elem, meta) {
  // This element is positioned below the vehicle tech specs area on vehicle search and detail pages.
});
```

This element is positioned below the vehicle tech specs area on vehicle search and detail pages.


## Vehicle Pricing

> Usage:

```javascript
DDC.API.insert('your-integration-key', 'vehicle-pricing', function(elem, meta) {
  // This element is positioned below the vehicle pricing area on vehicle search and detail pages.
});
```

This element is positioned below the vehicle pricing area on vehicle search and detail pages.

## Vehicle Media Container

> Usage:

```javascript
DDC.API.insert('your-integration-key', 'vehicle-media-container', function(elem, meta) {
  // This element is the media gallery container on vehicle deals pages.
  // Injecting into this location will replace the media gallery with the elements you insert.
});
```

This element is the media gallery container on vehicle deals pages. Injecting into this location will replace the media gallery with the elements you insert.
