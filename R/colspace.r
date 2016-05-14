#' Model spectra in a colorspace
#'
#' \code{colspace} Model reflectance spectra in a colorspace
#' 
#' @param modeldata (required) quantum catch color data. Can be either the result
#'  from \code{\link{vismodel}} or independently calculated data (in the form of a data frame
#'  with columns representing quantum catches).
#' @param space Which colorspace/model to use. Options are:
#' \itemize{
#' \item \code{auto}: if data is a result from \code{vismodel}, 
#' applies \code{di}, \code{tri} or \code{tcs} if input visual model had two, three or four
#' cones, respectively.
#' \item \code{di}: dichromatic colourspace
#' \item \code{tri}: trichromatic colourspace (i.e. Maxwell triangle)
#' \item \code{tcs}: tetrahedral colourspace (tetrachromatic)
#' \item \code{hexagon}: the colour-hexagon of Chittka (1992) (trichromatic)
#' \item \code{coc}: the colour-opponent-coding model of Backhaus (1991) (trichromatic)
#' \item \code{categorical}: the categorical fly-model of Troje (1993) (tetrachromatic)
#' \item \code{ciexyz}: CIEXYZ space
#' \item \code{cielab}: CIELAB space
#' }
#' 
#' @examples \dontrun{
#' data(flowers)
#' 
#' # Dichromat space
#' vis.flowers <- vismodel(flowers, visual = 'canis')
#' di.flowers <- colspace(vis.flowers, space = 'di')
#' summary(di.flowers)
#'
#' # Colour hexagon 
#' vis.flowers <- vismodel(flowers, visual = 'apis', qcatch = 'Ei', relative = FALSE, vonkries = TRUE, achro = 'l', bkg = 'green')
#' hex.flowers <- colspace(vis.flowers, space = 'hexagon')
#' plot(hex.flowers)
#' 
#' # Trichromat
#' vis.flowers <- vismodel(flowers, visual = 'apis')
#' tri.flowers <- colspace(vis.flowers, space = 'tri')
#' plot(tri.flowers)
#' 
#' # Tetrachromat
#' vis.flowers <- vismodel(flowers, visual = 'bluetit')
#' tcs.flowers <- colspace(vis.flowers, space = 'tcs')
#' }
#' 
#' @author Thomas White \email{thomas.white026@@gmail.com}
#' 
#' @export
#' 
#' @references Smith T, Guild J. (1932) The CIE colorimetric standards and their use.
#'    Transactions of the Optical Society, 33(3), 73-134.
#' @references Westland S, Ripamonti C, Cheung V. (2012). Computational colour science 
#'    using MATLAB. John Wiley & Sons.
#' @references Chittka L. (1992). The colour hexagon: a chromaticity diagram
#'    based on photoreceptor excitations as a generalized representation of 
#'    colour opponency. Journal of Comparative Physiology A, 170(5), 533-543.
#' @references Chittka L, Shmida A, Troje N, Menzel R. (1994). Ultraviolet as a 
#'    component of flower reflections, and the colour perception of Hymenoptera. 
#'    Vision research, 34(11), 1489-1508.
#' @references Troje N. (1993). Spectral categories in the learning behaviour
#'  of blowflies. Zeitschrift fur Naturforschung C, 48, 96-96.
#' @references Stoddard, M. C., & Prum, R. O. (2008). Evolution of avian plumage 
#'  color in a tetrahedral color space: A phylogenetic analysis of new world buntings. 
#'  The American Naturalist, 171(6), 755-776.
#' @references Endler, J. A., & Mielke, P. (2005). Comparing entire colour patterns 
#'  as birds see them. Biological Journal Of The Linnean Society, 86(4), 405-431.
#' @references Kelber A, Vorobyev M, Osorio D. (2003). Animal colour vision
#'    - behavioural tests and physiological concepts. Biological Reviews, 78,
#'    81 - 118.
#' @references Backhaus W. (1991). Color opponent coding in the visual system
#'  of the honeybee. Vision Research, 31, 1381-1397.

colspace <- function(modeldata, space = c('auto', 'di', 'tri', 'tcs', 'hexagon', 'coc', 'categorical', 'ciexyz', 'cielab')){
  
  space2 <- try(match.arg(space), silent = T)

  if(inherits(space2, 'try-error'))
    stop('Invalid colorspace selected')
  
  if(space2 == 'auto'){
  	switch(as.character(attr(modeldata, 'conenumb')),
  	  '2' = return(.dispace(modeldata)),
  	  '3' = return(.trispace(modeldata)),
  	  '4' = return(.tcs(modeldata))
  	  )
  } else{
  	switch(space2,
  	'di' = return(.dispace(modeldata)),
  	'tri' = return(.trispace(modeldata)),
  	'hexagon' = return(.hexagon(modeldata)),
  	'tcs' = return(.tcs(modeldata)),
  	'coc' = return(.coc(modeldata)),
  	'categorical' = return(.categorical(modeldata)),
  	'ciexyz' = return(.cie(modeldata, 'XYZ')),
  	'cielab' = return(.cie(modeldata, 'LAB'))
  	)
  }
  
}