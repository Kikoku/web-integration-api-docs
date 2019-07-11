# Requirements

## Integrated Partner Program

The use of this API requires that you are enrolled in our Integrated Partner Program. To find out more information or to enroll, please contact us at <a href="mailto:IntegratedPartners@coxautoinc.com"> IntegratedPartners@coxautoinc.com</a> or <a href="https://forms.dealer.com/integrated-partner-program.htm" target="_blank">fill out this form</a>.

Once enrolled, you will be provided with an integration key to use when making API calls.

## Bootstrapping Your Script

It's a good idea to start by creating a simple JavaScript file that registers with the API (subscribe) and potentially loads additional scripts if necessary. When you want to test a script on our platform, send us the URL to the script so we can include it on the page when we enable your integration. The script should be as minimal as possible and perform only actions necessary to bootstrap your integration on to the site. There is a minimal subscribe example here, and you can see a more detailed <a href="#example-implementation">Example Implementation</a> for an idea of how to accomplish some common tasks.

```javascript
(function(API) {
  var integrationKey = 'your-integration-key';
  API.subscribe(integrationKey, 'page-load-v1', function (ev) {
    if (ev.payload.indexPage) {
        console.log('This is the index page');
    }
  });
})(window.DDC.API);
```

## Technical Requirements

> This is an example of an immediately executing function expression:

```javascript
(function(API) {
	// API.subscribe(...);
	// Your code here
})(window.DDC.API);
```
* Always ecapsulate your code in an immediately executing function expression to avoid polluting the global namespace. See sidebar for example of such a function.

* Your bootstrap script and any other integration code or assets should be located on a highly available content delivery network and must work over an HTTPS connection.

* All code should be minified and served using gzip or better compression.

* Integrations should avoid loading excessive imagery, fonts and scripts.

* Please refrain from including large libraries such as jQuery.




