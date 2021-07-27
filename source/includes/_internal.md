# DDC Specific Documentation

## API.updateLink(intent, setupFunction(meta))
The `updateLink` method is used to override links on the page where the integration is enabled. 
In order to use this functionality the integration's schema in WISE needs to have a content mapping entry with the content type as `links`.
The purpose of content needs to be the overriding links functionality (eg, X-Time). Then we just need to select all the PageAlias that we would like to target.
The PageAlis list can be overriden in the site level to capture any sitebuilder pages as well.

The WIAPI would deduce the link of the corresponding PageAlias in the site level letting you to modify the link element.

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

## Content Modification (deprecated)

The `updateLink` method would be replacing this functionality.

This method allows you to modify content on a page level. Right now we only support the modification of the `schedule-service` button. So, by using this method you would be able to modify the link attributes of all the schedule service buttons on a page.

> Usage:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.modifyContent('schedule-service', {
    schema: {
      // Attributes of the link you want to add or modify
    }
  });
})(window.DDC.APILoader);
```

> Schema Object:

```javascript
{
  "href": "String", // Link to a new service page
  "target": "String", // Set the target attribute of the anchor tag
  "onclick": "Function", // Set an onClick event handler for the button. Remember to reset the href of the button while setting a click event.
  "popover": "Object", // Popover settings for your button, eg {title: "heading", content: "popover text"}
  "attributes": "Object" // List of all data attributes that you would want to add to the button
}
```

> Example Implementation:

```javascript
(async APILoader => {
  const API = await APILoader.create(document.currentScript);
  API.modifyContent('schedule-service', {
    schema: {
      "href": "/schedule-form.htm",
      "target": "_blank",
      "attributes": {
        "data-width": "400px",
        "data-title": "My custom service"
      }
	  }
  });
})(window.DDC.APILoader);
```
