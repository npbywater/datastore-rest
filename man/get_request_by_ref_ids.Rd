\name{get_request_by_ref_ids}
\alias{get_request_by_ref_ids}
\title{Get request by REST URL from IRMA/DataStore}
\description{
Returns the GET request for a particular REST URL and authentication.
}
\usage{
get_request_by_ref_ids(ref_ids, service_type, rest_service, auth_type)
}
\arguments{
  \item{ref_ids}{a vector string of DataStore Reference IDs. E.g.
    "2305721, 2182981".}
  \item{service_type}{a REST service-type. Values accepted:
    (\code{profile}, \code{reference}, or \code{reference_composite}).}
  \item{rest_service}{a REST URL for the IRMA/DataStore REST services.}
  \item{auth_type}{same values as argument \code{type} in function
    \code{httr::authenticate}. "Should be one of the following types
    supported by Curl: basic, digest, digest_ie, gssnegotiate, ntlm, any. It
    defaults to 'basic', the most common type."}
}
\value{

}
\details{

REST service URLs. See \code{https://irmaservices.nps.gov/}.

\code{"https://irmaservices.nps.gov/datastore/v7/rest/"}

\code{"https://irmaservices.nps.gov/datastore-secure/v7/rest/"}

}
\examples{
REFERENCE = "reference"
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"
AUTH_BASIC <- "basic"

ref_ids <- paste0(c(2305721, 2182981), collapse=",")

get_request_by_ref_ids(ref_ids, REFERENCE, REST_SERVICE_PUBLIC, AUTH_BASIC)

}
\author{Nick Bywater}
\keyword{}
