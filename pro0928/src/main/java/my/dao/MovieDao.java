package my.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import my.model.Movie;
import my.model.MovieListView;
import my.util.JdbcUtil;

public class MovieDao {
	
	public void insert(Connection conn, Movie movie) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("insert into movie (title,maker,price,openDate,poster,freq)"
					+ " values(?,?,?,?,?,?)");
			pstmt.setString(1, movie.getTitle());
			pstmt.setString(2, movie.getMaker());
			pstmt.setInt(3, movie.getPrice());
			pstmt.setTimestamp(4, new Timestamp(movie.getOpenDate().getTime()));
			pstmt.setString(5, movie.getPoster());
			pstmt.setInt(6, movie.getFreq());
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public Movie selectById(Connection conn, int movieId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Movie movie = null; 
		try {
			pstmt = conn.prepareStatement
			("select * from movie where movieId = ?");
			pstmt.setInt(1, movieId);
			rs = pstmt.executeQuery();
			if (rs.next()){
				movie = new Movie(); 
				movie.setMovieId(rs.getInt(1));
				movie.setTitle(rs.getString(2));
				movie.setMaker(rs.getString(3));
				movie.setPrice(rs.getInt(4));
				movie.setOpenDate(rs.getTimestamp(5));
				movie.setPoster(rs.getString(6));
				movie.setFreq(rs.getInt(7));
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return movie;
	}
	
	public List<Movie> selectLike(Connection conn, String target, String keyword) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Movie movie = null; 
		List<Movie> movies = new ArrayList<Movie>();
		try {
			pstmt = conn.prepareStatement
			("select * from movie where " +target +" like ?");
			pstmt.setString(1, "%"+keyword+"%");
			rs = pstmt.executeQuery();
			while (rs.next()){
				movie = new Movie(); 
				movie.setMovieId(rs.getInt(1));
				movie.setTitle(rs.getString(2));
				movie.setMaker(rs.getString(3));
				movie.setPrice(rs.getInt(4));
				movie.setOpenDate(rs.getTimestamp(5));
				movie.setPoster(rs.getString(6));
				movie.setFreq(rs.getInt(7));
				movies.add(movie);
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return movies;
	}
	
	public List<Movie> selectOrder(Connection conn, String target, String direct) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Movie movie = null; 
		List<Movie> movies = new ArrayList<Movie>();
		try {
			pstmt = conn.prepareStatement
			("select * from movie order by " +target +" "+ direct);
			rs = pstmt.executeQuery();
			while (rs.next()){
				movie = new Movie(); 
				movie.setMovieId(rs.getInt(1));
				movie.setTitle(rs.getString(2));
				movie.setMaker(rs.getString(3));
				movie.setPrice(rs.getInt(4));
				movie.setOpenDate(rs.getTimestamp(5));
				movie.setPoster(rs.getString(6));
				movie.setFreq(rs.getInt(7));
				movies.add(movie);
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return movies;
	}
	
	public void update(Connection conn, Movie movie) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("update movie set title=?,maker=?,price=?, "
					+ "   opendate=? where movieId=?");
			pstmt.setString(1, movie.getTitle());
			pstmt.setString(2, movie.getMaker());
			pstmt.setInt(3, movie.getPrice());
			pstmt.setTimestamp(4, new Timestamp(movie.getOpenDate().getTime()));
			pstmt.setInt(5, movie.getMovieId());
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public void updateFreq(Connection conn, int movieId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("update movie set freq = freq+1 where movieId=?");
			pstmt.setInt(1, movieId);
			pstmt.executeUpdate();
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	public void deleteById(Connection conn, int movieId) 
			throws SQLException {
		PreparedStatement pstmt=null; 		
		try {
			pstmt = conn.prepareStatement
			("delete from movie where movieId = ?");
			pstmt.setInt(1, movieId);
			pstmt.executeUpdate();			
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public int selectCount(Connection conn) throws SQLException {
		Statement stmt = null; 
		ResultSet rs = null; 
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from movie");
			rs.next();
			return rs.getInt(1);
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(rs);
		}
	}
	
	public List<Movie> selectList(Connection conn) 
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Movie> movieList = null;
		try {
			pstmt = conn.prepareStatement
					("select * from movie ");			
			rs  = pstmt.executeQuery(); 
			movieList = new ArrayList<Movie>();
			while (rs.next()){
				Movie movie = new Movie();
				movie.setMovieId(rs.getInt(1));
				movie.setTitle(rs.getString(2));
				movie.setMaker(rs.getString(3));
				movie.setPrice(rs.getInt(4));
				movie.setOpenDate(rs.getTimestamp(5));
				movie.setPoster(rs.getString(6));
				movie.setFreq(rs.getInt(7));
				movieList.add(movie);
			}
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return movieList;
	}
	
	private static final int MOVIE_COUNT_PER_PAGE = 5;

	public MovieListView getMovieList(Connection conn, int pageNumber)
			throws SQLException {
		
		int currentPageNumber = pageNumber;
		try {
			
			int movieTotalCount = selectCount(conn);

			List<Movie> movieList = null;
			int firstRow = 0;
			int endRow = 0;
			if (movieTotalCount > 0) {
				firstRow =
				(pageNumber - 1) * MOVIE_COUNT_PER_PAGE;
				endRow = MOVIE_COUNT_PER_PAGE;
				movieList =selectListLimit(conn, firstRow, endRow);
			} else {
				currentPageNumber = 0;
				movieList = Collections.emptyList();
			}
			return new MovieListView(movieList,
					movieTotalCount, currentPageNumber,
					MOVIE_COUNT_PER_PAGE);
		} catch (SQLException e) {
			throw new SQLException("메시지 목록 구하기 실패: ");
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public List<Movie> selectListLimit(Connection conn, int offset, int count) 
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Movie> movieList = null;
		try {
			pstmt = conn.prepareStatement
					("select * from movie LIMIT ?, ?;");
			pstmt.setInt(1, offset);
	        pstmt.setInt(2, count);
			rs  = pstmt.executeQuery(); 
			movieList = new ArrayList<Movie>();
			while (rs.next()){
				Movie movie = new Movie();
				movie.setMovieId(rs.getInt(1));
				movie.setTitle(rs.getString(2));
				movie.setMaker(rs.getString(3));
				movie.setPrice(rs.getInt(4));
				movie.setOpenDate(rs.getTimestamp(5));
				movie.setPoster(rs.getString(6));
				movie.setFreq(rs.getInt(7));
				movieList.add(movie);
			}
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return movieList;
	}
}

	
	
