package dto;

import java.math.BigDecimal;
import java.util.List;


import com.example.demo.Users;

public class WeightChart {
	private Users users;
	private List<BigDecimal> weights;
	
	 public WeightChart(Users user, List<BigDecimal> weights) {
	        this.users = user;
	        this.weights = weights;
	    }

	public Users getUser() {
		return users;
	}

	public void setUser(Users users) {
		this.users = users;
	}

	public List<BigDecimal> getWeights() {
		return weights;
	}

	public void setWeights(List<BigDecimal> weights) {
		this.weights = weights;
	}
}
