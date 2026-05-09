import { Controller } from "@hotwired/stimulus";
import { debounce } from "utils/debounce";

// Connects to data-controller="auto-submit"
export default class extends Controller {
  static values = {
    delay: { type: Number, default: 150 },
  };

  initialize() {
    this.submit = this.submit.bind(this);
  }

  connect() {
    if (this.delayValue > 0) {
      this.submit = debounce(this.submit, this.delayValue);
    }
  }

  submit() {
    this.element.requestSubmit();
  }
}
