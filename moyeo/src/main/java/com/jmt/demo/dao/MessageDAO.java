package com.jmt.demo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.jmt.demo.model.Message;

import java.util.List;

@Repository
public class MessageDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void save(Message message) {
        String sql = "INSERT INTO message (user_id, content, plan_id) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, message.getUserId(), message.getContent(), message.getPlanId());
    }

    public Message getMessageById(Long id) {
        String sql = "SELECT * FROM message WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Message.class), id);
    }

    public List<Message> findByPlanId(Long planId) {
        String sql = "SELECT * FROM message WHERE plan_id = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Message.class), planId);
    }
}