# Insert Locations

Insert locations are areas of pages where you can safely insert markup. These exist in commonly used areas, such as below vehicle pricing on search and detail pages. This section details the current available locations. Please let us know if there are other locations you want to target beyond those listed here.

See the <a href="#api-insert-name-callback-elem-meta">insert documentation</a> for more details on the insert method.

## Vehicle Media

> Usage:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.insert('vehicle-media', function(elem, meta) {
    // This element is positioned below the vehicle image area on vehicle search pages.
  });
})(window.DDC.API);
```

> Example Implementation:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.subscribe('page-load-v1', function(ev) {
    if (ev.payload.searchPage) {
      API.insert('vehicle-media', function(elem, meta) {
        var button = API.create('button', {
          text: 'Watch Video',
          href: 'https://www.providerdomain.com/path/video-player.html?vin=' + meta.vin,
          classes: 'btn btn-primary dialog',
          style: 'margin-top: 12px;',
          attributes: {
            'target': '_blank'
          }
        });
        API.append(elem, button);
      });
    }
  });
})(window.DDC.API);
```

This element is positioned below the vehicle image area on vehicle search pages.

## Vehicle Badge

> Usage:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.insert('vehicle-badge', function(elem, meta) {
    // This element is positioned below the vehicle tech specs area on vehicle search and detail pages.
  });
})(window.DDC.API);
```

> Example Implementation:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.subscribe('page-load-v1', function(ev) {
    if (ev.payload.searchPage || ev.payload.detailPage) {
      API.insert('vehicle-badge', function(elem, meta) {
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

        API.append(elem, a);
      });
    }
  });
})(window.DDC.API);
```

This element is positioned below the vehicle tech specs area on vehicle search and detail pages.


## Vehicle Pricing

> Usage:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.insert('vehicle-pricing', function(elem, meta) {
    // This element is positioned below the vehicle pricing area on vehicle search and detail pages.
  });
})(window.DDC.API);
```

> Example Implementation:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.subscribe('page-load-v1', function(ev) {
    // Only execute the code on search results and vehicle details pages.
    if (ev.payload.searchPage || ev.payload.detailPage) {
      API.insert('vehicle-pricing', function (elem, meta) {
        var lowPrice = Math.round(meta.finalPrice - 1000);
        var highPrice = Math.round(meta.finalPrice + 1000);
        var button = API.create('button', {
          text: 'Search This Price Range',
          href: '/' + meta.inventoryType + '-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
          classes: 'btn btn-primary',
          style: 'margin-top: 12px;'
        })
        API.append(elem, button);
      });
    }
  });
})(window.DDC.API);
```

This element is positioned below the vehicle pricing area on vehicle search and detail pages.

## Vehicle Media Container

> Usage:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.insert('vehicle-media-container', function(elem, meta) {
    // This element is the media gallery container on vehicle deals pages.
    // Injecting into this location will replace the media gallery with the elements you insert.
  });
})(window.DDC.API);
```

> Example Implementation:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.subscribe('page-load-v1', function(ev) {
    if (ev.payload.detailPage) {
      API.insert('vehicle-media-container', function(elem, meta) {
        var containerEl = document.createElement('div');
        containerEl.style = 'background-color: #ff0000; font-size: 30px; width: 100%; height: 540px; margin: 0 auto; padding: 100px; text-align: center;';
        containerEl.innerHTML = 'Your media container goes here.';
        API.append(elem, containerEl);
      });
    }
  });
})(window.DDC.API);
```

This element is the media gallery container on vehicle deals pages. Injecting into this location will replace the media gallery with the elements you insert.

## Primary Banner

> Usage:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.insert('primary-banner', function(elem, meta) {
    // This element is typically positioned in a prominent location above the vehicle listings on the Search Results Page.
    // On the Details page, it is near the top of the vehicle information, below the media gallery.
  });
})(window.DDC.API);
```

> Example Implementation:

```javascript
(function(WIAPI) {
  var API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.subscribe('page-load-v1', function(ev) {
    if (ev.payload.searchPage || ev.payload.detailPage) {
      API.insert('primary-banner', function(elem, meta) {
        var img = document.createElement('img'),
          a = document.createElement('a');

        img.src = 'https://pictures.dealer.com/d/ddcdemohonda/0217/15bd9bd8ecf0b2a292a91cecb08c595bx.jpg';
        img.alt = 'New 2015 Honda Pilot';
        img.title = 'New 2015 Honda Pilot';

        a.href = '/specials/new.htm';
        a.innerHTML = img.outerHTML;

        API.append(elem, a);
      });
    }
  });
})(window.DDC.API);
```

This element is positioned in a prominent location above the vehicle listings on the Search Results Page.

On the Details page, it is positioned at the top of the vehicle information, below the media gallery.

You can target either the listings or details page by first subscribing to the page-load-v1 event, and using the event values of `payload.searchPage` and `payload.detailPage` to check the page type.
