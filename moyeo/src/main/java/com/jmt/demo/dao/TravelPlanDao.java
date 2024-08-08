package com.jmt.demo.dao;

import com.jmt.demo.model.TravelPlan;
import com.jmt.demo.model.TravelRoutes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.sql.*;
import java.util.List;

@Repository
public class TravelPlanDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<TravelPlan> findAll() {
        String sql = "SELECT * FROM travel_plans ORDER BY plan_id DESC";
        return jdbcTemplate.query(sql, new TravelPlanRowMapper());
    }

    public TravelPlan findById(Long planId) {
        String sql = "SELECT * FROM travel_plans WHERE plan_id = ?";
        return jdbcTemplate.queryForObject(sql, new TravelPlanRowMapper(), planId);
    }

    @Transactional
    public Long save(TravelPlan travelPlan, List<TravelRoutes> travelRoutesList) {
        String sqlPlan = "INSERT INTO travel_plans (user_id, title, description, start_date, end_date, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        // TravelPlan 저장
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(sqlPlan, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, travelPlan.getUser_id());
                ps.setString(2, travelPlan.getTitle());
                ps.setString(3, travelPlan.getDescription());
                ps.setDate(4, new java.sql.Date(travelPlan.getStart_date().getTime()));
                ps.setDate(5, new java.sql.Date(travelPlan.getEnd_date().getTime()));
                return ps;
            }
        }, keyHolder);

        Long planId = keyHolder.getKey().longValue();
        System.out.println("Generated Plan ID: " + planId);  // 디버그 로그 추가

        // TravelRoutes 저장
        String sqlRoute = "INSERT INTO travel_routes (plan_id, location, day, `order`) VALUES (?, ?, ?, ?)";
        for (TravelRoutes travelRoute : travelRoutesList) {
            System.out.println("Saving route for plan ID " + planId + ": " + travelRoute.getLocation());  // 디버그 로그 추가
            jdbcTemplate.update(sqlRoute, planId, travelRoute.getLocation(), travelRoute.getDay(), travelRoute.getOrder());
        }

        return planId;
    }

    public void update(TravelPlan travelPlan) {
        String sql = "UPDATE travel_plans SET title = ?, description = ?, start_date = ?, end_date = ?, updated_at = NOW() WHERE plan_id = ?";
        jdbcTemplate.update(sql, travelPlan.getTitle(), travelPlan.getDescription(), travelPlan.getStart_date(), travelPlan.getEnd_date(), travelPlan.getPlan_id());
    }

    public void delete(Long planId) {
        String sql = "DELETE FROM travel_plans WHERE plan_id = ?";
        jdbcTemplate.update(sql, planId);
    }
    
    public List<TravelPlan> PlanSearch(String keyword){
		String sql = "SELECT plan_id, travel_plans.user_id AS user_id, title, description, start_date, end_date, travel_plans.created_at AS created_at, travel_plans.updated_at AS updated_at "
				+ "FROM travel_plans, users "
				+ "WHERE travel_plans.user_id = users.user_id AND (title LIKE ? OR username LIKE ?) ORDER BY travel_plans.plan_id DESC";
		return jdbcTemplate.query(sql, new TravelPlanRowMapper(), "%"+keyword+"%", "%"+keyword+"%");
	}

    public List<TravelPlan> getTravelPlans(int offset, int pageSize) {
        String sql = "SELECT * FROM travel_plans LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, new Object[]{pageSize, offset}, new TravelPlanRowMapper());
    }

    public int getTravelPlansCount() {
        String sql = "SELECT COUNT(*) FROM travel_plans";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public boolean hasNewParticipationRequests(int userId) {
        String sql = "SELECT COUNT(*) FROM companions c " +
                "JOIN travel_plans p ON c.plan_id = p.plan_id " +
                "WHERE p.user_id = ? AND c.isAllow = FALSE";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId);
        return count != null && count > 0;
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