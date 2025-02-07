# ChangeLog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

This project adheres to the spirit of the major/minor versioning
scheme as implemented by the
[openSUSE project](https://en.opensuse.org/openSUSE:Versioning_scheme).

## [Unreleased]

## [1.1] - 2025-02-07

### Added

- Convert R scripts to R package `datastore.rest`.
  - Add `DESCRIPTION` and `NAMESPACE` files.
  - Add `man` and `vignette` directories.
    - Add `man` files:
      - `get_program_project_profiles.Rd`
      - `get_refs_by_ref_search.R`
      - `get_request_by_ref_ids.Rd`
      - `project_profiles_to_products_dt.Rd`
    - Add `vignette` files:
      - `precompile.R` file for precompilation of vignette
        `.Rmd` files. See:
        [Precompute vignette](https://www.r-bloggers.com/2019/12/how-to-precompute-package-vignettes-or-pkgdown-articles/).
      - `example.Rmd.orig`
        - Move example code (`example_script.R`) to a vignette
          `example.Rmd.orig`.
      - `example.Rmd`
      - `rest_service_notes.Rmd.orig`
      - `rest_service_notes.Rmd`
      - `.gitignore`
  - Add explicit namespace qualifiers to library function calls in
    file `datastore_rest.R`. Qualifiers:
    - `jsonlite`
    - `data.table`
    - `httr`
- Add URL and authentication string checks to function `get_request`.
  - Allow only authentication types 'basic' and 'ntlm'.
- Add `README.md` file.
- Add `CHANGELOG.md` file.
- Add `.gitignore` file.

### Fixed

- Correct errors in comments.
- Make style changes to code.

### Changed

- Rename function `combine_project_products_into_dt` to
  `project_profiles_to_products_dt`.
- Rename directory `src` to `R`.

### Removed

- Remove file `example_script.R`.
- Remove package imports using `library` function from file
  `datastore_rest.R`.

## [1.0] - 2025-01-24

### Added

- Initial release of the R IRMA/DataStore scripts.
    - Add `datastore_rest.R` "library" file.
    - Add `example_script.R` example script file.
    - Add `LICENSE` file.
