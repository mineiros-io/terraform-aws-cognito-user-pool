# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.1] - 2020-08-04
### Fixed
- Fix email subject for admin invites
- Fix example documentation to point to terraform registry
- Fix `string_attribute_constraints` default values for string attributes to prevent non-idempotent plan.

### Added
- Add test to validate idempotency after apply

## [0.1.0] - 2020-08-03
### Changed
- Add support for terraform aws provider 3.x
- Update test to test against 3.0 aws provider
- Update test dependencies to use 3.x capable module versions

## [0.0.1] - 2020-06-27
### Added
- Implement support for `aws_cognito_user_pool` resource
- Implement support for `aws_cognito_user_pool_client` resource
- Document the usage of the module in README.md
- Document the usage of examples
- Add unit tests for basic use cases

<!-- markdown-link-check-disable -->
[Unreleased]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.0...v0.1.1
<!-- markdown-link-check-enable -->
[0.1.0]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases/tag/v0.0.1
