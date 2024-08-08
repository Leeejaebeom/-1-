package com.jmt.demo.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.jmt.demo.model.TravelRoutes;

@Repository
public class TravelRoutesDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	


	/**
	 * TravelRoutesDAO에선 save, findAll이 필요하지 않을거 같습니다
	 */
//	public void save(TravelRoutes travelRoute) {
//        String sql = "INSERT INTO travel_routes (plan_id, location, day, `order`) VALUES (?, ?, ?, ?)";
//        jdbcTemplate.update(sql, travelRoute.getPlan_id(), travelRoute.getLocation(), travelRoute.getDay(), travelRoute.getOrder());
//    }

    public List<TravelRoutes> findAll() {
        String sql = "SELECT * FROM travel_routes";
        return jdbcTemplate.query(sql, new TravelRoutesRowMapper());
    }
    public List<TravelRoutes> findByPlanId(Long plan_id) {
        String sql = "SELECT * FROM travel_routes WHERE plan_id = ?";
        return jdbcTemplate.query(sql, new TravelRoutesRowMapper(), plan_id);
    }
    
	
	  private static final class TravelRoutesRowMapper implements RowMapper<TravelRoutes> {
	        @Override
	        public TravelRoutes mapRow(ResultSet rs, int rowNum) throws SQLException {
	        	TravelRoutes TravelRoutes = new TravelRoutes();
	        	TravelRoutes.setRoute_id(rs.getLong("route_id"));
	        	TravelRoutes.setPlan_id(rs.getLong("plan_id"));
	        	TravelRoutes.setLocation(rs.getString("location"));
	        	TravelRoutes.setDay(rs.getInt("day"));
	        	TravelRoutes.setOrder(rs.getInt("order"));
	        	
	            return TravelRoutes;
	        }
	    }
	  
}
