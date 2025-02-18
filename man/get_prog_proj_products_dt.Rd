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
A data.table with the following columns:
\item{program_name}{user-supplied program name}
\item{program_ref_id}{program Reference ID}
\item{project_title}{project title}
\item{project_ref_id}{project reference ID}
\item{project_ref_url}{project Reference URL}
\item{referenceId}{product Reference ID}
\item{referenceUrl}{product Reference URL}
\item{newVersion}{date of new product Reference version}
\item{referenceType}{type of product Reference}
\item{dateOfIssue}{date product Reference issued}
\item{lifecycle}{the state of the current product. E.g. "active",
  "draft", etc.}
\item{visibility}{the visibility of the product. E.g. "public",
  "internal", etc.}
\item{fileCount}{count of files associated with product}
\item{fileAccess}{access permission to product}
\item{title}{title of product.}
\item{citation}{citation name of product}
\item{typeName}{type of product. E.g. "geospatial dataset".}
\item{isDOI}{does product have a DOI number?}
\item{units}{NPS units used to produced product content}

}
\author{
Nick Bywater
}
}
\examples{
}
