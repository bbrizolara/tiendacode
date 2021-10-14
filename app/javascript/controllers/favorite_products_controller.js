import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['favorite']

  connect(){
    console.log('connected')
  }

  add_remove(event) {
    const [data, status, xhr] = event.detail;
    this.favoriteTarget.innerHTML = xhr.response;   
  }

  error(){
    console.log('error');
  }
}
