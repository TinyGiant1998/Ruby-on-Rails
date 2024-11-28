// import { Application } from "@hotwired/stimulus";
// import "@hotwired/turbo-rails";
import "controllers";
// import { Turbo } from "@hotwired/turbo-rails";

const application = Application.start();
// const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;
// application.debug = false;
// window.Stimulus = application;

export { application };
// export { application };
