# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Updated
- Removed branch protection. Not able to force push to master.
- Run verify workflow only on PRs

## [v2021-05-22T21.22.12] - 2021-05-22
### Fixed

- Trying forced push again
## [v2021-05-22T21.01.02] - 2021-05-22

### Fixed

- Protecting the master branch but allowing force push to enable git actions to update the changelog

## [v2021-05-22T20.06.03] - 2021-05-22

### Fixed

-   Fixing issue with changelog update by workflow on protected branch. By disabling branch protection since wf doesn't allows this ability yet.

## [v2021-05-22T19.34.49] - 2021-05-22

### Added

-   Added ability to run project locally via a dockerized container.

## [v2021-05-21T19.31.40] - 2021-05-21

### Added

-   Added a changelog enforcer to the workflow.
-   Tagging and uploading the releases.
-   Updating the changelog after a release

[Unreleased]: https://github.com/DealerDotCom/web-integration-api-docs/compare/v2021-05-22T20.06.03...HEAD

[v2021-05-22T20.06.03]: https://github.com/DealerDotCom/web-integration-api-docs/compare/v2021-05-22T19.34.49...v2021-05-22T20.06.03

[v2021-05-21T19.31.40]: https://github.com/DealerDotCom/web-integration-api-docs/compare/5cc6e2726e8d1db5484b56a99f416c5aef5cbe2a...v2021-05-21T19.31.40

[v2021-05-22T19.34.49]: https://github.com/DealerDotCom/web-integration-api-docs/compare/5cc6e2726e8d1db5484b56a99f416c5aef5cbe2a...v2021-05-22T19.34.49

[v2021-05-22T21.01.02]: https://github.com/DealerDotCom/web-integration-api-docs/compare/5cc6e2726e8d1db5484b56a99f416c5aef5cbe2a...v2021-05-22T21.01.02
