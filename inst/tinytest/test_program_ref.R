

CAKN_PROGRAM_REF_ID <- 2210836
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"

program_profile <- get_refs_content_as_df(CAKN_PROGRAM_REF_ID,
                                          "ref_profile",
                                          REST_SERVICE_PUBLIC,
                                          "basic")

expect_true(is.data.frame(program_profile))

result <- is_program_profile(program_profile)

expect_true(result)


program_profile <- get_refs_content_as_list(CAKN_PROGRAM_REF_ID,
                                            "ref_profile",
                                            REST_SERVICE_PUBLIC,
                                            "basic")

expect_false(is.data.frame(program_profile))
    
result <- is_program_profile(program_profile)

expect_true(result)
