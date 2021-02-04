# Requirements

## Integrated Partner Program

The use of this API requires that you are enrolled in our Integrated Partner Program. To find out more information or to enroll, please contact us at <a href="mailto:IntegratedPartners@coxautoinc.com"> IntegratedPartners@coxautoinc.com</a> or <a href="https://forms.dealer.com/integrated-partner-program.htm" target="_blank">fill out this form</a>.

Once enrolled, you will be provided with an integration key to use when making API calls.

## Bootstrapping Your Script

Start by creating a simple JavaScript file that registers with the API and loads additional scripts or styling if necessary. You can leverage the available API capabilities in your script to place content on pages, or include existing integration code if necessary. Your script should eventually be hosted on a content delivery network such as Cloudfront or Akamai, but for development purposes you can host it anywhere.

When you begin development of your script, it's easy to test on any Dealer.com site to see how it will function. To accomplish that, follow these steps:

*1.)* Load any Dealer.com site where you want to test your integration. If you don't already have a site in mind, a good one to start with is <a href="https://www.roimotors.com/" target="_blank">https://www.roimotors.com/</a>.

*2.)* Open the developer tools in your browser and enter this code in the Console window:

```javascript
(WIAPI => {
  const API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
  API.test('https://www.yourdomain.com/your-javascript-file.js');
})(window.DDC.API);
```

This will set a cookie in your browser and instruct the site to load your defined script as if the integration was enabled. The code will only load for you in the current browser session so that you are able to iterate and test your code. When it is ready for activation on sites, we can set the integration up in our system and load your script for all users of the site(s) where it should be enabled. The set cookie expires when your browser session expires or you clear your browser cookies.

*3.)* Add the `?_integrationMode=debug` URL parameter to the page you are testing to activate the cookied script for your page view. This will also provide an additional benefit of any <a href="#debugging">logged messages</a> in your script being output to the browser console for troubleshooting and debugging purposes.

Other methods:

* You can accomplish the same test setup as above by installing a browser extension such as <a href="https://chrome.google.com/webstore/detail/custom-javascript-for-web/poakhlngfciodnhlhhgnaaelnpjljija" target="_blank">Custom JavaScript for web sites</a> and loading your script using that mechanism. This will not require the `?_integrationMode=debug` parameter for the code to be executed on the site, however it's a good idea to use that parameter either way for <a href="#debugging-troubleshooting">better debugging output</a> in your browser console.

* Alternate to both of the above methods, we can create a test site for you and specify the script to include on the site. This will make your integrated code available for all viewers of the test site which is useful in a setting where multiple stakeholders or developers want to see the integration in development or for testing purposes.

Your code should be minimal and perform only actions necessary to bootstrap your integration on to the site. See the Technical Requirements below for more detail on this point.

## Technical Requirements

> This is an example of an immediately executing function expression:

```javascript
(WIAPI => {
	const API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.
	// API.subscribe(...);
	// Your code here
})(window.DDC.API);
```
* **Avoid Global Scope Pollution** - Always ecapsulate your code in an immediately executing function expression to avoid polluting the global namespace. See sidebar for example of such a function.

* **Avoid Duplicate Code** - Please refrain from including large libraries such as jQuery or React, as both are already available on all pages of all of our sites. Avoid polyfilling items that DDC already polyfills.

* **Minification and Compression** - All code should be minified and served using gzip or better compression.

* **Minimize Asset Size** - Integrations should avoid loading excessive imagery, fonts and scripts. While some are often necessary, less is more and avoiding loading duplicate scripts will help reduce load time for your integration as well as improve overall website speed.

* **Minimize Domains** - Serve content from as few domains as possible to reduce the number of https connections the browser must make.

* **Minimize Files** - Serve content from as few files as possible to allow for optimal downloads.

* **Minimize Requests** - Requests to services necessary for your integration to function should be as minimal as possible. For example, on a search results page with 30 vehicles, you should make a single batch request to gather data for those vehicles rather than 30 individual requests.

* **Delay Load Content** - A good way to optimize your integration is to do less work on initial page load, and to only do the remaining work on demand. For example, if your integration inserts a Call To Action button, banner or other "point of entry" and when clicked that opens your tool in an overlay, consider waiting to load the code for that overlay until the user clicks the button. You can leverage the API to insert the button with a very small amount of code. When clicked, a function can be called to load the remaining code for your overlay and then fire the initialization routine. This may not be a viable solution for all integrations, but this pattern should be followed whenever possible.

* **Cache Service Responses** - You should set a proper caching policy on services used by your integration to avoid having to make the same request multiple times to a service. Additionally, you could consider leveraging <a href="https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage" target="_blank">local storage</a> or <a href="https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage" target="_blank">session storage</a> to cache data from calls to services. Similar to the line item above, if you have a service that returns data, caching that data in the user's browser through a caching policy or local storage will avoid having to request it multiple times. This is helpful when users search for vehicles on a site and may see the same vehicle multiple times in different contexts. Reduced calls to your service will reduce network traffic, stress on your service, and will improve the user experience.

* **Use a CDN** - Your bootstrap script and any other integration code or assets should be located on a highly available content delivery network and must work over an HTTPS connection.

* **Browser Support** - We strive to support Edge, Firefox, Chrome, Safari, and iOS Safari, however, you may choose your own level of support. We do not allow access to our web sites on Legacy Edge, Internet Explorer 11 or lower IE versions.
