Feature: Test basic Gherkin is handled by all BDD frameworks

    Background:
        Given I store the value 'Apple' in the context
        And I store the value "Pear" in the context


    Scenario: Run a simple test
        Given we have a BDD runner installed
        When we implement a test
        Then the BDD runner will test it for us!


    Scenario: Check values in context
        Then the value 'Pear' should be in the context
        And the value "Apple" should be in the context
