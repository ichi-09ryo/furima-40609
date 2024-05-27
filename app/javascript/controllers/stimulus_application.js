// app/javascript/controllers/stimulus_application.js
import { Application } from "@hotwired/stimulus";

const application = Application.start();
application.debug = false;
window.Stimulus = application;

export { application };