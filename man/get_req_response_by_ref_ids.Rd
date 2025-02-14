\name{get_req_response_by_ref_ids}
\alias{get_req_response_by_ref_ids}
\title{Get request response by REST URL from IRMA/DataStore}
\description{
Returns the GET request response for a particular REST URL.
}
\usage{
get_req_response_by_ref_ids(ref_ids, rest_rsrc_type, rest_svc_url=getOption("dr.rest_url"))
}
\arguments{
  \item{ref_ids}{a vector string of DataStore Reference IDs. E.g.
    "2305721, 2182981".}
  \item{rest_rsrc_type}{a REST Api (service) type. Values accepted:
    ("ref_profile", "ref_code_search", or "ref_code_search_comp").}
  \item{rest_svc_url}{a REST URL for the IRMA/DataStore REST services.}
}
\value{

}
\details{

  The service types correspond to the following REST Api(s):

  ref_profile: \code{/rest/Profile}

  ref_code_search: \code{/rest/ReferenceCodeSearch}

  ref_code_search_comp: \code{/rest/ReferenceCodeSearch/Composite}

  REST service URLs. See \code{https://irmaservices.nps.gov/}.

  \code{https://irmaservices.nps.gov/datastore/v7/rest/} (public)

  \code{https://irmaservices.nps.gov/datastore-secure/v7/rest/}
  (requires authentication type 'ntlm')

}
\examples{
\dontrun{
REF_CODE_SEARCH = "ref_code_search"
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"

ref_ids <- paste0(c(2305721, 2182981), collapse=",")

get_req_response_by_ref_ids(ref_ids, REF_CODE_SEARCH, REST_SERVICE_PUBLIC)
}
}
\author{Nick Bywater}
\keyword{}
