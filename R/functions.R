


doi2qmd <- function(doi = NULL, filename = NULL) {

  doi <- gsub("https://doi.org/", "", doi)

  require(rcrossref)

  dt <- cr_works(doi)$data

  content <- c(
    "---",
    paste0("title: '", dt$title, "'"),
    "type: 'article'",
    paste0("author: '", paste(dt$author[[1]]$family, collapse = ", "), "'"),
    paste0("year: '", substr(dt$created, start = 1, stop = 4), "'"),
    paste0("publication: '", dt$container.title, "'"),
    paste0("preprint: 'https://doi.org/", doi, "'"),
    paste0("doi: 'https://doi.org/", doi, "'"),
    paste0("pdf: 'https://doi.org/", doi, "'"),
    paste0("data: 'https://doi.org/", doi, "'"),
    paste0("code: 'https://doi.org/", doi, "'"),
    "toc: false",
    "categories: ",
    "  - journal article",
    "---",
    "",
    "## Citation",
    "",
    paste0("> ", cr_cn(doi, format = "text", style = "ecological-entomology")),
    "",
    "## Abstract",
    "",
    # cr_abstract(doi),
    dt$abstract,
    "",
    "### Publication metrics",
    "",
    "<br>",
    "",
    paste0('<span class="__dimensions_badge_embed__" data-doi="', doi, '" data-hide-zero-citations="true" data-legend="always"></span><script async src="https://badge.dimensions.ai/badge.js" charset="utf-8"></script>'),
    "",
    paste0("<script type='text/javascript' src='https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js'></script>",
           '<div data-badge-details="right" data-badge-type="medium-donut" data-doi="', doi, '" data-hide-no-mentions="true" class="altmetric-embed"></div>'),
    "",
    paste0('<div class="scite-badge" data-doi="', doi, '" data-layout="horizontal" data-show-zero="false" data-show-labels="true"></div><link rel="stylesheet" type="text/css" href="https://cdn.scite.ai/badge/scite-badge-latest.min.css"><script async type="application/javascript" src="https://cdn.scite.ai/badge/scite-badge-latest.min.js"></script>'),
    ""
  )

  if (!file.exists(here::here("publications", paste0(filename, ".qmd")))) {
    writeLines(content, con = here::here("publications", paste0(filename, ".qmd")))
  }


}



metrics_badges <- function(doi = NULL) {

  dimensions <- paste0('<span class="__dimensions_badge_embed__" data-doi="', doi, '" data-hide-zero-citations="true" data-legend="always"></span><script async src="https://badge.dimensions.ai/badge.js" charset="utf-8"></script>"')

  altmetric <- paste0("<script type='text/javascript' src='https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js'></script>",
                      '<div data-badge-details="right" data-badge-type="medium-donut" data-doi="', doi, '" data-hide-no-mentions="true" class="altmetric-embed"></div>')

  scite <- paste0('<div class="scite-badge" data-doi="', doi, '" data-layout="horizontal" data-show-zero="false" data-show-labels="true"></div><link rel="stylesheet" type="text/css" href="https://cdn.scite.ai/badge/scite-badge-latest.min.css"><script async type="application/javascript" src="https://cdn.scite.ai/badge/scite-badge-latest.min.js"></script>')

  cat(dimensions, altmetric, scite, sep = "\n\n")

}
