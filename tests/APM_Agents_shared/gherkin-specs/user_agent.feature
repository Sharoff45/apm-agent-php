Feature: Agent Transport User agent Header

  Scenario: Default user-agent
    Given an agent
    When the agent sends a request to APM server
    Then the User-Agent header matches regex '^apm-agent-[a-z]+/[^ ]*'

  Scenario Outline: User-agent with service name only
    Given an agent configured with
      | setting         | value            |
      | service_name    | <SERVICE_NAME>   |
    When the agent sends a request to APM server
    Then the User-Agent header matches regex '^apm-agent-[a-z]+/[^ ]* \(<ESCAPED_SERVICE_NAME>\)'
  Examples:
    | SERVICE_NAME               | ESCAPED_SERVICE_NAME  |
    | myService                  | myService             |
    | /()<>@, :;={}?\\[\\]\"\\\\ | _____________________ |

  Scenario Outline: User-agent with service name and service version
    Given an agent configured with
      | setting         | value             |
      | service_name    | <SERVICE_NAME>    |
      | service_version | <SERVICE_VERSION> |
    When the agent sends a request to APM server
    Then the User-Agent header of the request matches regex '^apm-agent-[a-z]+/[^ ]* \(<ESCAPED_SERVICE_NAME> <ESCAPED_SERVICE_VERSION>\)'
  Examples:
    | SERVICE_NAME               | ESCAPED_SERVICE_NAME  | SERVICE_VERSION            | ESCAPED_SERVICE_VERSION |
    | myService                  | myService             | v42                        |                         |
    | /()<>@, :;={}?\\[\\]\"\\\\ | _____________________ | /()<>@, :;={}?\\[\\]\"\\\\ | _____________________   |
