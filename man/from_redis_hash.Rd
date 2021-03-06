% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/redis_tools.R
\name{from_redis_hash}
\alias{from_redis_hash}
\title{Convert Redis hash}
\usage{
from_redis_hash(con, key, fields = NULL, f = as.character,
  missing = NA_character_)
}
\arguments{
\item{con}{A Redis connection object}

\item{key}{key of the hash}

\item{fields}{Optional vector of fields (if absent, all fields are
retrieved via \code{HGETALL}.}

\item{f}{Function to apply to the \code{list} of values retrieved
as a single set.  To apply element-wise, this will need to be
run via something like \code{Vectorize}.}

\item{missing}{What to substitute into the returned vector for
missing elements.  By default an NA will be added.  A
\code{stop} expression is OK and will only be evaluated if
values are missing.}
}
\description{
Convert a Redis hash to a character vector or list.
}

