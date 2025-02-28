\name{get_prog_proj_products_dt}
\alias{get_prog_proj_products_dt}
\title{Get program-project-profile-products as data.table}
\description{Return the products of DataStore program-projects as a
  \code{data.table}. Additonal columns added for context. Order columns
  in a logical format.}
\usage{
get_prog_proj_products_dt(program_ref_id, rest_svc_url = getOption("dr.rest_url"), program_name = "")
}
\arguments{
  \item{program_ref_id}{a PROGRAM-REFERENCE-ID in DataStore. For
    example, the CAKN program Reference ID 2210836.}
  \item{rest_svc_url}{a REST URL for the IRMA/DataStore REST services.}
  \item{program_name}{user-supplied program name for
    \code{program_ref_id}, such as "CAKN".}
}
\details{

}
\value{
A data.table with the following columns.

The progam Reference:
\item{program_name}{a user-supplied program name.}
\item{program_ref_id}{the program Reference ID.}

The project of a program Reference:
\item{project_title}{the title of a project that belongs to a program.}
\item{project_ref_id}{the project reference ID.}
\item{project_ref_url}{the project Reference URL.}

The product of a project Reference:
\item{referenceId}{the product Reference ID.}
\item{referenceUrl}{the product Reference URL. \bold{NOTE:} This value
   is not returned by DataStore. Rather is calculated in this function
   using the DataStore URL and the \code{referenceId}.}
\item{referenceType}{the type of product Reference.}
\item{referenceGroupType}{the group that the Reference type belongs to.
  \bold{NOTE:} Value NOT returned by REST resource \code{ref_profile}
  type.}
\item{dateOfIssue}{date product Reference issued.}
\item{lifecycle}{the state of the current product. E.g. "active",
  "draft", etc.}
\item{visibility}{the visibility of the product. E.g. "public",
  "internal", etc.}
\item{fileCount}{count of files associated with product.}
\item{fileAccess}{access permission to product.}
\item{title}{title of product.}
\item{citation}{citation name of product.}
\item{allContactsDisplayCitation}{\bold{NOTE:} Value NOT returned by
  REST resource \code{ref_profile} type.}
\item{contacts}{\bold{NOTE:} Value NOT returned by
  REST resource \code{ref_profile} type.}
\item{typeName}{type of product. E.g. "geospatial dataset".}
\item{isDOI}{does product have a DOI number?}
\item{units}{a comma separated list (as string) of NPS units used to
  produced product content.}
\item{contentProducingUnits}{\bold{NOTE:} Value NOT returned by
  REST resource \code{ref_profile} type.}
\item{linkedResources}{a comma separated string of linked resource
  elements, where each element name and its value are separated by an
  equals (\code{=}) sign. If linked resource list is of length two or
  more, the linked resource strings are separated by a newline.}
\item{newVersion}{the Reference ID of the newer product Reference version.}
\item{mostRecentVersion}{the most recent version of Reference ID of the
  newer product Reference version. \bold{NOTE:} Value NOT returned by
  REST resource \code{ref_profile} type. }
}
\author{
Nick Bywater
}
\examples{
}
