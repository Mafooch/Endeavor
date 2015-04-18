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

$(function() {
  $("#project_skill_list").tokenInput("/projects/all_skills.json", {
    crossDomain: false,
    prePopulate: $("#project_skill_list").data("pre"),
    theme: "facebook",
    allowFreeTagging: true,
    allowCreation: true,
    preventDuplicates: true,
    creationText: "Add new skill",
    tokenValue: "name"
  });
});

$(function() {
  $("#project_interest_list").tokenInput("/projects/all_interests.json", {
    crossDomain: false,
    prePopulate: $("#project_interest_list").data("pre"),
    theme: "facebook",
    allowFreeTagging: true,
    allowCreation: true,
    preventDuplicates: true,
    creationText: "Add new interest",
    allowFreeTagging: true,
    tokenValue: "name"
  });
});

$(function() {
  $("#user_skill_list").tokenInput("/projects/all_skills.json", {
    crossDomain: false,
    prePopulate: $("#user_skill_list").data("pre"),
    theme: "facebook",
    allowFreeTagging: true,
    allowCreation: true,
    preventDuplicates: true,
    creationText: "Add new skill",
    tokenValue: "name"
  });
});

$(function() {
  $("#user_interest_list").tokenInput("/projects/all_interests.json", {
    crossDomain: false,
    prePopulate: $("#user_interest_list").data("pre"),
    theme: "facebook",
    allowFreeTagging: true,
    allowCreation: true,
    preventDuplicates: true,
    creationText: "Add new interest",
    allowFreeTagging: true,
    tokenValue: "name"
  });
});
