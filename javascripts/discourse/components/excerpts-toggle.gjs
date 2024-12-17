import { action } from "@ember/object";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import bodyClass from "discourse/helpers/body-class";
import Component from "@glimmer/component";
import DButton from "discourse/components/d-button";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import didUpdate from "@ember/render-modifiers/modifiers/did-update";

export default class excerptToggleButtonComponent extends Component {
  @service router;
  @service session;
  @tracked excerptsEnabled;

  @action
  toggleExcerpts() {
    this.excerptsEnabled = !this.excerptsEnabled;
    this.session.set("excerptsEnabled", this.excerptsEnabled);

    if (settings.topic_list_previews_compatibility) {
      window.scrollBy(0, -1);
      window.scrollBy(0, 1);
    }
  }

  @action
  initExcerpts() {
    this.excerptsEnabled = this.session.get("excerptsEnabled") ?? settings.excerpts_enabled;
  }

  get bodyExcerptClass() {
    return this.excerptsEnabled ? "excerpts-enabled" : "excerpts-disabled";
  }

  get showButton() {
    return this.router.currentRouteName !== "discovery.categories";
  }

  get toggleIcon() {
    return settings.toggle_icons;
  }

  <template>
    {{#if this.showButton}}
      {{bodyClass this.bodyExcerptClass}}
      <div class="excerpts-toggle-container" {{didInsert this.initExcerpts}}>
        <DButton
          @action={{this.toggleExcerpts}}
          @icon={{this.toggleIcon}}
          class="excerpts-toggle"
        />
      </div>
    {{/if}}
  </template>
}