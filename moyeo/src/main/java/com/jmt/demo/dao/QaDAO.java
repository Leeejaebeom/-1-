package com.jmt.demo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.jmt.demo.model.Qa;

@Repository
public class QaDAO {

	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	@Autowired
		
	public List<Qa> findQa() {
        String sql = "SELECT * FROM qa ORDER BY qa_id DESC";
        return jdbcTemplate.query(sql, new QaRowMapper());
    }
	
	public void QaRegister(Qa qa){
		String sql = "INSERT INTO qa (user_id, title, question) VALUES(?,?,?)";
		jdbcTemplate.update(sql, qa.getUser_id(), qa.getTitle(), qa.getQuestion());
	}
	
	public List<Qa> QaSearch(String keyword){
		String sql = "SELECT qa_id, qa.user_id AS user_id, title, question, answer, qa.created_at AS created_at, qa.updated_at AS updated_at "
				+ "FROM qa, users "
				+ "WHERE qa.user_id = users.user_id AND (title LIKE ? OR username LIKE ?) ORDER BY qa.qa_id DESC";
		return jdbcTemplate.query(sql, new QaRowMapper(), "%"+keyword+"%", "%"+keyword+"%");
	}

    public int getSearchCount(String keyword) {
        String sql = "SELECT COUNT(*) "
                + "FROM qa, users "
                + "WHERE qa.user_id = users.user_id AND (title LIKE ? OR username LIKE ?)";
        return jdbcTemplate.queryForObject(sql, Integer.class, "%"+keyword+"%", "%"+keyword+"%");
    }
	
	
	private static final class QaRowMapper implements RowMapper<Qa> {
        @Override
        public Qa mapRow(ResultSet rs, int rowNum) throws SQLException {
            Qa qa = new Qa();
            qa.setQa_id(rs.getInt("qa_id"));
            qa.setUser_id(rs.getInt("user_id"));
            qa.setTitle(rs.getString("title"));
            qa.setQuestion(rs.getString("Question"));
            qa.setAnswer(rs.getString("Answer"));
            qa.setCreated_at(rs.getDate("created_at"));
            qa.setUpdated_at(rs.getDate("updated_at"));
            return qa;
        }
    }

	

}
