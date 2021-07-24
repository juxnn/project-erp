package comnos.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String type2;
	private String keyword1;
	private String keyword2;
	
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public int getForm() {
		return amount * (pageNum - 1);
	}
	
	public String[] getTypeArr() {
		
		if(type== null) {
			return new String[] {};
		}else {
			String[] types = type.split("");			
			return types;
		}		
	}
}
