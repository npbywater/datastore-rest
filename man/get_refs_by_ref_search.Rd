\name{get_refs_by_ref_search}
\alias{get_refs_by_ref_search}
\title{Get Reference Profiles by REST URL query
  \code{ReferenceCodeSearch?=}}
\description{
Returns Reference Profiles by REST URL query
\code{ReferenceCodeSearch?=} from IRMA/DataStore.
}
\usage{
get_refs_by_ref_search(ref_ids, rest_svc_url, auth_type, simplify_to_df=TRUE)
}
\arguments{
  \item{ref_ids}{a vector of DataStore REFERENCE-IDs.}
  \item{rest_svc_url}{a REST URL for the IRMA/DataStore REST services.}
  \item{auth_type}{one of the following types supported by
    Curl: \code{basic} or \code{ntlm}.}
  \item{simplify_to_df}{}
}
\value{

}
\details{

Returns References from REST URL where query service type is
\code{ReferenceCodeSearch?=<up to 25 comma separarated
STRING-REFERENCE-IDs>}. The argument \code{ref_ids} is vector of
REFERENCE-IDs.

REST service URLs. See \code{https://irmaservices.nps.gov/}.

\code{https://irmaservices.nps.gov/datastore/v7/rest/} (public)

\code{https://irmaservices.nps.gov/datastore-secure/v7/rest/}
(requires authentication type 'ntlm')

}
\examples{
\dontrun{
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"
AUTH_BASIC <- "basic"

get_refs_by_ref_search(c(2305721, 2182981), REST_SERVICE_PUBLIC, AUTH_BASIC)
}
}

\author{Nick Bywater}
\keyword{}
