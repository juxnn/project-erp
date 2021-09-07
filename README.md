# :pushpin: Comnos(ERP System)
>전사적 자원관리 System  
>http://54.180.128.201/comnos/main/home


![컴노스 PPT 최종 수정본](https://user-images.githubusercontent.com/80299163/132378386-d9574d57-05e1-403c-a986-ced03548af6c.png)

</br>

## ✔ 1. 제작 기간 & 참여 인원
- 2021년 7월 12일 ~ 8월 21일 (6주)
- 개인 프로젝트

</br>

## ✔ 2. 사용 기술
#### `Back-end`
  - Java 8
  - Spring Framework 5.0.7
  - MySQL 10.3.28
  - Spring Security
#### `Front-end`
  - HTML
  - CSS
  - JavaScript

</br>

## ✔ 3. ERD 설계

![ERD](https://user-images.githubusercontent.com/80299163/132377493-f0ff99b7-5583-4466-9aff-9b683b8a61ef.jpg)


## ✔ 4. 프로젝트 핵심 설명
>로그인한 사원의 부서 정보에 따라, 접근 가능한 페이지가 달라집니다.<br>
>직급에 따라 몇몇 직급은 특정 업무에는 접근할 수 없습니다.

<details>
<summary><b> 프로젝트 핵심 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 프로젝트 설명
![수정1](https://user-images.githubusercontent.com/80299163/132401792-7d9d0076-c9df-4b33-918a-ca60e1334708.png)

![수정2](https://user-images.githubusercontent.com/80299163/132402422-acff080f-a206-4570-b59d-82668bd74288.png)


### 4.2. 내부 발주서 흐름
![수정3](https://user-images.githubusercontent.com/80299163/132401893-fd084eaa-4cde-4b2a-ac72-853fc1bb71fe.png)

### 4.3. 외부 발주서 흐름

![수정4](https://user-images.githubusercontent.com/80299163/132401942-e0eb3d85-7fe8-425b-ab9e-79cfd977df62.png)

### 4.4. 그 외

* 사원 정보 등록 & 수정
* 퇴사 처리(권한 제거)
* 매장, 상품 정보 등록
* 총 상품 평균 수익률 계산
* 외부 API 연동(카카오 주소 찾기, 카카오 맵) 
* Spring SMTP Server 이용하여 메일 전송 (비밀번호 재설정)
* Spring Security를 이용한 권한 설정 및 관리
* AWS S3를 이용한 이미지 업로드 및 출력


</div>
</details>

</br>


## ✔ 5. 트러블 슈팅
### 5.1. 사원번호 자동생성 기능에서 중복처리 체크

- 사원 정보를 생성할 때, 입사연도, 입사일 8자리 + 랜덤 2자리 숫자로 사원번호를 자동 생성하는 기능을 만들었습니다.

- 사원번호가 PK로 설정되어 있었기 때문에, 간혹 같은 입사연도, 입사일에 대한 정보를 만들 때 중복 에러가 떴습니다.

- 중복을 어떻게 처리할까 고민을 했는데, [[Algorithm] JAVA로 중복이 없고, 순서도 없는 조합(Combination) 구하기!](https://limkydev.tistory.com/156) 라는 글을 읽고, 재귀 함수를 통하여 해결했습니다.


<details>
<summary><b>재귀 함수</b></summary>
<div markdown="1">

~~~java
/**
 * 사원정보 생성 (ComputeServiceImpl.java)
 */

	@Override
	public long mimeEmpCode(Date empDate) {
		
		Random random = new Random();
		int x = random.nextInt(99);
		String ranNum = String.format("%02d", x);

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String dateStr = dateFormat.format(empDate);
		
		long empCode = Long.parseLong(dateStr + ranNum);
		
		
		if(employeeMapper.checkEmpCode(empCode) == 1) {
			return mimeEmpCode(empDate);
		}else {
			return empCode;
		}
	}
~~~

</div>
</details>
<br>

### 5.2. 예외처리를 어디서 해줄것인가에 대한 고민

- 발주서를 작성할 때, 상품 수량이 0이거나, 음수일 때 예외 처리를 해야 하는 작업을 고민하고 있었습니다.

- 클라이언트(브라우저)에서 유효성 검사를 하는게 효율적일지, 서버사이드에서 검사를 하는 게 효율적인지 궁금해서 검색해보았습니다.

- [프론트엔드에서"만" 유효성 검사가 문제인 이유](https://jojoldu.tistory.com/157)의 글을 읽던 중 댓글을 보고 클라이언트와, 서버사이드 양쪽에서 유효성 검사를 해야 한다는 것을 이해했습니다.
<details>
<summary><b>클라이언트 유효성 검사</b></summary>
<div markdown="1">

~~~java
/**
 * 발주서 작성 (store-order/form.jsp)
 * javascript Math.floor 함수를 이용하여 0이상의 값만 작성되게 하였습니다. 
 */

	<form method="post" action="${appRoot }/store-order/order">
	<table class="table table-striped">
		<thead>
		</thead>
		<tbody id="product-table-body">
			<tr class="d-flex">
				<th class="col-3">타입</th>
				<th class="col-7">상품명</th>
				<th class="col-2">수량</th>
			</tr>
			<tr class="d-flex">
				<td class="col-3">
					<select id="product-type-select" onchange="changeTypeSelect(this)">
						<option value="">상품 TYPE</option>
						<c:forEach items="${productTypeList }" var="type">
							<option id="${type.PRODUCT_TYPE }"
								value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
						</c:forEach>
					</select>
				</td>
				<td class="col-7">
					<select class="product-product-select" name='products' style='width:100%'>
						<option value="">타입을 먼저 선택하세요</option>
					</select>
				</td>
				<td class="col-2">
					<input type='number' name='ORDER_EA' onchange='this.value = Math.floor(Math.max(this.value,1))' style="width:50px" value="1">
				</td>
			</tr>
		</tbody>
	</table>
	<button id="product-add-btn" type="button" class="btn btn-secondary" >상품 추가하기</button>
	<input type="number" name="STORE_NO" value="${employee.STORE_NO }" hidden="hidden">
	<input type="number" name="EMP_CODE" value="${employee.EMP_CODE }" hidden="hidden">
	
	<sec:authorize access="!hasAnyRole('ROLE_AM', 'ROLE_ST')">
		<button class="btn btn-primary" type="submit">제출</button>
	</sec:authorize>
	<sec:authorize access="hasAnyRole('ROLE_AM', 'ROLE_ST')">
		<div class="not-message">대리, 사원은 발주서를 작성할 직급이 아닙니다.</div>
	</sec:authorize>
</form>
~~~

</div>
</details>


<details>
<summary><b>서버사이드 유효성 검사</b></summary>
<div markdown="1">

~~~java
/**
 * 발주서 작성 (StoreOrderController)
 */

	@PostMapping("/order")
	@Transactional
	public String addOrder(OrderVO order, String[] products, int[] ORDER_EA, RedirectAttributes rttr) {
		
		//발주수량 유효성 검사(상품의 발주량이 0개인 경우가 있으면 에러 메세지처리)
		for(int i=0; i<products.length; i++) {
			if(ORDER_EA[i] == 0) {
				rttr.addFlashAttribute("message", "수량이 0개인 상품이 있습니다.");
				return "redirect:/store-order/order";
			}
		}
		
		int number = 1;
		//주문번호 채번 서비스 (B01)번부터 시작		
		String ono = computeService.mimeOrderNumberB(number);
		order.setORDER_NO(ono);
		
		for(int i=0; i<products.length; i++) {
			order.setPRODUCT_NO( products[i] );
			order.setORDER_EA( ORDER_EA[i] );
			service.addOrder(order);	//내부 발주서 작성
		}
		rttr.addFlashAttribute("message", "발주서 제출이 되었습니다.");
		return "redirect:/store-order/list";
	}
~~~

</div>
</details>

<br>

## ‼ 6. 회고 / 느낀점

학원에서 다른 팀들이 팀 프로젝트로 진행할 때, 저는 개인 프로젝트로 진행했습니다. 학원에서 배웠던 것들을 모두 실습해보기 위한 욕심 때문에 혼자 하게 되었고 6주간 정말 몰입했습니다. 정신없이 앞만 보고 달려오다 잠시 멈춰 제가 작성한 코드들을 돌아보니, 신경 쓰지 못해 놓친 문제점들을 많이 깨닫게 되었습니다.
<br>

### 6.1. 기록의 부재.

이번에 첫 포트폴리오를 작성하다 보니, 중간중간 이슈에 대한 기록이나, 프로젝트를 위해 공부했던 기록들이 정말 부족했구나 느꼈습니다. 궁금증을 해결에 도움을 주었던 블로그나, 스택오버플로 페이지들을 북마크에 꾸준히 저장해두고 여러 번 읽기는 했는데, 개인적인 생각에 대한 기록도 꾸준히 해야겠구나 느꼈습니다. 기록이 부족하다 보니 유지 보수를 위한 코드 수정에서 애로사항을 많이 겪었습니다.
<br>

### 6.2. 개인 프로젝트를 하다보니 깃허브에 소홀했다.

노트북으로 작성하다 보니, 깃허브 매일매일 푸시를 꼭 해야 할까?라는 의문을 가졌었는데 나중에 코드를 수정하면서 뒤늦게 반성하게 되었습니다. 
<br>

### 6.3. 설계의 중요성.

프로젝트 설계에만 일주일 넘게 했던 것 같습니다. 완벽하게 설계했다고 생각했지만, 실제로 코드를 작성하다 보니 잘못 설계된 부분이 있거나, 미처 신경 쓰지 못해 추가해야 했던 부분이 정말 많았습니다. 이번 프로젝트를 겪으면서 설계가 무엇보다 중요하고, 완벽하게 해야겠구나 느꼈습니다
<br>

### 6.4. REST API를 신경쓰지 않은 URI 구성.

부끄럽지만, 프로젝트를 하면서 REST API가 무엇인지 정확히 이해하지 못하고 있었던 것 같습니다. URI 설계나, method 명 설정 등이 지저분하게 작성했습니다. 설계 부분에서 더 신경 써야 되는 부분인 것 같습니다.
<br>

### 6.5. ajax와 submit 어떤것이 좋을까에 대한 고민

modal을 이용한 부분이 재미있어서, 데이터를 전송하는 방식으로 ajax를 많이 사용했는데 작성하다 보니 특정 동작에서는 submit으로 페이지를 이동하는 부분이 효율적이구나 깨달았습니다. 예를 들어 발주서를 작성했으면, 작성 페이지에 남아있는 것이 아니라, 발주서 목록으로 바로 이동하는 동작이 오는 게 맞기 때문입니다. 역시 REST API와 관련된 부분이라고 생각하고, 앞으로 REST API를 잘 적용할 수 있도록 공부해 나가겠습니다.
<br>

### 6.6. 마무리

첫 프로젝트를 잘 마무리하고 싶었는데, 되돌아보니 미흡한 점이 많아 살짝 부끄럽습니다. 첫 프로젝트라는 핑계로 안주하지 않고, 부족한 점들을 계속 피드백 받아 꾸준히 공부해서 다음 프로젝트에서 더 발전적인 모습을 보여드리겠습니다. 읽어주셔서 감사합니다.
