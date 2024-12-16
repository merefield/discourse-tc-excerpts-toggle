import { action } from "@ember/object";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import bodyClass from "discourse/helpers/body-class";
import Component from "@glimmer/component";
import DButton from "discourse/components/d-button";


export default class excerptToggleButtonComponent extends Component {
  @service router;
  @tracked excerptsEnabled = settings.excerpts_enabled;

  @action
  toggleExcerpts() {
    this.excerptsEnabled = !this.excerptsEnabled;

    if (settings.topic_list_previews_compatibility) {
      window.scrollBy(0, -2);
      window.scrollBy(0, 2);
    }
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