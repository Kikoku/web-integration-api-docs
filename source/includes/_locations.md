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

> Example Implementation:

```javascript
(function(API) {
  var integrationId = 'test-integration';
  API.subscribe(integrationId, 'page-load-v1', function (ev) {
    if (ev.payload.searchPage) {
      API.insert(integrationId, 'vehicle-media', function (elem, meta) {
        var button = API.create(integrationKey, 'button', {
          text: 'Watch Video',
          src: 'https://www.providerdomain.com/path/video-player.html?vin=' + meta.vin,
          classes: 'btn btn-primary dialog',
          style: 'margin-top: 12px;'
        });
        API.append(integrationId, elem, a);
      });
    }
  });
})(window.DDC.API);
```

This element is positioned below the vehicle image area on vehicle search pages.

## Vehicle Badge

> Usage:

```javascript
DDC.API.insert('your-integration-key', 'vehicle-badge', function(elem, meta) {
  // This element is positioned below the vehicle tech specs area on vehicle search and detail pages.
});
```

> Example Implementation:

```javascript
(function(API) {
  var integrationId = 'test-integration';
  API.subscribe(integrationId, 'page-load-v1', function (ev) {
    if (ev.payload.searchPage) {
      API.insert(integrationId, 'vehicle-badge', function (elem, meta) {
        if (meta.inventoryType !== 'used') {
          return;
        }

        var img = document.createElement('img'),
          a = document.createElement('a');

        img.src = 'https://static.dealer.com/v8/global/images/franchise/white/logo-certified-carfax-free-lrg.png';
        img.alt = 'Carfax Free Report';

        a.href = 'https://www.carfax.com/VehicleHistory/p/Report.cfx?partner=DLR_3&vin=' + meta.vin;
        a.target = '_blank';
        a.innerHTML = img.outerHTML;

        API.append(integrationId, elem, a);
      });
    }
  });
})(window.DDC.API);
```

This element is positioned below the vehicle tech specs area on vehicle search and detail pages.


## Vehicle Pricing

> Usage:

```javascript
DDC.API.insert('your-integration-key', 'vehicle-pricing', function(elem, meta) {
  // This element is positioned below the vehicle pricing area on vehicle search and detail pages.
});
```

> Example Implementation:

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
          src: '/' + meta.inventoryType + '-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
          classes: 'btn btn-primary',
          style: 'margin-top: 12px;'
        })
        API.append(integrationKey, elem, button);
      });
    }
  });
})(window.DDC.API);
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

> Example Implementation:

```javascript
(function(API) {
  var integrationKey = 'your-integration-key';
  API.subscribe(integrationKey, 'page-load-v1', function (ev) {
    if (ev.payload.detailPage) {
      API.insert(integrationKey, 'vehicle-media-container', function (elem, meta) {
        var containerEl = document.createElement('div');
        containerEl.style = 'background-color: #ff0000; font-size: 30px; width: 100%; height: 100%';
        containerEl.innerHTML = 'Your media container goes here.';
        API.append(integrationKey, elem, containerEl);
      });
    }
  });
})(window.DDC.API);
```

This element is the media gallery container on vehicle deals pages. Injecting into this location will replace the media gallery with the elements you insert.
