#' Visual model summary
#'
#' Returns the attributes used when calculating a visual model using [vismodel()]
#'
#' @param object (required) Results of [vismodel()]
#' @param ... class consistency (ignored)
#'
#' @return Returns all attributes chosen when calculating the visual model, as well as the
#' default `data.frame` summary
#'
#' @export
#'
#' @examples
#' data(sicalis)
#' vis.sicalis <- vismodel(sicalis, visual = "avg.uv")
#' summary(vis.sicalis)
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references Vorobyev, M., Osorio, D., Bennett, A., Marshall, N., & Cuthill, I. (1998).
#'  Tetrachromacy, oil droplets and bird plumage colours. Journal Of Comparative
#'  Physiology A-Neuroethology Sensory Neural And Behavioral Physiology, 183(5), 621-633.
#' @references Hart, N. S. (2001). The visual ecology of avian photoreceptors.
#'  Progress In Retinal And Eye Research, 20(5), 675-703.
#' @references Stoddard, M. C., & Prum, R. O. (2008). Evolution of avian plumage
#'  color in a tetrahedral color space: A phylogenetic analysis of new world buntings.
#'  The American Naturalist, 171(6), 755-776.
#' @references Endler, J. A., & Mielke, P. (2005). Comparing entire colour patterns
#'  as birds see them. Biological Journal Of The Linnean Society, 86(4), 405-431.

summary.vismodel <- function(object, ...) {
  chkDots(...)

  if (is.null(attr(object, "qcatch"))) {
    message("Cannot return full vismodel summary on subset data")
    return(summary(as.data.frame(object)))
  }

  cat(
    "visual model options:\n",
    "* Quantal catch:", attr(object, "qcatch"), "\n",
    "* Visual system, chromatic:", attr(object, "visualsystem.chromatic"), "\n",
    "* Visual system, achromatic:", attr(object, "visualsystem.achromatic"), "\n",
    "* Illuminant:", attr(object, "illuminant"), "\n",
    "* Background:", attr(object, "background"), "\n",
    "* Transmission:", attr(object, "transmission"), "\n",
    "* Relative:", attr(object, "relative"), "\n"
  )
  summary.data.frame(object)
}
