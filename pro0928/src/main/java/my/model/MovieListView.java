package my.model;

import java.util.List;

public class MovieListView {

private int movieTotalCount;
private int currentPageNumber;
private List<Movie> movieList;
private int pageTotalCount;
private int movieCountPerPage;

public MovieListView(List<Movie> movieList, int movieTotalCount,
		int currentPageNumber, int movieCountPerPage) {
	this.movieList = movieList;
	this.movieTotalCount = movieTotalCount;
	this.currentPageNumber = currentPageNumber;
	this.movieCountPerPage = movieCountPerPage;
	calculatePageTotalCount();
}

private void calculatePageTotalCount() {
	if (movieTotalCount == 0) {
		pageTotalCount = 0;
	} else {
		pageTotalCount = movieTotalCount / movieCountPerPage;
		if (movieTotalCount % movieCountPerPage > 0) {
			pageTotalCount++;
		}
	}
}

public int getMovieTotalCount() {
	return movieTotalCount;
}

public void setMovieTotalCount(int movieTotalCount) {
	this.movieTotalCount = movieTotalCount;
}

public int getCurrentPageNumber() {
	return currentPageNumber;
}

public void setCurrentPageNumber(int currentPageNumber) {
	this.currentPageNumber = currentPageNumber;
}

public List<Movie> getMovieList() {
	return movieList;
}

public void setMovieList(List<Movie> movieList) {
	this.movieList = movieList;
}

public int getPageTotalCount() {
	return pageTotalCount;
}

public void setPageTotalCount(int pageTotalCount) {
	this.pageTotalCount = pageTotalCount;
}

public int getMovieCountPerPage() {
	return movieCountPerPage;
}

public void setMovieCountPerPage(int movieCountPerPage) {
	this.movieCountPerPage = movieCountPerPage;
}



}