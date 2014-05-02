Feature: Fourchan
  In order to be useful
  As a CLI
  I want to be able to do stuff

  Scenario: I need some help
    When I run `fourchan help`
    Then the output should contain "fourchan download"
  
  Scenario: I need some help to download
    When I run `fourchan help download`
    Then the output should contain "A valid URL for a thread"
  
  Scenario: I need some help to download
    When I run `fourchan help lurk`
    Then the output should contain "Where to save images"

  @vcr
  Scenario: I want to download a thread
    When I run `fourchan download -u http://boards.4chan.org/g/thread/41705021`
    Then the following folders should exist:
      | tmp/aruba/images |
    And the following folders should have "2" files combined:
      | tmp/aruba/images |
