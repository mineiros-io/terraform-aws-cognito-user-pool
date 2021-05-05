# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.5.1]

### Changed
- feat: upgrade terratest to `v1.34.0`
- build: upgrade build-tools to `v0.9.0`
- build: upgrade pre-commit-hooks to `v0.2.2`

## [0.5.0]
### Added
- Add support for `account_recovery_mechanisms`

### Removed
- BREAKING CHANGE: Drop support for Terraform AWS Provider version 2.x

## [0.4.1] - 2021-02-08
### Fixed
- Fixed examples to use new variable `user_device_tracking` instead of `device_only_remembered_on_user_prompt`

## [0.4.0] - 2020-12-09
### Changed
- Add support for Terraform v0.14

## [0.3.0] - 2020-11-25
### Changes
- Add argument `user_device_tracking` to set device tracking to `OFF`, `ALWAYS` or `USER_OPT_IN`
- BREAKING CHANGE: Remove argument `device_only_remembered_on_user_prompt`. Replaced by `user_device_tracking`.
  Default behavior did not change. How to migrate:
  - `device_only_remembered_on_user_prompt=true`: Set `user_device_tracking='USER_OPT_IN'`
  - `device_only_remembered_on_user_prompt=false`: Set `user_device_tracking='ALWAYS'`
  - `device_only_remembered_on_user_prompt=null`: Set `user_device_tracking='OFF'`

### Fixes
- Allow to cleanly turn off user device tracking by setting new variable `user_device_tracking` to `OFF`. [#23](https://github.com/mineiros-io/terraform-aws-cognito-user-pool/issues/23)
- The type of the clients output is a map of objects instead of a list.

## [0.2.0] - 2020-08-13
### Changed
- Add support for Terraform v0.13
- Prepared support for Terraform v0.14

## [0.1.4] - 2020-08-13
### Added
- Add support for `username_attributes` argument.

## [0.1.3] - 2020-08-10
### Added
- Add unit test coverage for the `aws_cognito_user_pool_domain` resource.
### Changed
- Enable `markdown-link-check` pre-commit hook.
### Fixed
- Fixes recreation of resources on multiple apply runs.
- Fix non-idempotent number schema attributes.

## [0.1.2] - 2020-08-05
### Added
- Add support for `aws_cognito_user_pool_domain`.

## [0.1.1] - 2020-08-04
### Fixed
- Fix email subject for admin invites.
- Fix example documentation to point to terraform registry.
- Fix `string_attribute_constraints` default values for string attributes to prevent non-idempotent plan.

### Added
- Add test to validate idempotency after apply.

## [0.1.0] - 2020-08-03
### Changed
- Add support for terraform aws provider 3.x.
- Update test to test against 3.0 aws provider.
- Update test dependencies to use 3.x capable module versions.

## [0.0.1] - 2020-06-27
### Added
- Implement support for `aws_cognito_user_pool` resource.
- Implement support for `aws_cognito_user_pool_client` resource.
- Document the usage of the module in README.md.
- Document the usage of examples.
- Add unit tests for basic use cases.

<!-- markdown-link-check-disable -->
[Unreleased]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.5.1...HEAD
[0.5.1]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.5.0...v0.5.1
<!-- markdown-link-check-enable -->
[0.5.0]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.4.1...v0.5.0
[0.4.1]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.4...v0.2.0
[0.1.4]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/compare/v0.0.1...v0.1.0
[0.0.1]: https://github.com/mineiros-io/terraform-aws-cognito-user-pool/releases/tag/v0.0.1
