package com.jmt.demo.model;

import java.util.Date;
import lombok.Data;

@Data
public class Qa {

	private int qa_id;
	private int user_id;
	private String title;
	private String question;
	private String answer;
	private Date created_at;
    private Date updated_at;

	private User author;
}
