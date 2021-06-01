# DDC Specific Documentation

## Content Modification

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
