# Debugging / Troubleshooting

When developing an integration, it's helpful to know if the API is doing what you expect and if your code is running successfully. The API intentionally suppresses most errors in regular use cases, however you can opt to view the error messages and API events by adding the following URL parameter to any page of any Dealer.com web site:

`?_integrationMode=debug`

This will allow the API to output some log messages to your browser's console regarding the actions it is taking. Additionally, you can instrument your own integration with log messages to validate that the expected code is being executed and desired code paths are being followed.

To log messages from within your integration code, simply use the `API.log` method the same way you would use `console.log`. Those messages will be output to your console when the above URL parameter is present and will be suppressed when it is not.

> Example Implementation:

```javascript
(function(API) {
  var integrationKey = 'test-integration';
  API.subscribe(integrationKey, 'page-load-v1', function (ev) {
    if (ev.payload.searchPage) {
      API.log(integrationKey, "My integration has loaded and this is a search page.");
    }
  });
})(window.DDC.API);
```
