import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "input", "submit", "form", "checkbox"]
  connect() {
    console.log("TodosController connected");
    // …
  }
  edit() {
    this.titleTarget.classList.add("hidden")
    this.inputTarget.classList.remove("hidden")
    this.submitTarget.classList.remove("hidden")
    this.inputTarget.focus()
    this.inputTarget.select()
  }

  update(event) {
    event.preventDefault()
    this.formTarget.requestSubmit()
  }

  toggleComplete(event) {
    this.checkboxTarget.disabled = true
    this.formTarget.requestSubmit()
  }
}
