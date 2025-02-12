\name{get_request_by_ref_ids}
\alias{get_request_by_ref_ids}
\title{Get request by REST URL from IRMA/DataStore}
\description{
Returns the GET request for a particular REST URL and authentication.
}
\usage{
get_request_by_ref_ids(ref_ids, rest_rsrc_type, rest_svc_url, auth_type)
}
\arguments{
  \item{ref_ids}{a vector string of DataStore Reference IDs. E.g.
    "2305721, 2182981".}
  \item{rest_rsrc_type}{a REST Api (service) type. Values accepted:
    ("ref_profile", "ref_code_search", or "ref_composite").}
  \item{rest_svc_url}{a REST URL for the IRMA/DataStore REST services.}
  \item{auth_type}{one of the following types supported by
    Curl: \code{basic} or \code{ntlm}.}
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
AUTH_BASIC <- "basic"

ref_ids <- paste0(c(2305721, 2182981), collapse=",")

get_request_by_ref_ids(ref_ids, REF_CODE_SEARCH, REST_SERVICE_PUBLIC, AUTH_BASIC)
}
}
\author{Nick Bywater}
\keyword{}
