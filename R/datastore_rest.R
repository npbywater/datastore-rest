## datastore_rest.R
## Version 1.0
## Initial release month: 2025-January

## Created by: Nick Bywater
## Government agency: National Park Service, CAKN
## License: The Unlicense (Public Domain). See: https://unlicense.org/.

## PURPOSE: Provides a set of functions to interact with NPS
## IRMA/DataStore REST Services. See https://irmaservices.nps.gov/ for
## more information on IRMA REST services.

## Rules for Reference types: PROGRAM, PROJECT, and PRODUCT.
##
## NOTE: 'PRODUCT' is not an actual Reference Type, but, rather, is a
## catch-all term for Reference "products" such as "Journal Article"
## or "Tabular Dataset".
##
## (1). A PROGRAM Reference has children (project references), but not
##      projects or products.
## (2). A PROJECT Reference does not have children, but it does have
##      product references.
## (3). A PRODUCT Reference does not have children or products. But it
##      may belong to a project with related sibling products. That is,
##      it may "have" a node with a reference to a project and its
##      sibling products.

## Service types
PROFILE <- "profile"
REFERENCE <- "reference"
REFERENCE_COMPOSITE <- "reference_composite"

## REST service URLs
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"
REST_SERVICE_SECURE <- "https://irmaservices.nps.gov/datastore-secure/v7/rest/"

## Authentication types
AUTH_BASIC <- "basic"
AUTH_NTLM <- "ntlm" ## For secure service type.

## Returns a list of values that for a given REST request are
## converted to content by the jsonlite::fromJSON function.
get_content_as_list <- function(ref_ids,
                                service_type = PROFILE,
                                rest_service = REST_SERVICE_PUBLIC,
                                auth_type = AUTH_BASIC,
                                simplify_to_df = TRUE) {

    req <- get_request_by_ref_ids(ref_ids, service_type, rest_service, auth_type)
    content <- get_content(req, simplify_to_df)

    return(content)
}

## Returns the request for a particular REST URL and authentication.
## Parameter(s):
##   ref_ids: a vector string of DataStore Reference IDs.
##   service_type: a REST service-type (e.g. REFERENCE, PROFILE, etc.)
##     as defined by global constants.
##   rest_service: a REST URL for the DataStore REST services as
##     defined by global constants.
##   auth_type: authentication-type as defined by global constants.
##     - AUTH_BASIC is for public REST service.
##     - AUTH_NTLM is for secure REST servics.
get_request_by_ref_ids <- function(ref_ids, service_type, rest_service, auth_type) {
    if (service_type == REFERENCE) {
        ref_url <- paste0(rest_service, "ReferenceCodeSearch?q=", ref_ids)
    } else if (service_type == REFERENCE_COMPOSITE) {
        ref_url <- paste0(rest_service, "ReferenceCodeSearch/Composite?q=", ref_ids)
    } else if (service_type == PROFILE) {
        ref_url <- paste0(rest_service, "Profile?q=", ref_ids)
    }

    req <- get_request(ref_url, auth_type)

    return(req)
}

get_request <- function(ref_url, auth_type) {
    req <- httr::GET(ref_url, httr::authenticate(":", ":", auth_type))
    status_code <- httr::stop_for_status(req)$status_code

    if (! status_code == 200) {
        stop("DataStore connection failed.")
    }

    return(req)
}

## Returns a data.frame from JSON via request.
## Parameter(s):
##   simplify_to_df: this value is passed to the 'simplifyDataFrame'
##     parameter of the function 'fromJSON'.
get_content <- function(req, simplify_to_df = TRUE) {
    json <- httr::content(req, "text")
    json_lite <- jsonlite::fromJSON(json, simplifyDataFrame=simplify_to_df)

    return(json_lite)
}

## Return a list of PROJECT-REFERENCE-PROFILEs called by REST service
## URL query: Profile?q=.
##
## Parameter(s):
##   program_ref_id: a vector of 1 element, a program Reference ID in
##     DataStore. For example, the CAKN program Reference ID 2210836.
##
## Returns a list of PROJECT-REFERENCE-PROFILEs associated with a
## PROGRAM-REFERENCE-ID. Each node, of the returned list, is named for
## the PROJECT-REFERENCE-ID.
##
## NOTE: The returned list is assigned the class name 'project' so
##       that its type can be tested when passed to another function.
##
## NOTE: The automatic coercion of JSON arrays (via function
##       'fromJSON') to data.frames causes us problems for project
##       profiles when chunking up to 25 profiles at a time; so we
##       return just a list without data.frame coercion.
get_program_project_profiles <- function(program_ref_id, rest_service, auth_type) {

    program <- get_content_as_list(program_ref_id, PROFILE, rest_service, auth_type, simplify_to_df=TRUE)

    projects_df <- program$children[[1]]
    project_ref_ids <- projects_df$referenceId

    project_profiles <- get_ref_profiles(project_ref_ids, rest_service, auth_type, simplify_to_df=FALSE)

    class(project_profiles) <- "project"

    return(project_profiles)
}

## Given a list of PROJECT-REFERENCE-PROFILEs (as defined by DataStore
## API), combine them into a data.table.
## Parameter(s):
##   project_profiles: This is a list of PROJECT-REFERENCE-PROFILEs
##   (as returned from DataStore). It is expected that this argument
##   can be tested with the 'isa' function, to determine if it is of
##   type 'project'.
## Returns:
##   A data.table of PROJECT-PRODUCT-REFERENCE-PROFILES.
## NOTES:
##   The products list elements 'units' and 'linkedResources' are
##   collapsed into a comma separted string for convenience.
project_profiles_to_products_dt <- function(project_profiles) {
    products_list <- list()

    if (! isa(project_profiles, "project")) {
        stop("The argument 'project_profiles' is not a list of project references.")
    }

    ## linkedResources list to vector string.
    lr_list_to_vector_str <- function(product) {
        if (length(product$linkedResources) == 1) {
            lr <- paste0(names(product$linkedResources[[1]])," = ",
                         product$linkedResources[[1]], collapse=" ")

        } else if (length(product$linkedResources) > 1) {
            lr <- paste0(product$linkedResources, collapse=" ")

        } else {
            lr <- product$linkedResources
        }

        return(lr)
    }

    ## units to vector string.
    units_vector_to_vector_str <- function(product) {
        return(paste0(product$units, collapse=","))
    }

    dt_list <- list()
    m <- 1

    for (i in seq(length(project_profiles))) {
        project_group <- project_profiles[[i]]

        for (j in seq(length(project_group))) {
            project_list <- project_group[[j]]

            for (k in seq(length(project_list$products))) {
                product <- project_list$products[[k]]

                product$linkedResources <- lr_list_to_vector_str(product)
                product$units <- units_vector_to_vector_str(product)

                dt_list[[m]] <- data.table::as.data.table(product)

                dt_list[[m]][, c("project_reference_id", "project_title") :=
                                   .(project_list$referenceId,
                                     project_list$bibliography$title)]

                m <- m + 1
            }
        }
    }

    return(data.table::rbindlist(dt_list, fill=TRUE))
}

## Return a list of REFERENCE-PROFILES (as specified by DataStore
## API), when provided a vector of Reference IDs.
get_ref_profiles <- function(ref_ids, rest_service, auth_type, simplify_to_df=FALSE) {

    profile_list <- list()

    ## Group ref_ids into vectors of up to 25 elements.
    ## ref_id_groups is a list of these vectors.
    ref_id_groups <- group_ref_ids(ref_ids)

    i <- 1

    for (ref_ids in ref_id_groups) {
        profiles <- get_ref_profiles_by_ids(ref_ids, rest_service, auth_type, simplify_to_df)
        profile_list[[i]] <- profiles
        i = i + 1
    }

    return(profile_list)
}

get_ref_profiles_by_ids <- function(ref_ids, rest_service, auth_type, simplify_to_df=TRUE) {

    profile <- get_content_as_list(ref_ids, PROFILE, rest_service, auth_type, simplify_to_df)

    return(profile)
}

## Split a vector of REFERENCE-IDs into a list of vectors, where each
## vector is a string of, at most, 25 comma-separated REFERENCE-IDs. We
## can then provide these comma separated strings of REFERENCE-IDs to
## REST services such as PROFILE and REFERENCE and
## REFERENCE_COMPOSITE.
group_ref_ids <- function(ref_ids) {
    from <- 1
    to <- 25
    ref_id_count <- length(ref_ids)
    ref_group_count <- ceiling(ref_id_count / to)
    ref_id_list <- list()

    for (i in seq(ref_group_count)) {
        if (any(is.na(ref_ids[from:to]))) {
            refs <- ref_ids[from:to]
            refs <- refs[! is.na(ref_ids[from:to])]
        } else {
            refs <- ref_ids[from:to]
        }

        ref_id_list[[i]] <- paste0(refs, collapse=",")

        from <- from + 25
        to <- to + 25
    }

    return(ref_id_list)
}

## Return a data.table of references called by REST service URL query:
## ReferenceCodeSearch?q=.
##
## Parameter(s):
##   ref_ids: a vector of REFERENCE-IDs in DataStore.
get_refs_by_ref_search <- function(ref_ids, rest_service, auth_type, simplify_to_df=TRUE) {

    reference_list <- list()

    ## Group ref_ids into vectors of up to 25 elements.
    ## ref_id_groups is a list of these vectors.
    ref_id_groups <- group_ref_ids(ref_ids)

    i <- 1
    for (ref_ids in ref_id_groups) {
        reference <- get_content_as_list(ref_ids, REFERENCE, rest_service, auth_type, simplify_to_df)

        if (! is.null(reference$referenceId)) {
            reference_list[[i]] <- reference
            i <- i + 1
        }
    }

    return(data.table::rbindlist(reference_list))
}

## Write data.table to CSV file.
write_dt_to_csv_file <- function(product_refs, file_name) {
    product_refs_str <- data.frame(lapply(product_refs, as.character), stringsAsFactors=FALSE)
    data.table::fwrite(product_refs_str, file_name, qmethod="double", quote=TRUE)
}

## Read CSV file into data.table.
read_dt_from_csv_file <- function(file_name) {
    dt <- data.table::fread(file=file_name)
    return(dt)
}
