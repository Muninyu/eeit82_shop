package dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.persistence.Column;



public class InputData {
	
	private String real_name;
	private String email;
	private String password;
	private String nickname;
	 private String gender;
	 @Column
	    private Date birthday;
	 private String phone;
	 @Column(precision = 5, scale = 2)
	 	private BigDecimal height_cm;
	 @Column(precision = 5, scale = 2)
	 	private BigDecimal target_weight;
	 @Column(columnDefinition = "TEXT")
	    private String face;  
	 private String activity_level;
	 private String purpose;
	 @Column(precision = 5, scale = 2)
	 	private BigDecimal current_weight;
	
	 @Column(nullable = false, updatable = false, insertable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	    private Timestamp update_at;

	public String getReal_name() {
		return real_name;
	}

	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	

	public BigDecimal getHeight_cm() {
		return height_cm;
	}

	public void setHeight_cm(BigDecimal height_cm) {
		this.height_cm = height_cm;
	}

	public BigDecimal getTarget_weight() {
		return target_weight;
	}

	public void setTarget_weight(BigDecimal target_weight) {
		this.target_weight = target_weight;
	}

	public String getFace() {
		return face;
	}

	public void setFace(String face) {
		this.face = face;
	}

	public String getActivity_level() {
		return activity_level;
	}

	public void setActivity_level(String activity_level) {
		this.activity_level = activity_level;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public BigDecimal getCurrent_weight() {
		return current_weight;
	}

	public void setCurrent_weight(BigDecimal current_weight) {
		this.current_weight = current_weight;
	}

	public Timestamp getUpdate_at() {
		return update_at;
	}

	public void setUpdate_at(Timestamp update_at) {
		this.update_at = update_at;
	}
	public void setBirthdayFromTimestamp(long timestamp) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String formattedDate = sdf.format(new java.util.Date(timestamp));
		this.birthday = java.sql.Date.valueOf(formattedDate);
	}
		
		
		
}
