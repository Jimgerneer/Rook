var Opportunity = Backbone.Model.extend({});

var OpportunityStore = Backbone.Collection.extend({
  model: Opportunity,
    url: 'http://localhost:4567/opportunities'
});

var opportunities = new OpportunityStore;

var OpporunityView = Backbone.View.extend({

  events: { "submit #opportunityForm" : "handleNewOpportunity" }

  , handleNewOpportunity: function(data) {
    var titleField = $('input[name=title]');
    var skillsField = $('input[name=skills]');
    var descriptionField = $('input[name=description]');
    opportunities.create({title: titleField.val(), skills: skillsField.val(), description: descriptionField.val()});
    titleField.val('');
    skillsField.val('');
    descriptionField.val('');
  }
  
  , render: function() {
    var data = opportunities.map(function(opportunity) { return opportunity.get('
  

