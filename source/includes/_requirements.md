# Requirements

## Integrated Partner Program

The use of this API requires that you are enrolled in our Integrated Partner Program. To find out more information or to enroll, please contact Chris Vargo at <a href="mailto:Chris.Vargo@coxautoinc.com">Chris.Vargo@coxautoinc.com</a>.

Once enrolled, you will be provided with an integration key to use when making API calls.

## Bootstrapping Your Script

Once you have written a script to interface with the API and want to try it on specific sites, send us the URL to the script so we can include it when we enable your integration. The script should be as minimal as possible and perform only actions necessary to bootstrap your integration on to the site. See the <a href="#example-implementation">Example Implementation</a> for an idea of how to accomplish some common tasks.

## Technical Requirements

> This is an example of an immediately executing function expression:

```javascript
(function(API) {
	// API.subscribe(...);
	// Your code here
})(window.DDC.API);
```
* Always wrap all of your code in an immediately executing function expression to avoid polluting the global namespace. See sidebar for example of such a function.

* Your bootstrap script and any other integration code or assets should be located on a highly available content delivery network and must work over an HTTPS connection.

* All code should be minified and served using gzip or better compression.

* Integrations should avoid loading excessive imagery, fonts and scripts.

* Please refrain from including large libraries such as jQuery or React (both are already available).
