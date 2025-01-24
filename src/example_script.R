## example_script.R
## Version 1.0
## Initial release month: 2025-January

## Created by: Nick Bywater
## Government agency: National Park Service, CAKN
## License: The Unlicense (Public Domain). See: https://unlicense.org/.

source("datastore_rest.R")

CAKN_PROGRAM_REF_ID <- 2210836
ARCN_PROGRAM_REF_ID <- 2208369

write_program_ref_product_profiles <- function(program_ref_id, rest_service, auth_type) {

    cat(paste0("Collecting PROGRAM-REFERENCE-ID '", program_ref_id, "' PROJECT-REFERENCE-PROFILEs...\n"))

    project_profiles <- get_program_project_profiles(program_ref_id,
                                                     rest_service,
                                                     auth_type)

    cat(paste0("Collecting PROJECT-PRODUCT-REFERENCE-PROFILES...\n"))

    project_products <- combine_project_products_into_dt(project_profiles)
    project_product_refs <- project_products$referenceId

    cat(paste0("Collecting PROJECT-PRODUCT-REFERENCE-PROFILES-BY-REFERENCE-SEARCH...\n"))

    project_product_profiles_by_ref_search <- get_refs_by_ref_search(project_product_refs,
                                                                     rest_service,
                                                                     auth_type)


    ## Remove the 'linkedResources' column. Should probably be parsed
    ## into another table.
    p_products <- project_products[, -c("linkedResources")]

    today <- format(Sys.time(), "%Y-%m-%dT%H.%M.%OS3")

    cat(paste0("Writing data to files...\n"))

    ## Write products-profile table.
    fname <- paste0("products_", today, ".csv")
    write_dt_to_csv_file(p_products, fname)

    ## Write products-by-ref-search table.
    fname <- paste0("products_by_ref_search_", today, ".csv")
    write_dt_to_csv_file(project_product_profiles_by_ref_search, fname)

    cat(paste0("DONE!\n"))
}

main <- function() {
    ## Public REST service.
    write_program_ref_product_profiles(CAKN_PROGRAM_REF_ID,
                                       REST_SERVICE_PUBLIC,
                                       AUTH_BASIC)

    ## Secure REST service.
    ## write_program_ref_product_profiles(CAKN_PROGRAM_REF_ID,
    ##                                    REST_SERVICE_SECURE,
    ##                                    AUTH_NTLM)

}
