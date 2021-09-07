package comnos.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EmployeeVO {

	private Long EMP_CODE;
	private String EMP_NAME;
	private Date EMP_DATE;
	private Integer STORE_NO;
	private Integer RANK_NO;
	private Integer DEPT_NO;
	private Date EMP_BIRTH;
	private String EMP_PHONE;
	private String EMP_ADDRESS;
	private String EMP_ADDRESS_SUB;
	private String EMP_SEX;
	private String EMP_EMAIL;
	
	private String EMP_PASSWORD;
	private Integer CHECK_RESIGNATION;
	final Integer WORKING_CODE = 1;
	final Integer RESIGN_CODE = 2;
	
	private String STORE_NAME;
	private String DEPT_NAME;
	private String RANK_NAME;
	
	private String MIN_DATE;
	private String MAX_DATE;
	
	private List<AuthVO> AUTH_LIST;
	
}
