\name{project_profiles_to_products_dt}
\alias{project_profiles_to_products_dt}
\title{Combine project-reference-profiles into a products data table}
\description{
Given a list of PROJECT-REFERENCE-PROFILEs (as defined by DataStore
API), combine them into a \code{data.table}.
}
\usage{
project_profiles_to_products_dt(project_profiles)
}
\arguments{
  \item{program_profiles}{This is a list of PROJECT-REFERENCE-PROFILEs
    (see definition in \bold{Details}). It is expected that this
    argument can be tested with the 'isa' function, to determine if it
    is of type \code{project}.}
}
\value{
}
\details{
Given a list of PROJECT-REFERENCE-PROFILEs (as returned from the
function \code{get_program_project_profiles}); combine (in the sense of
\code{data.table::rbindlist}) these project-lists into a products
\code{data.table}. This function returns a \code{data.table} of
PROJECT-PRODUCT-REFERENCE-PROFILES.

NOTE: It is expected that this argument can be tested with the 'isa'
  function, to determine if it is of type 'project'.

NOTE: The product-list elements 'units' and 'linkedResources' are
  collapsed into a comma separated string so that the
  \code{data.table::rbindlist} can easily convert the list to a
  \code{data.table}.
}

\examples{
CAKN_PROGRAM_REF_ID <- 2210836
REST_SERVICE_PUBLIC <- "https://irmaservices.nps.gov/datastore/v7/rest/"
AUTH_BASIC <- "basic"

project_profiles <- get_program_project_profiles(CAKN_PROGRAM_REF_ID, REST_SERVICE_PUBLIC, AUTH_BASIC)

project_products <- project_profiles_to_products_dt(project_profiles)

head(project_products)

}
\author{Nick Bywater}
\keyword{}
