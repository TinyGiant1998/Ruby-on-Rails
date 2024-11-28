// import { Controller } from "@hotwired/stimulus";

// export default class extends Controller {
//   static targets = ["mediaItem"];

//   connect() {
//     this.createFullscreenOverlay();
//   }

//   createFullscreenOverlay() {
//     this.fullscreenOverlay = document.createElement("div");
//     this.fullscreenOverlay.classList.add("media-fullscreen");
//     document.body.appendChild(this.fullscreenOverlay);

//     this.fullscreenOverlay.addEventListener("click", () => {
//       this.fullscreenOverlay.classList.remove("active");
//     });
//   }

//   openFullscreen(event) {
//     const img = document.createElement("img");
//     img.src = event.currentTarget.src;

//     this.fullscreenOverlay.innerHTML = ""; // Clear any previous content
//     this.fullscreenOverlay.appendChild(img);
//     this.fullscreenOverlay.classList.add("active");
//   }
// }

// app/javascript/controllers/media_controller.js

// import { Controller } from "stimulus";

// export default class extends Controller {
//   static targets = ["image", "video"];

//   initialize() {
//     console.log("Media controller initialized!");
//   }

//   hoverImage(event) {
//     event.target.style.transform = "scale(1.05)";
//     event.target.style.transition = "all 0.3s";
//   }

//   unhoverImage(event) {
//     event.target.style.transform = "scale(1)";
//   }
// }

// hoverImage(event) {
//   event.target.style.transform = "scale(1.05)";
//   event.target.style.transition = "all 0.3s";
// }

// unhoverImage(event) {
//   event.target.style.transform = "scale(1)";
// }

// // Open image in full-screen
// fullScreenImage(event) {
//   const img = event.target;
//   const imageUrl = img.src;

//   const fullScreenDiv = document.createElement('div');
//   fullScreenDiv.style.position = 'fixed';
//   fullScreenDiv.style.top = '0';
//   fullScreenDiv.style.left = '0';
//   fullScreenDiv.style.width = '100%';
//   fullScreenDiv.style.height = '100%';
//   fullScreenDiv.style.backgroundColor = 'rgba(0, 0, 0, 0.8)';
//   fullScreenDiv.style.display = 'flex';
//   fullScreenDiv.style.justifyContent = 'center';
//   fullScreenDiv.style.alignItems = 'center';

//   const fullScreenImg = document.createElement('img');
//   fullScreenImg.src = imageUrl;
//   fullScreenImg.style.maxWidth = '90%';
//   fullScreenImg.style.maxHeight = '90%';

//   fullScreenDiv.appendChild(fullScreenImg);

//   document.body.appendChild(fullScreenDiv);

//   fullScreenDiv.onclick = function() {
//     document.body.removeChild(fullScreenDiv);
//   };
// }
