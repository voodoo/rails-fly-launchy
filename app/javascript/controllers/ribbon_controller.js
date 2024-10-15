import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]
  static values = { currentState: String }

  connect() {
    this.updateButtonStyles()
  }

  updateState(event) {
    event.preventDefault()
    const newState = event.currentTarget.dataset.state
    
    fetch(event.currentTarget.form.action, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ state: newState })
    }).then(response => {
      if (response.ok) {
        this.currentStateValue = newState
        this.updateButtonStyles()
      }
    })
  }

  updateButtonStyles() {
    this.buttonTargets.forEach(button => {
        button.classList.remove('bg-yellow-400')
        button.classList.remove('bg-green-400')
        button.classList.remove('bg-blue-400')
    })
    this.buttonTargets.forEach(button => {
      const isCurrentState = button.dataset.state === this.currentStateValue
      
      if (isCurrentState) {
        switch(button.dataset.state) {
          case 'pending':
            button.classList.add('bg-yellow-400')
            break
          case 'in_progress':
            button.classList.add('bg-green-400')
            break
          case 'completed':
            button.classList.add('bg-blue-400')
            break
        }
      }
    })
  }
}
