#' A generic functions to search for files
#' @description
#' These functions help in searching for specific files in the user space.
#'
#' MYRLIB/flowr/conf folder           ## flowr/ngsflows internal default configurations
#' ~/flowr/conf                       ## flowr default home
#' @param x name of the file to search for
#' @param places places (paths) to look for it. Its best to use the defaults
#' @param urls urls to look for, works well for pipelines.
#' @param verbose be chatty?
#' @param ask ask before downloading or copying, not used !
#' @param ... not used
#'
#' @export
#'
#' @examples {
#' fetch_conf("torque.sh")
#' }
fetch <- function(x, places, urls, verbose = FALSE){
	y = sapply(places, list.files, pattern = paste0(x, "$"),
		full.names = TRUE)
	y = as.character(unlist(y))
	if(verbose) message(y)

	return(y)

}

#' @rdname fetch
#' @description
#' fetch_pipes(): Looks at: github repo: ngsflows/pipelines
#' @param silent applicable to fetch_pipes() only. Throw if no such pipe is available
#' @export
fetch_pipes <- function(x,
												places,
												urls = get_opts("flowr_pipe_urls"),
												silent = FALSE,
												ask = TRUE){
	if(missing(places)){
		places = c(
			system.file(package = "flowr", "pipelines"),
			system.file(package = "ngsflows", "pipelines"),
			get_opts("flow_pipe_paths"),
			getwd())
	}
	# 	if(missing(x))
	# 		avail_pipes(places)

	## in case of multiple files, use the last one
	r = fetch(paste0("^", x, ".R$"), places)
	r = tail(r, 1)
	def = gsub("R$", "def", r)
	conf = gsub("R$", "conf", r)

	if(!silent)
		if(length(r) == 0)
			stop(error("no.pipe"), x)
	return(list(pipe = r, def = def, conf = conf))
}



#' @rdname fetch
#' @description fetch_conf(): Searching for .conf files in various places
#' @export
fetch_conf <- function(x = "flowr.conf", places, ...){
	if(missing(places)){
		places = c(
			system.file(package = "flowr", "conf"),
			system.file(package = "ngsflows", "conf"),
			get_opts("flow_conf_path"), getwd())
	}

	x = paste0(x, "$") ## x should be a full file name
	fetch(x, places = places, ...)
}


search_conf <- function(...){
	.Deprecated("fetch_conf")
	fetch_conf(...)
}

## testing....
avail_pipes <- function(){
	urls = "https://api.github.com/repositories/19354942/contents/inst/examples?recursive=1"
	urls = "https://api.github.com/repos/sahilseth/flowr/git/trees/master?recursive=1"
}
