let isUsernameSameCheck = false; //중복체크를 안했다면 false -> submit 불가능

//회원가입
$("#btnJoin").click(() => {
	join();
});


//유저네임 중복 체크
$("#btnUsernameSameCheck").click(() => {
	checkUsername();
});

$("#btnLogin").click(() => {
	login();
});

$("#btnDelete").click(() => {
	resign();
});

$("#btnUpdate").click(() => {
	update();
});

function join(){
	if (isUsernameSameCheck == false) {
		alert("유저네임 중복 체크를 진행해주세요");
		return;
	}
	//0. 통신오브젝트 생성
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		email: $("#email").val()
	};

	$.ajax("/join", {
		type: "POST",
		dataType: "json", //응답데이터, 이 데이터타입으로 받고싶다는 의미 - 근데 이 타입으로 못받을 수도 있음..ㅠ
		data: JSON.stringify(data), // http body에 가져갈 요청데이터
		headers: { // http header에 가져갈 요청 데이터
			"Content-Type": "application/json"
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/loginForm";
		}
	});
}

function checkUsername(){
	//0. 통신 오브젝트 생성 (Get요청은 body가 없다)

	//1. 사용자가 적은 username 값 가져오기
	let username = $("#username").val();


	//2. Ajax 통신 - db에 존재하는지 확인
	$.ajax(`/users/usernameSameCheck?username=${username}`, {
		type: "GET", //get은 생략가능 ∵ 디폴트가 get이다
		dataType: "json", //안써줘도됨 ∵ 디폴트가 json이다
		async: true //true면 비동기, 무조건 true를 사용한다
	}).done((res) => { //코드가 간결해지고 scope가 명확해진다
		if (res.code == 1) {
			//alert("통신성공");
			if (res.data == false) {
				alert("아이디가 중복되지 않았습니다.");
				isUsernameSameCheck = true;
			} else {
				alert("아이디가 중복되었어요. 다른 아이디를 사용해주세요.");
				isUsernameSameCheck = false;
				$("#username").val("");
			}
		}
	});
}

function login(){
	//alert("login함수 실행됨")
	//0. 통신 오브젝트 생성하기(JS 오브젝트)
	let data = {
		username: $("#username").val(),
		password: $("#password").val(),
		remember: $("#remember").prop("checked")
	};

	$.ajax("/login", {
		type: "POST",
		dataType: "json",      //응답 데이터(json으로 받고 싶어!)
		data: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json; charset=utf-8"
		}
	}).done((res) => {
		if (res.code == 1) {
			location.href = "/";
		} else {
			alert("로그인 실패");
		}
	});
}

function resign(){
	let id = $("#id").val();

	$.ajax("/users/" + id, {
		type: "DELETE",
		dataType: "json"      //응답 데이터(json으로 받고 싶어!)
	}).done((res) => {
		if (res.code == 1) {
			alert("회원탈퇴 완료");
			location.href = "/";
		} else {
			alert("회원 탈퇴 실패");
		}
	});
}

function update(){
	let data = {
		password: $("#password").val(),
		email: $("#email").val()
	};
	let id = $("#id").val();

	$.ajax("/users/" + id, {
		type: "PUT",
		dataType: "json",      //응답 데이터(json으로 받고 싶어!)
		data: JSON.stringify(data),
		headers: {
			"Content-Type": "application/json; charset=utf-8"
		}
	}).done((res) => {
		if (res.code == 1) {
			alert("회원수정 완료");
			location.reload(); //f5, 페이지 새로고침
		} else {
			alert("회원정보수정 실패");
		}
	});
}