<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css">
<script
	src="${pageContext.request.contextPath}/resources/jquery-ui-1.12.1/external/jquery/jquery.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>

<!-- 캘린더 라이브러리-->
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<!-- 캘린더 라이브러리-->
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<!-- 캘린더 라이브러리-->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!-- 캘린더 라이브러리-->

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/naonna_main.css">
  <style>
  
     .matching-filter {
        width : 800px;
        height : 200px;
        margin : 45px 45px 45px 150px;
        padding : 30px 40 0px 30px;
        border : 1px solid black;
     }
     .matching-filter-name {
        width : 90%;
     }
     
     .subject-location {
        margin : 8px 0px 10px 8px;
        display : block;
     }
     
     .subject-location h3 {
        color : #252525;
        display : block;
        text-align : center;
        height : 60px;
        padding : 18px 0;
        margin : 8px;
        letter-spacing : 0.8px;
        font-size : 24px;
        width : 144px;
     }
     .filter-location {
        display : inline-block;
        width : 300px;
        padding : 20px 0px 10px 20px;
        margin-left : 20px;   
     }
     
     .filter-location h4 {
        font-size : 16px;
        color : black;
        display : inline;
        text-align : center;
        height : 50px;
        padding : 17px 0;
        margin : 8px;
     }
     .filter-location form {
        display :inline;
     }
     .filter-location select {
        height : 40px;
     }
     .btn {
        width : 100px;
        margin-bottom : 15px;
     }
     .create-matching{
        float : right;
     }
     .table th {
        text-align : center;
     }
     .table-body tr td {
        text-align : center;
        background-color : skyblue;
        border : 1px solid red;
        padding : 10px 5px;
        vertical-align : middle;
     }
  </style>


<script>
	$(document).ready(function() {
		$(function() {
			var currentDate = new Date();
			//					var tomorrow = currentDate.setDate(currentDate.getDate()+1);
			$('input[name="datetimes"]').daterangepicker({

				singleDatePicker : true,
				//        		 		timePicker: true,
				showDropdowns : true,
				startDate : moment().startOf('hour'),
				minDate : currentDate,
				//    		     endDate: moment().startOf('hour').add(0, 'hour'),
				locale : {
					format : 'YYYY/M/DD hh:00'
				//         		    	format: 'YYYY/M/DD'

				}
			});
		});

		
		
		
		
		$(function() {
			$.ajax({
				url:'/naonnaTest/print_matching.do',
				type:'POST',
				dataType: "json",
				contentType : 'application/x-www-form-urlencoded; charset=utf-8',
				//제이슨 형식의 리턴된 데이터는 아래의 data가 받음
				success:function(data) {
					
					$('#print_match').html('');		//기존 것 날려주고..		
					var output = '';
					$.each(data, function(
							index, match) {		//새로 뿌리기
						var d = new Date(match.playDate);
						var y = d.getFullYear();
						var m = (d.getMonth()+1);
						var da = d.getDate();
						var h = d.getHours();
						var mi = d.getMinutes();
						
						
						output += '<tr>';
						output += '<td>' + match.matchLocation + '</td>';
						output += '<td>' + y + '-' + m + '-' + da + '&nbsp' + h + ':' + mi + '</td>';
						output += '<td>' + match.homeTeam + '</td>';
						output += '<td>' + match.matchingID + '</td>';
						output += '<td>' + match.people + '</td>';
						output += '<td><button type="button" class="btn btn-success" id="match_want">신청</button></td>';
						output += '</tr>';
						console.log("output:" + output);
						
					});
					$('#print_match').html(output);
					console.log(data);
				},
				error:function() {
					alert("ajax통신 실패!!");
				}
			});
		});

		$(document).on('click', '#match_want', function() {
			alert('되니?!!!!');
		});

		$('#search_matching').click(function(){
			var matchingCity = $('#city').val();
	  		var matchDate = new Date($('#datePick').val());
	  		search_match(matchDate, matchingCity);
		});
		
	});
		
	function search_match(matchDate, matchingCity) {
		$.ajax({
			url:'/naonnaTest/searchMatching.do',
			type:'POST',
			dataType: "json",
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			data:{	'matchLocation' : matchingCity,
					'playDate' : matchDate},
			
			//제이슨 형식의 리턴된 데이터는 아래의 data가 받음
			success:function(data) {
				
				$('#print_match').html('');		//기존 것 날려주고..
				
				$.each(data, function(index, match) {		//새로 뿌리기
					
					var d = new Date(match.playDate);
					var y = d.getFullYear();
					var m = (d.getMonth()+1);
					var da = d.getDate();
					var h = d.getHours();
					var mi = d.getMinutes();
					
					var output = '';
					output += '<tr>';
					output += '<td>' + match.matchLocation + '</td>';
					output += '<td>' + y + '-' + m + '-' + da + '&nbsp' + h + ':' + mi + '</td>';
					output += '<td>' + match.homeTeam + '</td>';
					output += '<td>' + match.matchingID + '</td>';
					output += '<td>' + match.people + '</td>';
					output += '<td><input type="button" class="btn btn-success" id="match_want">신청</td>';

					output += '</tr>';
					console.log("output:" + output);
					$('#print_match').append(output);
				});
				
				console.log(data);
			},
			error:function() {
				alert("ajax통신 실패!!");
			}	
		});
	}

</script>
</head>

<body>
	<!-- Top menu -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<!-- Logo div -->
		<div class="navbar-header">
			<a class="navbar-brand" href="#myPage">Input NAONNALogo</a>
		</div>
		<!-- Logo div end -->

		<!-- Main menu -->

		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#myPage">대관신청</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">매칭 신청 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">매칭 검색/등록</a></li>
						<li><a href="#">용병 모집/등록</a></li>
					</ul></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">팀 관리 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">팀 검색/생성</a></li>
						<li><a href="#">용병 모집/등록</a></li>
					</ul></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">고객센터 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">공지사항</a></li>
						<li><a href="#">FAQ</a></li>
						<li><a href="#">QnA</a></li>
					</ul></li>
				<li><a href="#tour">자유게시판</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">관리메뉴 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">회원관리</a></li>
						<li><a href="#">경기장 등록</a></li>
					</ul></li>
			</ul>
		</div>

		<!-- Main menu end -->

	</nav>

	<!-- end of top menu -->


	<!-- main contents -->

	<div class="container-content">

		<!-- side menu bar start -->

		<div class="side-profile col-sm-4">
			<div class="card">
				<img src="https://t1.daumcdn.net/cfile/tistory/213D18435900DDE00E"
					alt="John" style="width: 100%">
				<h1>User Name</h1>
				<br>
				<p>
					<a href="#">My page</a>
				</p>
				<p>
					<a href="#">My team</a>
				</p>
				<p>
					<a href="#">Matching</a>
				</p>
				<p>
					<a href="#">Booking</a>
				</p>
				<p>
					<a href="#">My page</a>
				</p>
				<p>
					<a href="#">My page</a>
				</p>
			</div>
		</div>
		<!-- side menu bar end -->

		<!-- start main content -->

		<div class="main col-sm-8">
			<br>

			<!--  team filter start -->
			<div class="matching-filter">
				<div class="matching-filter-name">
					<div class="subject-location">
						<h3>매칭 검색</h3>
					</div>
					<div class="filter-location">
						<h4>위치</h4>
						<form action="#">
							<select name="location" class="custom-select mb-3" id="city">
								<option value=''>지역 선택</option>
								<option value="강동구">강동구</option>
								<option value="강북구">강북구</option>
								<option value="강서구">강서구</option>
								<option value="관악구">관악구</option>
								<option value="광진구">광진구</option>
								<option value="구로구">구로구</option>
								<option value="금천구">금천구</option>
								<option value="노원구">노원구</option>
								<option value="도봉구">도봉구</option>
								<option value="동대문구">동대문구</option>
								<option value="동작구">동작구</option>
								<option value="마포구">마포구</option>
								<option value="서대문구">서대문구</option>
								<option value="서초구">서초구</option>
								<option value="성동구">성동구</option>
								<option value="성북구">성북구</option>
								<option value="송파구">송파구</option>
								<option value="양천구">양천구</option>
								<option value="영등포구">영등포구</option>
								<option value="용산구">용산구</option>
								<option value="은평구">은평구</option>
								<option value="종로구">종로구</option>
								<option value="중구">중구</option>
								<option value="중랑구">중랑구</option>
							</select>
						</form>
					</div>
					<div class="filter-location">
						<h4>날짜</h4>
						<!--  시간 선택 API  -->
						<input type="text" id="datePick" name="datetimes" style="width: 55%" />
						<button type="button" class="btn btn-primary" id="search_matching">검색</button>

					</div>
				</div>

			</div>

			<div class="container-board">
				<button type="button" class="btn btn-primary create-matching">매칭 생성</button>
				<table class="table">
					<thead>
						<tr class="success">
							<th>지역</th>
							<th>경기일정</th>
							<th>팀</th>
							<th>제목</th>
							<th>인원</th>
							<th>신청 버튼</th>							
						</tr>
					</thead>
					<tbody class="table-body" id="print_match">

					</tbody>
				</table>
			</div>
		</div>

		<!-- main contents end -->

	</div>


</body>
</html>