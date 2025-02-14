
REST_SVC_PUBLIC_URL <- "https://irmaservices.nps.gov/datastore/v7/rest/"
REST_SVC_SECURE_URL <- "https://irmaservices.nps.gov/datastore-secure/v7/rest/"

expect_error(rest_url_auth_type("https://example.com")) 

response <- rest_url_auth_type(REST_SVC_SECURE_URL)

expect_equal(response, "ntlm")

response <- rest_url_auth_type(REST_SVC_PUBLIC_URL)

expect_equal(response, "basic")
