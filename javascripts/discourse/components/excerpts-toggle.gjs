import { action } from "@ember/object";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
// import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import bodyClass from "discourse/helpers/body-class";
// import icon from "discourse-common/helpers/d-icon";
import Component from "@glimmer/component";
import DButton from "discourse/components/d-button";


export default class excerptToggleButtonComponent extends Component {
  @service router;
  @tracked excerptsEnabled = settings.excerpts_enabled;


  @action
  toggleExcerpts() {
    this.excerptsEnabled = !this.excerptsEnabled;
  }

  get bodyExcerptClass() {
    return this.excerptsEnabled ? "excerpts-enabled" : "excerpts-disabled";
  }

  get showButton() {
    return this.router.currentRouteName !== "discovery.categories";
  } 

  <template>
    {{#if this.showButton}}
      {{bodyClass this.bodyExcerptClass}}
      <DButton
        @action={{this.toggleExcerpts}}
        @icon="align-justify"
        class="excerpts-toggle"
      />
    {{/if}}
  </template>
}