# ChangeLog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

This project adheres to the spirit of the major/minor versioning
scheme as implemented by the
[openSUSE project](https://en.opensuse.org/openSUSE:Versioning_scheme).

## [Unreleased]

### Added

- Add unit testing with R package `tinytest`.
- Add unit test file `test_rest_url.R`.
- Add unit test file `test_program_ref.R`.
- Add function `get_program_profile`.
- Add function `is_program_profile`.
  - Test if program Reference returned via DataStore REST service is a
    program Reference.
- Add function `get_refs_content_as_list`.
  - Returns the `fromJSON` content as NOT coerced to `data.frame`.
- Add function `get_refs_content_as_df`.
  - Returns the `fromJSON` content as coerced to `data.frame`.
- Add function `set_option_rest_url`.
  - Set the option `dr.rest_url` to a DataStore REST URL.
- Add function `rest_url_auth_type`.
  - Use function `rest_url_auth_type` to return authentication type
    dependending on which REST URL is used. If public URL, then return
    'basic'; else if secure URL, then return 'ntlm'.
- Add file `zzz.R`.
  - Add function `.onLoad` to set option `dr.rest_url` to the public
    DataStore REST service URL.
- Add option "dr.rest_url" to package with `.onLoad` function. Set its
  value to the DataStore public REST URL.
- Add function `set_option_rest_url` to set the option "dr.rest_url".
- Create file `zzz.R` to define `.onLoad` function.
- Add package documentation in file `datastore-rest-package.Rd`.
- Add function documentation file `get_prog_proj_products_dt.Rd`.

### Changed

- *NOTE:* Some changes are breaking changes from version 1.1.
- Change "service type" terminology to REST "resource" terminology.
  - Replace function parameters `service_type` with `resource_type`.
  - Rename the following REST resource type constants to correspond to
    REST URLs:
    - `profile` to `ref_profile` (`/rest/Profile`)
    - `reference` to `ref_code_search` (`/rest/ReferenceCodeSearch`)
    - `reference_composite` to `ref_code_search_comp` (`/rest/ReferencCodeSearch/Composite`)
- Replace function parameter `rest_service` with `rest_svc_url`.
- Replace function parameter `service_type` with `rest_rsrc_type`.
- Designate time expensive help examples as `dontrun`.
  - Test these examples as unit tests.
- Rename function `get_content_as_list` to `get_refs_content`.
- Change help documentation examples to `dontrun`.
- Set all `rest_svc_url` function arguments to
  `getOption("dr.rest_url")`.
  - Revise man docuements to reflect this change.

### Removed

- Remove 'auth_type' parameter from functions and help docs and vignettes.


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
