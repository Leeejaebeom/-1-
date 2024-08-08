package com.jmt.demo.model;

import java.util.Date;

import lombok.Data;

@Data
public class User {

	private int user_id;
	private String username;
	private String password;
	private String email;
	private Date created_at;
	private Date updated_at;
	private String social;
	
}
