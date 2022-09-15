<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form>
		<div class="mb-3 mt-3">
			<input id="username" type="text" class="form-control" placeholder="Enter username">
			<button id="btnUsernameSameCheck" type="button" class="btn btn-warning">유저이름 중복체크</button>
			<!-- 버튼이 폼태그안에 있으면 자동submit이 되므로 꼭 타입지정해주기 -->
		</div>
		<div class="mb-3">
			<input id="password" type="password" class="form-control" placeholder="Enter password">
		</div>
		<div class="mb-3">
			<input id="email" type="email" class="form-control" placeholder="Enter email">
		</div>
		<button id="btnJoin" type="button" class="btn btn-primary">회원가입</button>
	</form>
</div>

<script>
let isUsernameSameCheck = false; //중복체크를 안했다면 false -> submit 불가능

//회원가입
$("#btnJoin").click(()=>{
	if(isUsernameSameCheck == false){
		alert("유저네임 중복 체크를 진행해주세요");
		return;
	}
	//0. 통신오브젝트 생성
	let data = {
			username : $("#username").val(),
			password : $("#password").val(),
			email : $("#email").val()
	};
	
	$.ajax("/join",{
		type: "POST",
		dataType: "json", //응답데이터, 이 데이터타입으로 받고싶다는 의미 - 근데 이 타입으로 못받을 수도 있음..ㅠ
		data: JSON.stringify(data), // http body에 가져갈 요청데이터
		headers: { // http header에 가져갈 요청 데이터
			"Content-Type":"application/json"
		} 
	}).done((res)=>{
		if(res.code == 1){
			location.href="/loginForm";
		}
	});
});


//유저네임 중복 체크
$("#btnUsernameSameCheck").click(()=>{
	//0. 통신 오브젝트 생성 (Get요청은 body가 없다)
	
	//1. 사용자가 적은 username 값 가져오기
	let username= $("#username").val();

	
	//2. Ajax 통신 - db에 존재하는지 확인
	$.ajax("/users/usernameSameCheck?username="+username, {
		type:"GET", //get은 생략가능 ∵ 디폴트가 get이다
		dataType: "json", //안써줘도됨 ∵ 디폴트가 json이다
		async: true //true면 비동기, 무조건 true를 사용한다
	}).done((res)=>{ //코드가 간결해지고 scope
		console.log(res);
	if(res.code == 1){
		//alert("통신성공");
		if(res.data == false){
			alert("아이디가 중복되지 않았습니다.");
			isUsernameSameCheck = true;
		}else{
			alert("아이디가 중복되었어요. 다른 아이디를 사용해주세요.");
			isUsernameSameCheck = false;
			$("#username").val("");
		}
	}
	});
});
</script>

<%@ include file="../layout/footer.jsp"%>

