import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["title", "input", "submit", "form", "checkbox"]

  connect() {
    console.log("TodoController connected");
  }

  edit(event) {

    event.preventDefault();
    this.titleTarget.classList.add("hidden")
    this.inputTarget.classList.remove("hidden")
    this.submitTarget.classList.remove("hidden")
    this.inputTarget.focus()
    this.inputTarget.select()
    this.inputTarget.addEventListener("blur", this.update.bind(this))
  }

  update(event) {
    event.preventDefault()
    this.formTarget.submit()
  }

  toggleComplete(event) {
    this.formTarget.submit()
  }
}
