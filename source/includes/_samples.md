# Sample Code

The sample code here is provided as a starting point for how to accomplish tasks that are related to integrations but that may not fit squarely in the responsibility of the Integration API. Code may need to be modified to fit your integration's use case.

## Resizing an `iframe` Based on Content Changes

> iframe Code:

```javascript
document.body.style.overflow = 'hidden';

function sendResizeMessage() {
  window.parent.postMessage({
    type: 'IFRAME_HEIGHT_RESIZE',
    target: 'test-integration-iframe', // Note: Replace 'test-integration-frame' with your actual iframe identifier.
    frameHeight: document.body.offsetHeight + 10 /* a little extra for good measure */
  }, '*');
}

if (window.ResizeObserver) {
  const heightObserver = new ResizeObserver(() => {
    sendResizeMessage();
  });
  heightObserver.observe(document.body);
}
```

> Integration Code:

```javascript
(function (WIAPI) {
  const API = new WIAPI('test-integration'); // Note: Replace 'test-integration' with your actual integration identifier.

  API.insert('content', function (elem, meta) {
    const iframeElem = document.createElement('iframe');
    iframeElem.src = 'https://www.yourdomain.com/path-to-iframe.htm';
    iframeElem.classList.add('test-integration-iframe'); // Note: Replace 'test-integration-frame' with your actual iframe identifier.
    API.append(elem, iframeElem);
  });

  function setIframeHeight(e) {
    if (e.origin !== 'https://www.yourdomain.com') {
      // You should ALWAYS verify the origin matches the third party domain
      // the iframe is loaded from. For more information, see:
      // https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage#Security_concerns
      return;
    }

    if (e.data.type === 'IFRAME_HEIGHT_RESIZE' && e.data.frameHeight && e.data.target) {
      const iframes = document.getElementsByClassName(e.data.target);
      if (iframes.length === 1) {
        iframes[0].style.height = e.data.frameHeight + 'px';
      }
    }
  }

  window.addEventListener('message', setIframeHeight, false);
})(window.DDC.API);
```

An integration may want to insert an iframe that resizes as its contents change. One possible way to accomplish this is for the iframe and the integration to work together as shown in the sample code from the pane on the right side of this page. You can see the sample code running [here](https://webapitestddc.cms.dealer.com/growing-iframe-example.htm).

### IFrame Responsibilities:

* **Determine when content dimensions change** - One way to do this is using [`ResizeObserver`](https://developer.mozilla.org/en-US/docs/Web/API/ResizeObserver).
* **Communicate the new dimension to the outer page** - iframes can communicate with the parent page using [`postMessage`](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage).
* **Ensure a scrollbar never shows up within the iframe** - Styling may be used to ensure a scrollbar never appears in the iframe.

### Integration Responsibilities(on the outer page):

* **Insert the iframe into the page** - You can use the API methods to insert an iframe into a location.
* **Listen for resize messages and resize the iframe**

### Considerations

* If you use `postMessage`, ensure that you check the event's origin to alleviate [security concerns](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage#Security_concerns).
* The integration resizing code supports multiple iframes from the same vendor. You may need to modify the code to target your iframes differently.
