Feature: Completely login-free
  As someone without a strong authentication mechanism
  I want to not have to log in
  So that I don't have to build one

  Scenario:
    Given there is no login system
    Then I should not have to login
