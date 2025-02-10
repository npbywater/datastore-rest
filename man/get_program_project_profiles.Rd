\name{get_program_project_profiles}
\alias{get_program_project_profiles}
\title{Get program-project-profiles from IRMA/DataStore}
\description{
  Return a list of PROJECT-REFERENCE-PROFILEs called by IRMA/DataStore
  REST service URL query: \code{Profile?q=}.
}
\usage{
get_program_project_profiles(program_ref_id, rest_service, auth_type)
}
\arguments{
  \item{program_ref_id}{a PROGRAM-REFERENCE-ID in DataStore. For
    example, the CAKN program Reference ID 2210836.}
  \item{rest_service}{a REST URL for the IRMA/DataStore REST services.}
  \item{auth_type}{one of the following types supported by
    Curl: \code{basic} or \code{ntlm}.}
}

\value{
}

\details{
This function returns a list of PROJECT-REFERENCE-PROFILEs (called by
REST service URL query: \code{Profile?q=}) associated with a
PROGRAM-REFERENCE-ID. Each element, of the returned list, is a sub-list of
up to 25 grouped PROJECT-REFERENCE-PROFILES as returned by REST query
\code{Profile?q=<up to 25 comma separated PROJECT-REFERENCE-IDs>}.

NOTE: The returned list object is assigned the class name \code{project}
      so that its type can be tested when passed to another function.

NOTE: The automatic coercion of JSON arrays (via function
      \code{jsonlite::fromJSON}) to \code{data.frame}s causes node
      navigation issues for PROJECT-REFERENCE-PROFILEs when chunking up to 25
      profiles at a time; so we process the JSON (returned by the REST
      service) without simplifying it to \code{data.frame}s by coercion.
      That is, this function is called to process the project references:
      (\code{jsonlite::fromJSON(json, simplifyDataFrame = FALSE)}).

REST service URLs. See \code{https://irmaservices.nps.gov/}.

\code{https://irmaservices.nps.gov/datastore/v7/rest/} (public)

\code{https://irmaservices.nps.gov/datastore-secure/v7/rest/}
(requires authentication type 'ntlm')
}

\examples{
\dontrun{
CAKN_PROGRAM_REF_ID <- 2210836
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"
AUTH_BASIC <- "basic"

program_project_profiles <- get_program_project_profiles(CAKN_PROGRAM_REF_ID, REST_SERVICE_PUBLIC, AUTH_BASIC)

# Get first project.
first_project <- head(program_project_profiles[[1]],1)

# Get all products for first project.
first_project[[1]]$products
}
}
\author{Nick Bywater}
\keyword{}
