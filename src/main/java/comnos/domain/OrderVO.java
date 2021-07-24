package comnos.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private String ORDER_NO;
	private Date ORDER_DATE;
	private int STORE_NO;
	private String PRODUCT_NO;
	private int ORDER_EA;
	private int ORDER_STATUS;
	private long EMP_CODE;	
}
