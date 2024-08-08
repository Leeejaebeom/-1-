package com.jmt.demo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.jmt.demo.model.Faq;

@Repository
public class FaqDAO {
	
	@Autowired
    private JdbcTemplate jdbcTemplate;
	
	public List<Faq> findFaq() {
        String sql = "SELECT * FROM faq ORDER BY faq_id DESC";
        return jdbcTemplate.query(sql, new FaqRowMapper());
    }
	public Faq findFaqById(Long id) {
	    String sql = "SELECT * FROM faq WHERE faq_id = ?";
	    return jdbcTemplate.queryForObject(sql, new FaqRowMapper(),id);
	}
	
	
	
	private static final class FaqRowMapper implements RowMapper<Faq> {
        @Override
        public Faq mapRow(ResultSet rs, int rowNum) throws SQLException {
            Faq Faq = new Faq();
            
            Faq.setFaq_id(rs.getLong("faq_id"));
            Faq.setQuestion(rs.getString("question"));
            Faq.setAnswer(rs.getString("answer"));
           
           return Faq;
        }
        
    }
}
