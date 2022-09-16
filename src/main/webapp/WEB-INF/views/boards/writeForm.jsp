<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form>
		<div class="mb-3 mt-3">
			<input id="title" type="text" class="form-control" placeholder="Enter title">
		</div>
		<div class="mb-3">
			<textarea id="content" class="form-control" rows="8"></textarea>
		</div>
		<button id="btnSave" type="button" class="btn btn-primary">글쓰기완료</button>
	</form>
</div>

<script>
$("#btnSave").click(()=>{
	save();
});
	
	function save(){
		let data = {
				title: $("#title").val(),
				content: $("#content").val()
			};

			$.ajax("/boards", {
				type: "POST",
				dataType: "json", //응답데이터, 이 데이터타입으로 받고싶다는 의미 - 근데 이 타입으로 못받을 수도 있음..ㅠ
				data: JSON.stringify(data), // http body에 가져갈 요청데이터
				headers: { // http header에 가져갈 요청 데이터
					"Content-Type": "application/json"
				}
			}).done((res) => {
				if (res.code == 1) {
					location.href = "/";
				}
			});
	}


</script>

<script>
	$('#content').summernote({
		height : 400
	});
</script>
<%@ include file="../layout/footer.jsp"%>

