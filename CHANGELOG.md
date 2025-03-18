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
- Add function `get_prog_proj_products_dt`.
  - Returns a data.table with ordered fields.
- Add function documentation file `get_prog_proj_products_dt.Rd`.
- Add a small example that uses function `get_prog_proj_products_dt`
  to the vignettes documentation.

### Fixed

- In function `project_profiles_to_products_dt`:
  - Revise function `lr_list_to_vector_str` to properly format linked
    resources string. *NOTE:* renamed this function to `lr_list_to_str`.
    - *FIX:* This function returns a comma separated string of
      linked resource elements, where each element name and its value
      are separated by an equals (`=`) sign. If linked resource list
      is of length two or more, the linked resource strings are
      separated by a newline.
- Function `project_profiles_to_products_dt` calls function
  `data.table::rbindlist` with option `fill=TRUE` to account for
  projects without a product. This need is caused by using function
  `seq` instead of `seq_along` in the in the inner `for` loop of
  function `project_profiles_to_products_dt`. Specifically, when
  `seq(0)` is called, it returns a vector of the two values `1` and
  `0` (in that order).
  - *FIX:* Replace function `seq` with `seq_along`.
  - *FIX:* Remove option `fill=TRUE` in function call
    `data.table::rbindlist`.
- Remove last `/` from constant `REF_PROFILE_URL`. The function
  `file.path` does not remove the redundant path component separator
  when joining path components.

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
- In function `project_profiles_to_products_dt`:
  - Rename function `lr_list_to_vector_str` to `lr_list_to_str`.
  - Rename function `units_vector_to_vector_str` to
    `units_vector_to_str`.
  - Replace function `seq` by `seq_along`.
  - Revise function `lr_list_to_str` to properly format linked
    resources string.
  - Remove option `fill=TRUE` in funciton call `data.table::rbindlist`.
  - Replace `NULL`s with `NA`s in `product` variable so that
    `as.data.table` will not drop the list elements with a `NULL`.
- In file `DESCRIPTION`:
  - Change `Depends` to `Imports`.
  - Make license `The Unlicense` explicit.
  - Add `URL` field.
- In file `NAMESPACE`:
  - Add `import(data.table)`; required because `data.table` is now
    listed in file `DESCRIPTION`s `Imports` field.
- In function `get_prog_proj_products_dt`:
  - Comment out field `typeName` (value is the same as
    `referenceType`) from returned `data.table`. Updated help
    document.
  - Make `program_name` optionally the program Reference citation name
    (default) or the user-provided argument value.
  - Add missing elements from DataStore project-products to
    `data.table`. Order columns and create new copy of `data.table` by
    assignment.
- In function `get_program_project_profiles`:
  - Assign attributes `program_ref_id` and `program_name` to
    `project_profiles` list object. Update related help documents.

### Removed

- Remove `auth_type` parameter from functions and help docs and vignettes.
- Remove global variable `REST_SVC_PUBLIC_URL`.

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
