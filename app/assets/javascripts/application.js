// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

function fetchTags(cssId, route) {
  $(function() {
    $(cssId).tokenInput(route, {
      crossDomain: false,
      prePopulate: $(cssId).data("pre"),
      theme: "facebook",
      allowFreeTagging: true,
      allowCreation: true,
      preventDuplicates: true,
      creationText: "Add new tag",
      tokenValue: "name"
    });
  });
}

fetchTags("#project_skill_list", "/skill_tags.json");
fetchTags("#project_interest_list", "/interest_tags.json");
fetchTags("#user_skill_list", "/skill_tags.json");
fetchTags("#user_interest_list", "/interest_tags.json");
