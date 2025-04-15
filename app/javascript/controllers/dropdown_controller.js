import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
} 