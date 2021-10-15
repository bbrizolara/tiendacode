import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['favorite', 'item']
  static values = { index: Number }

  add_remove(event) {
    const [data, status, xhr] = event.detail;
    this.favoriteTarget.innerHTML = xhr.response;   
  };

  hideShowHandler(event){
    const params = event.params;
    if (this.indexValue == params.index) {
      this.indexValue = null;
    } else {      
      this.indexValue = params.index;
    }
  };

  indexValueChanged(){
    if (this.loadChanges){
      this.itemTargets.forEach((element, index) => {
      element.hidden = index != this.indexValue
    });
    } else {
      this.loadChanges= true;
    }
  };

  error(){
    console.log('Ajax Error');
  };
}
