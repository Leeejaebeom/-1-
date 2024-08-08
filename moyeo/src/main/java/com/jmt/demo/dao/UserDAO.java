package com.jmt.demo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.jmt.demo.model.User;

@Repository
public class UserDAO {
    // BCryptPasswordEncoder 생성 -> 비밀번호 암호화에 필요
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 모든 사용자 조회 메서드
     * @return List<User> 사용자 리스트
     */
	public List<User> allUsers() {
        String sql = "SELECT * FROM users";
        return jdbcTemplate.query(sql, new UserRowMapper());
    }

    /**
     * 새로운 사용자 저장 메서드
     * @param user 저장할 사용자 객체
     */
    public void save(User user) {
        // 비밀번호를 암호화하여 저장
        String encryptedPassword = passwordEncoder.encode(user.getPassword());
        String sql = "INSERT INTO users(username, password, email, created_at, updated_at, social) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, user.getUsername(), encryptedPassword, user.getEmail(), user.getCreated_at(), user.getUpdated_at(), user.getSocial());
    }

    /**
     * 이메일을 통해 사용자를 조회하는 메서드
     * @param email 조회할 사용자의 이메일
     * @return 조회된 사용자 객체, 미존재시 null
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{email}, new UserRowMapper());
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public String findUsernameByUserId(int userId) {
        String sql = "SELECT username FROM users WHERE user_id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{userId}, String.class);
    }

    /**
     * User 객체 매핑을 위한 클래스
     */
	private static final class UserRowMapper implements RowMapper<User> {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setUser_id(rs.getInt("user_id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setCreated_at(rs.getTimestamp("created_at"));
            user.setUpdated_at(rs.getTimestamp("updated_at"));
            user.setSocial(rs.getString("social"));
            return user;
        }
    }
}
