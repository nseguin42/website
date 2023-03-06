// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import 'phoenix_html';
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from 'phoenix';
import {LiveSocket} from 'phoenix_live_view';
import topbar from '../vendor/topbar';

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute('content');
const liveSocket = new LiveSocket('/live', Socket, {params: {csrfToken}});

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: '#29d'}, shadowColor: 'rgba(0, 0, 0, .3)'});

const topbarShowDelayMs = 300;
window.addEventListener('phx:page-loading-start', (_info) => topbar.show(topbarShowDelayMs));
window.addEventListener('phx:page-loading-stop', (_info) => topbar.hide());

import * as github from './github';
const urlElements = document.getElementsByClassName('github-url');
for (let i = 0; i < urlElements.length; i++) {
  const urlElement = urlElements[i];
  const commit = urlElement.dataset.commit;
  const url = github.getGithubUrl('nseguin42', 'website', commit);
  urlElement.setAttribute('href', url);
}

const messageElements = document.getElementsByClassName('github-commit-message');
for (let i = 0; i < messageElements.length; i++) {
  const messageElement = messageElements[i];
  const commit = messageElement.dataset.commit;
  github.getCommitMessage('nseguin42', 'website', commit).then((message) => {
    messageElement.textContent = message;
  });
}

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
