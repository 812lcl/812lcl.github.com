beforeEach ->
  jasmine.getFixtures().fixturesPath = 'spec/javascripts/fixtures/app/public/'
  jasmine.getJSONFixtures().fixturesPath = 'spec/javascript/fixtures/app/public'

  @addMatchers
    toBeLunrSearch: ->
      @actual.$elem    == "#search-query"
      @actual.$results.selector == "#search-results"
      @actual.$entries.selector == "#search-results .entries"

