# API Methods

## API.subscribe(name, callback(event))

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.subscribe('event-name-and-version', ev => {
    API.log(ev);
  });
})(window.DDC.APILoader);
```
Please see the <a href="#event-subscriptions">specific event documentation</a> for more detail on the available events and the data payload sent to your callback function.

## API.insertCallToAction(type, intent, setupFunction(meta))

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.insertCallToAction('button', 'value-a-trade', meta => {
    return {
      type: 'default',
      href: 'https://www.yourdomain.com/value-a-trade/?vin=' + meta.vin,
      target: '_blank',
      text: {
        en_US: 'Value My Trade',
        fr_CA: 'Valeur mon commerce'
      }
    }
  });
})(window.DDC.APILoader);
```

The `insertCallToAction` method is used to create a call to action (CTA) button for placement on web site inventory items. Rather than generating markup and inserting it into a predefined location, when using this method you specify the CTA type (`button` is currently the only supported type), an intent (more on this below), and a data object describing the CTA's attributes. The data object follows the same pattern as the object passed into the <a href="#api-create-type-options">API.create method</a> which you can use as a reference to see all available config options.

Parameter Name | Purpose | Field Format
-------------- | -------------- | --------------
`type` | The type of CTA that should be inserted. | String
`intent` | The intention of the CTA you are inserting. | String
`setupFunction(meta)` | The payload object for the current vehicle. You return a data object from this method. | Object

`setupFunction` is called for each inventory item presented on the page. The `meta` field provided is the <a href="#vehicle-event">Vehicle Event</a> payload. You can use the vehicle data to construct an object describing your CTA's attributes, then return it back to the API. With the data returned from `setupFunction`, the API creates the markup for your button and places it into the CTA area on each vehicle card on the search results page and/or the CTA area on the vehicle details page. The placement depends on how you set up your code and the integration's configuration options for the given site.

This method acts as an event subscription, so as the application displays new vehicles dynamically (a single page application), new events are fired and `setupFunction` is automatically called for each of those new items. This works well for a basic use case where you want to place content on every item having the target location, or every item matching specific criteria available to you in the `setupFunction` payload. If you need to execute intermediary code before determining if you need to insert content, such as calling an external service, you should use the <a href="#api-insertcalltoactiononce-type-intent-setupfunction-meta">`insertCallToActionOnce`</a> method instead.

The default location for a CTA is the bottom of the existing CTA list on vehicle search results and details pages.

<p><img src="images/srp-cta-location.jpg" alt="SRP CTA Location" /></p>

However, by using this method it enables Dealer.com to reorder the location of your CTA in the list and even map it to "take over" an existing CTA. For example, if a dealer has a custom styled E-Price button and wants your CTA to replace the standard functionality for that feature on their site, we can map your CTA to replace the default functionality. If your code fails to load for some reason, the default behavior of that button still takes effect and ensures that site users can still submit leads, etc.

### CTA Type

The current supported type is `button`, though other types may be added in the future. We currently only support text-based buttons.

### CTA Intent

Button Intent is a concept used in the API as a way to categorize the type of functionality your CTA provides. The current supported intent types are:

`chat`

`check-availability`

`eprice`

`payment-calculator`

`pre-approval`

`request-a-quote`

`reserve-it-now`

`send-to-phone`

`social`

`test-drive`

`text-us`

`value-a-trade`

`window-sticker`

If you have a CTA that does not align with one of these types, please let us know and we will consider adding it to the API.

### Callback Format

The callback function for this method is used to create a data object describing the CTA you want to place on the page. The format of this object is described below.

Field Name | Purpose | Example Value(s) | Field Format
-------------- | -------------- | -------------- | --------------
`type` | The style of CTA that should be inserted. | `default`, `primary` | String
`classes` | A space delimited list of class names to add to the CTA. | `custom-class1 custom-class2` | String
`href` | The URL to access when the CTA is clicked. Must begin with `https://`. | `https://www.yourdomain.com/` | String
`target` | The link target. | `_blank`, `_self` | String
`onclick` | A function to attach as a click handler to the CTA. | `window.MyIntegation.clickFunction` | Function
`text` | An object supplying text for the CTA in one or more languages. `en_US` is required at minimum. `fr_CA` is highly recommended. | See usage example | Object
`attributes` | An object of `data-` attributes to add to the CTA. |  | String

After creating the callback object, you must then return it for the API to create your CTA. If you do not return anything or return `null`, no CTA will be inserted for that vehicle item.

## API.insertCallToActionOnce(type, intent, setupFunction(meta))

> Functional example

```javascript
(async APILoader => {

  // Initialize an instance of the API
  const API = await APILoader.create(document.currentScript);

  // Receive a notification each time vehicle data is updated on the page (or a new page is loaded).
  API.subscribe('vehicle-data-updated-v1', ev => {

    // Collect the VIN for each vehicle on the page in an array.
    API.utils.getAttributeForVehicles('vin').then(vins => {
      API.log("Calling service with these VINs: " + vins.join(','));

      // Fetch data from your endpoint by supplying the list of VINs.
      fetch('https://www.yourdomain.com/api/endpoint-that-returns-json?vins=' + vins.join(','))
      .then(response => {
        return response.json();
      })
      .then(serviceData => {
        // Now that you have your service data, you can determine whether or not to place a CTA for this vehicle on the page.
        API.insertCallToActionOnce('button', 'value-a-trade', meta => {
          if (serviceData.hasOwnProperty(meta.vin)) {
            return {
              type: 'default',
              classes: 'custom-class1 custom-class2',
              href: 'https://www.yourdomain.com/value-a-trade/?vin=' + meta.vin,
              target: '_blank',
              text: {
                en_US: 'Value My Trade',
                fr_CA: 'Valeur mon commerce'
              }
            }
          } else {
            API.log("Skipping vehicle " + meta.vin + " because it does not have service data.");
          }
        });
      });
    });
  });
})(window.DDC.APILoader);
```

You may prefer to only insert a CTA when you are ready, after performing other functions. For example, if you need to make a service call to your system with a list of vehicles to determine which ones have data on your side, and only then add CTAs to supported vehicles. With `insertCallToActionOnce`, the method behaves as a functional insert which can be chained with other functions, and does not behave as a subscription. With `API.insertCallToActionOnce`, you will need to invoke it inside of a <a href="#vehicle-data-updated-v1">`vehicle-data-updated-v1`</a> subscription so that your code is triggered each time the list of vehicles is loaded on a page rather than only the first time.

Field Name | Purpose | Field Format
-------------- | -------------- | --------------
`type` | The type of CTA that should be inserted. | String
`intent` | The intention of the CTA you are inserting. | String
`setupFunction(meta)` | The payload object for the current vehicle. | Object

## API.insertGalleryContent(target, objOrArray)

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.insertGalleryContent('vehicle-media', [
    {
      type: 'image',
      position: 'primary',
      src: 'https://yourdomain.com/primary.jpg',
      thumbnail: 'https://yourdomain.com/primary-thumb.jpg'
    },
    {
      type: 'image',
      position: 'secondary',
      src: 'https://yourdomain.com/secondary.jpg',
      thumbnail: 'https://yourdomain.com/secondary-thumb.jpg'
    },
    {
      type: 'image',
      position: 'last',
      src: 'https://yourdomain.com/last.jpg',
      thumbnail: 'https://yourdomain.com/last-thumb.jpg'
    }
  ]);
})(window.DDC.APILoader);
```

The `insertGalleryContent` method allows you to add media to media galleries across various pages of Dealer.com sites. The only currently supported target is `vehicle-media`, which will insert media into the media carousel of Vehicle Details Pages.

`objOrArray` is an array of objects describing the media to be inserted. If you have a single image, you can pass a single object instead. Each object has a `type` field to specify the type of media to be inserted. The only currently supported media type is `image`.

The `image` type supports the following additional attributes:

Name | Description
-------------- | --------------
`position` | Where to insert the image. `primary` is used for content that should be displayed to the user as soon as it loads -- as long as the user has not explicitly performed an action to look at pre-existing media. `secondary` is used for content that should be displayed soon, but not replace the pre-existing main image. `last` is used to append content to the end of an existing gallery.
`src` | HTTPS url to the image to be inserted.
`thumbnail` | HTTPS url to a thumbnail of the image to be inserted. For performance, it is ideal to provide a low resolution thumbnail that can be used for a preview of the inserted image, however, `src` will be used if `thumbnail` is not provided.

## API.insert(name, callback(elem, meta))

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.insert('location-name', (elem, meta) => {
    API.log(elem); // The DOM element where markup may be inserted.
    API.log(meta); // The payload object for the current insertion point.
  });
})(window.DDC.APILoader);
```

The insert method allows you to append markup to specific locations on some pages of Dealer sites. These locations are commonly targeted areas where you may want to place content.

When activated, `API.insert` will call the callback function you define with the `elem` and `meta` parameters. It will call this for each relevant location on the page. For example, if you specify `vehicle-media` as the location and you are viewing a search results page with 30 vehicles, the callback function you define on `API.insert` will be called 30 times, once per vehicle, with the relevant location and vehicle data in the payload.

This acts as an event subscription, so as the application displays new vehicles dynamically (a single page application), new events are fired and your callback is immediately called for each of those new items. This works well for a basic use case where you want to place content on every item having the target location, or every item matching specific criteria available to you in the callback payload.

If you need to execute additional code before determining if you wish to insert content, such as calling an external service, you should use the `insertOnce` method instead in combination with the `vehicle-data-updated-v1` event as shown in the example here.

## API.insertOnce(name, callback(elem, meta))

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  // Receive a notification each time vehicle data is updated on the page (or a new page is loaded).
  API.subscribe('vehicle-data-updated-v1', ev => {
    // Insert content into each vehicle location now present on the page.
    API.insertOnce('location-name', (elem, meta) => {
      API.log(elem); // The DOM element where markup may be inserted.
      API.log(meta); // The payload object for the current insertion point.
    });
  });
})(window.DDC.APILoader);
```

> Functional example

```javascript
(async APILoader => {

  // Initialize an instance of the API
  const API = await APILoader.create(document.currentScript);

  // Receive a notification each time vehicle data is updated on the page (or a new page is loaded).
  API.subscribe('vehicle-data-updated-v1', ev => {

    // Collect the VIN for each vehicle on the page in an array.
    API.utils.getAttributeForVehicles('vin').then(vins => {
      API.log("Calling service with these VINs: " + vins.join(','));

      // Fetch data from your endpoint by supplying the list of VINs.
      fetch('https://www.yourdomain.com/api/endpoint-that-returns-json?vins=' + vins.join(','))
      .then(response => {
        return response.json();
      })
      .then(serviceData => {
        // Now that you have your service data, you can determine whether or not to place content for this location on to the page.
        API.insertOnce('vehicle-badge', (elem, meta) => {
          // Verify my service has data for this vehicle
          if (serviceData.hasOwnProperty(meta.vin)) {

            // Create your markup here
            const div = document.createElement('div');
            div.innerText = "Hello World!";

            // Insert your markup into the parent element.
            API.append(elem, div);
          } else {
            API.log("Skipping vehicle " + meta.vin + " because it does not have service data.");
          }
        });
      });
    });
  });
})(window.DDC.APILoader);

```

You may prefer to only insert content when you are ready, after performing other functions. For example, if you need to make a service call to your system with a list of vehicles to determine which ones have data on your side, and only then decorate specific vehicles with appropriate content. With `insertOnce`, the method behaves as a functional insert which can be chained with other functions, and does not behave as a subscription. With `API.insertOnce`, you will need to invoke it inside of a <a href="#vehicle-data-updated-v1">`vehicle-data-updated-v1`</a> subscription so that your code is triggered each time the list of vehicles is loaded on a page rather than only the first time.

Field Name | Purpose | Field Format
-------------- | -------------- | --------------
`location` | The DOM element where the markup should be inserted. | Element
`callback(elem, meta)` | The DOM element where the markup should be inserted, and the payload object for the current insertion point. | Element, Object


## API.updateLink(intent, setupFunction(meta))
The `updateLink` method is used to override links on the page where the integration is enabled. 

Field Name | Purpose | Field Format
-------------- | -------------- | --------------
`intent` | The functionality of the overriding links. | String
`setupFunction(meta)` | The payload object for the current page. | Object

Currently, we support `x-time` and `schedule-service` link intents.

And, we only support limited attributes of the link to be modified in order to preserve the look and feel of the link.
The attributes that can be modified are `href`, `target`, `onclick`, `popover` and `attributes (data-*)`.

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.updateLink('x-time', meta => {
    return {
      href: 'https://www.yourdomain.com/?account=' + meta.accountId,
      target: '_blank',
    }
  });
})(window.DDC.APILoader);
```

## API.create(type, options)

> Create a Button

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  const button = API.create('button', {
    href: 'https://www.google.com/',
    text: {
      'en_US': 'Visit Google', // English
      'fr_CA': 'Visitez Google', // French
      'es_MX': 'Visite Google' // Spanish
    },
    classes: 'btn btn-primary',
    style: 'border: 2px solid #c00',
    attributes: {
      'data-custom-attribute': 'attribute-value',
      'target': '_blank'
    },
    imgSrc: 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
    imgAlt: {
      'en_US': 'Visit Google', // English
      'fr_CA': 'Visitez Google', // French
      'es_MX': 'Visite Google' // Spanish
    },
    imgClasses: 'custom-image-class another-class',
    imgAttributes: {
      'data-image-attribute': 'image-attribute-value'
    },
    onclick: () => {
      window.MyIntegration.activateModalOverlay();
    }
  });
  return button;
})(window.DDC.APILoader);
```

> The above example generates this markup:

```html
<a href="https://www.google.com/" class="btn btn-primary mb-3" data-custom-attribute="attribute-value" target="_blank" style="border: 2px solid rgb(204, 0, 0);">
  <img src="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" alt="Visit Google" class="custom-image-class another-class" data-image-attribute="image-attribute-value">
</a>
```

The create method can be used to generate markup which adheres to our standard practices. This allows you to simply "create a button", for example, without having to know the inner workings of how buttons should be created on different types of sites.

Currently only the "button" type is supported, however other types may be added in the future. Please let us know if there are particular types of elements you want to create so we can work to incorporate your feedback into this API.

The available options for the `button` type are as follows:

Field Key | Example Value | Field Format | Purpose
-------------- | -------------- | -------------- | --------------
`href` | `https://www.google.com/` | `String` | The link URL. Must begin with `https://`.
`text` | `See functional example.` | `Object` | The localized button text object.
`classes` | `btn btn-primary` | `String` | Classes to place on the link element.
`style` | `border: 2px solid #c00` | `String` | Inline styles to place on the link element.
`attributes` | `See functional example.` | `Object` | An object of key/value pairs to add to the link element as attributes.
`imgSrc` | `https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png` | `String` | The URL to the button image.
`imgAlt` | `See functional example.` | `Object` | The localized image alt text object.
`imgClasses` | `custom-image-class another-class` | `String` | Classes to place on the image.
`imgAttributes` | `See functional example.` | `Object` | An object of key/value pairs to add to the image element as attributes.
`onclick` | `See functional example.` | `Function` | The onclick handler to attach to the button.


## API.append(targetEl, appendEl)

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.append(targetEl, appendEl);
})(window.DDC.APILoader);
```

> For example, used in conjunction with the `insert` and the `create` methods your code might look similar to this:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.insert('target-location-name', (elem, meta) => {
    let lowPrice = Math.round(meta.finalPrice - 1000);
    let highPrice = Math.round(meta.finalPrice + 1000);
    const button = API.create('button', {
      text: 'Search This Price Range',
      href: '/new-inventory/index.htm?internetPrice=' + lowPrice.toString() + '-' + highPrice.toString(),
      classes: 'btn btn-primary',
      style: 'margin-top: 12px;',
      attributes: {
        'target': '_blank'
      }
    })
    API.append(elem, button);
  });
})(window.DDC.APILoader);
```

When calling the insert method, the goal is to insert some markup into a location on the page. Once you have constructed the element(s) you wish to insert, you may call the `append` method to complete the process.

## API.loadJS(resourceUrl)

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  // Loads a JavaScript file
  API.loadJS('https://www.company.com/script.js')
    .then(() => {
      // Code to execute after your JavaScript file has loaded.
    });
})(window.DDC.APILoader);
```

The loadJS method is a simple way to include additional JavaScript files required for your integration. The method returns a JavaScript Promise which you can use to know when file loading is complete, to then run any necessary initialization functions, etc.

## API.loadCSS(resourceUrl)

> Usage

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  // Loads a CSS stylesheet
  API.loadCSS('https://www.company.com/integration.css')
    .then(() => {
      // Code to execute after your stylesheet has loaded.
    });
})(window.DDC.APILoader);
```

The loadCSS method is a simple way to include an additional CSS stylesheet file required for your integration. The method returns a JavaScript Promise which you can use to know when stylesheet loading is complete, to then insert markup that depends on that styling to avoid display a flash of unstyled content.
