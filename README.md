BDD Webdriver Steps
===================
This project aims to help testing web applications by defining common
[Gherkin](http://docs.behat.org/en/v2.5/guides/1.gherkin.html) steps oriented
to web development.

The goal is to provide steps that are compatible with 
[Behave](https://behave.readthedocs.io/) and
[Aloe](https://aloe.readthedocs.io/) using Selenium Webdriver to interact with
web browsers.

Steps related with Django are also provided.


Development
===========
If you want to contribute to this project you can start by setting up the dev
environment by running:

    source ./bin/startenv.sh
    
Then install dependencies:

    pip install -r requirements.txt
    pip install -r test_requirements.txt

Running tests
-------------
Before submitting your changes to code review, please ensure that all tests
pass:

    ./bin/runtests.sh
    
You can also run Gherkin tests individualy using:

    aloe --verbosity=3

or

    behave tests/features/
