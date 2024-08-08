package com.jmt.demo.dao;

import com.jmt.demo.dto.CompanionRequestDto;
import com.jmt.demo.model.Companion;
import com.jmt.demo.model.TravelPlan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.List;

@Repository
public class CompanionDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * 특정 사용자와 여행 계획에 대한 기존 신청 여부를 확인하는 메서드
     *
     * @param userId 사용자 ID
     * @param planId 여행 계획 ID
     * @return 신청 존재 여부 (true/false)
     */
    public boolean existsByUserIdAndPlanId(long userId, long planId) {
        String sql = "SELECT COUNT(*) FROM companions WHERE user_id = ? AND plan_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, planId);
        return count != null && count > 0;
    }

    /**
     * 새로운 동행 신청을 저장하는 메서드
     *
     * @param companion 동행 신청 객체
     * @return 생성된 동행 신청 ID
     */
    public Long save(Companion companion) {
        String sql = "INSERT INTO companions (user_id, plan_id, message, isAllow, created_at) VALUES (?, ?, ?, ?, NOW())";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setLong(1, companion.getUserId());
            ps.setLong(2, companion.getPlanId());
            ps.setString(3, companion.getMessage());
            ps.setBoolean(4, companion.isAllow());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().longValue();
    }

    /**
     * 사용자에게 허용된 여행 계획 목록을 조회하는 메서드
     *
     * @param userId 사용자 ID
     * @return 사용자에게 허용된 여행 계획 목록
     */
    public List<TravelPlan> findAllowedPlansByUserId(int userId) {
        String sql = "SELECT tp.* FROM travel_plans tp " +
                "JOIN companions c ON tp.plan_id = c.plan_id " +
                "WHERE c.user_id = ? AND c.isAllow = TRUE";

        return jdbcTemplate.query(sql, new Object[]{userId}, new TravelPlanRowMapper());
    }

    /**
     * 특정 사용자에게 신청된 참여 요청 목록을 조회하는 메서드
     *
     * @param userId 사용자 ID
     * @return 신청된 참여 요청 목록
     */
    public List<CompanionRequestDto> findRequestsByUserId(Long userId) {
        String sql = "SELECT c.companion_id, u.username, c.message " +
                "FROM companions c " +
                "JOIN travel_plans p ON c.plan_id = p.plan_id " +
                "JOIN users u ON c.user_id = u.user_id " +
                "WHERE p.user_id = ? AND c.isAllow = FALSE";
        return jdbcTemplate.query(sql, new Object[]{userId}, (rs, rowNum) -> {
            CompanionRequestDto dto = new CompanionRequestDto();
            dto.setCompanionId(rs.getLong("companion_id"));
            dto.setUsername(rs.getString("username"));
            dto.setMessage(rs.getString("message"));
            return dto;
        });
    }

    /**
     * 참여 요청을 승인하는 메서드
     *
     * @param companionId 승인할 동행 신청 ID
     * @return 업데이트된 행의 수
     */
    public boolean approveRequest(Long companionId) {
        String sql = "UPDATE companions SET isAllow = 1 WHERE companion_id = ?";
        int rowsAffected = jdbcTemplate.update(sql, companionId);
        return rowsAffected > 0;
    }

    /**
     * 모든 동행 신청을 조회하는 메서드
     *
     * @return 동행 신청 목록
     */
    public List<Companion> findAll() {
        String sql = "SELECT * FROM companions ORDER BY companion_id DESC";
        return jdbcTemplate.query(sql, new CompanionRowMapper());
    }

    /**
     * 특정 사용자 ID로 동행 신청 목록을 조회하는 메서드
     *
     * @param userId 사용자 ID
     * @return 해당 사용자의 동행 신청 목록
     */
    public List<Companion> findByUserId(int userId) {
        String sql = "SELECT * FROM companions WHERE user_id = ?";
        return jdbcTemplate.query(sql, new CompanionRowMapper(), userId);
    }

    /**
     * 특정 여행 계획 ID로 동행 신청 목록을 조회하는 메서드
     *
     * @param planId 여행 계획 ID
     * @return 해당 여행 계획의 동행 신청 목록
     */
    public List<Companion> findByPlanId(int planId) {
        String sql = "SELECT * FROM companions WHERE plan_id = ?";
        return jdbcTemplate.query(sql, new CompanionRowMapper(), planId);
    }

    /**
     * 동행 신청을 삭제하는 메서드
     *
     * @param companionId 삭제할 동행 신청의 ID
     */
    public void delete(Long companionId) {
        String sql = "DELETE FROM companions WHERE companion_id = ?";
        jdbcTemplate.update(sql, companionId);
    }

    /**
     * 동행 신청을 업데이트하는 메서드
     *
     * @param companion 업데이트할 동행 신청 객체
     */
    public void update(Companion companion) {
        String sql = "UPDATE companions SET isAllow = ?, message = ? WHERE companion_id = ?";
        jdbcTemplate.update(sql, companion.isAllow(), companion.getMessage(), companion.getCompanionId());
    }

    private static final class CompanionRowMapper implements RowMapper<Companion> {
        @Override
        public Companion mapRow(ResultSet rs, int rowNum) throws SQLException {
            Companion companion = new Companion();
            companion.setCompanionId(rs.getLong("companion_id"));
            companion.setUserId(rs.getInt("user_id"));
            companion.setPlanId(rs.getLong("plan_id"));
            companion.setMessage(rs.getString("message"));
            companion.setAllow(rs.getBoolean("isAllow"));
            companion.setCreatedAt(rs.getTimestamp("created_at"));
            return companion;
        }
    }

    private static final class TravelPlanRowMapper implements RowMapper<TravelPlan> {
        @Override
        public TravelPlan mapRow(ResultSet rs, int rowNum) throws SQLException {
            TravelPlan travelPlan = new TravelPlan();
            travelPlan.setPlan_id(rs.getLong("plan_id"));
            travelPlan.setUser_id(rs.getInt("user_id"));
            travelPlan.setTitle(rs.getString("title"));
            travelPlan.setDescription(rs.getString("description"));
            travelPlan.setStart_date(rs.getDate("start_date"));
            travelPlan.setEnd_date(rs.getDate("end_date"));
            travelPlan.setCreated_at(rs.getTimestamp("created_at"));
            travelPlan.setUpdated_at(rs.getTimestamp("updated_at"));
            return travelPlan;
        }
    }
}