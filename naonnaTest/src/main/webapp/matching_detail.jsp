<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
  <link href="${pageContext.request.contextPath}/resources/naonna_main.css" rel="stylesheet" type="text/css"/>
  
  <style>
       .ds-btn li{ list-style:none; float:left; padding:10px; }
    .ds-btn li a span{padding-left:15px;padding-right:5px;width:100%;display:inline-block; text-align:left;}
    .ds-btn li a span small{width:100%; display:inline-block; text-align:left;}
       .btn-container {
          margin-top : 40px;
       }
       .card-img-top {
       		width : 300px;
       }
       .player-board-container {
          margin-top : 60px;
       }
       .team-table, .away-table {
          border : 1px solid black;
       }
       .team-table td:nth-child(odd), .away-table td:nth-child(odd) {
          border : 3px solid black;
          width : 30%;
          text-align : center;
       }
       .vs-table {
          margin-top : 20px;
          border : 2px solid red;
       }
       .vs-table h1 {
          text-align : center;
          font-weight : 900;
          color : red;
       }
       #page_title {
           font-weight : 900;
       }
       .team-name {
          text-align : center;
       }
       .team-name-p {
          font-weight : 900;
          background-color : black;
          color : white;
          padding : 20px 0;
       }
       .matching-detail-table {
          margin-top : 40px;
          border : 1px solid yellow;
       }
       .matching-detail-table tr {
          height : 40px;
          text-align : center;
          font-weight : 600;
       }
       .card_team_info {
          float : left;
       }
       .table {
          margin-top : 40px;
       }
       .table tr td {
          padding : 15px;
       }
  </style>
	
	<script>
	$(document).ready(function () {

		$('#matchingInfo').html("");
		var d = new Date(Date.parse("${requestScope.playDate}"));
		var y = d.getFullYear()+"";
		var m = (d.getMonth()+1)+"";
		var da = d.getDate()+"";
		var h = d.getHours()+"";
		var mi = d.getMinutes()+"";
		
		if(m < 10) {
			m = "0" + m;
		}
		var da = d.getDate();
		if(da < 10) {
			da = "0" + da;
		}
		var h = d.getHours();
		if(h < 10) {
			h = "0" + h;
		}
		var mi = d.getMinutes();
		if(mi < 10) {
			mi = "0" + mi;
		}
		
		if('${requestScope.matFin}' == 1) {
			alert("마감된 매칭입니다.");
			$("#match_wanna").hide();
			$('#selectPeople').hide();								
			$('#finish').attr("disabled", true);
		}
		output = "";
		output += "<tr><td>장소</td><td>" + "${requestScope.matchLocation}" + "</td></tr>";
		output += "<tr><td>시간</td><td>" + y + '-' + m + '-' + da + '&nbsp' + h + ':' + mi + "</td></tr>";
		output += "<tr><td>참가자</td><td>" + "${requestScope.homeTeam}" +"팀 &nbsp" + "${requestScope.people}" +"명" +"</td></tr>";	
		$('#matchingInfo').html(output);

		team_detail("${requestScope.homeTeam}");
		
		$('#finish').click(function() {
			if('${sessionScope.teamName}'== "${requestScope.homeTeam}") {
				var retVal = confirm("매칭을 마감하시겠습니까?");
				if(retVal == true) {
					$.ajax({
						url:'/naonnaTest/matchFinish.do',
						type:'POST',
						dataType: "json",
						contentType : 'application/x-www-form-urlencoded; charset=utf-8',
						data : {"matchingID" : "${requestScope.matchingID}"},
						success:function(data) {
							if(data == 1){
								alert("매칭신청이 마감되었습니다.");
								$("#match_wanna").hide();
								$('#selectPeople').hide();								
								$('#finish').attr("disabled", true);
							}
						},
						error:function() {
							alert("ajax통신 실패!!");
						}
					});
				}
			}
			else{
				alert("마감할 수 있는 권한이 없습니다.");
			}
		});
		
		$('#match_wanna').click(function (){
			if('${sessionScope.nickname}' != "") {
				$.ajax({
					url: '/naonnaTest/messageToMatch.do',
					type:'POST',
					dataType: "json",
					contentType : 'application/x-www-form-urlencoded; charset=utf-8',
					data : {"matchingID" : "${requestScope.matchingID}",
							"sendPeople" : '${sessionScope.nickname}',	
							"teamName" : '${requestScope.homeTeam}',
							"people" : $('#selectPeople').val()
					},
					success:function(data) {
						alert("매칭 신청이 완료되었습니다. 결과를 기다려주세요");				
					},
					error:function() {
						alert("ajax통신 실패!!");
					}
				});
			}
			else {
				alert("로그인이 필요합니다.");
			}
		});
	});
	
	function team_detail(homeTeam) {
		
		$.ajax({
			url:'/naonnaTest/teamOnMatch.do',
			type:'POST',
			dataType: "json",
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			//제이슨 형식의 리턴된 데이터는 아래의 data가 받음
			data : {"team_name" : homeTeam},
			
			success:function(data) {
				console.log("teamDetail" + data);
				$('#homeDetail').attr("href", "team_detail.do?team_name="+ data.team_name);
				var output = '';
				$('#teamEmblem').attr("src", '/naonnaTest/image/' + data.emblem)
				$('#teamName').text("");
				$('#ability').text("");
				$('#area').text("");
				$('#teamName').text("팀명 : " + data.team_name);
				$('#ability').text("실력 : " + data.ability);
				$('#area').text("주요 활동 지역 : " + data.area);
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
  	<jsp:include page="./menu_bar/topnavi.jsp" flush="true"></jsp:include>
	<!-- main contents -->

	<div class="container-content">
	<form name="kakaoId">
		<input type="hidden" name="kakao_Id">
	</form>	
	
      <!-- start main content -->
      <div class="main col-sm-9">
         <div class="player-board-container col-sm-12">
            <div class="player-nameboard col-sm-12">
               <h1 id="page_title">매칭 상세 정보</h1>
            </div>
            <div class="player-table-container row justify-content-md-center col-sm-12">
               <div class="team-name row">
                  <h2 class="team-name-p" id="matchingID"></h2>
               </div>
               <div class="col-sm-4 team-info">
                  <div class="card card_team_info" id="teamDetail">
                           <img id="teamEmblem" class="card-img-top" src="http://img.insight.co.kr/static/2017/03/16/700/K7TX4ZUWQPM421C45J08.jpg" alt="winter">
                           <div class="card-body">
                               <h3 id="teamName" class="card-title text-center">팀 이름</h3><br>
                               <p id="ability" class="card-text text-center">실력 : </p>
                               <p id="area" class="card-text text-center">주 활동 지역 : 지구</p>
                               <a class="btn btn-primary btn-block" id="homeDetail">자세히보기</a>
                           </div>
                      </div>
                   </div>
                   <div class="col-sm-8">
                      <div class="matching_info">
                         <table class="table table-striped" id="matchingInfo">
								<!-- 자바스크립트 출력 -->
                         </table>
                      </div>

	                      <select class="btn btn-primary" id="selectPeople" name="people">
	                      	<option value="1">혼자 참여</option>
	                      	<option value="2">둘이 참여</option>
	                      	<option value="3">셋이 참여</option>
	                      	<option value="4">4명 참여</option>
	                      	<option value="5">5명 참여</option>
	                      	<option value="6">6명 참여</option>
	                      	<option value="7">7명 참여</option>
	                      	<option value="8">8명 참여</option>
	                      	<option value="9">9명 참여</option>
	                      	<option value="10">10 참여</option>
	                      	<option value="11">11명 참여</option>
	                      	<option value='${sessionScope.teamName}'>내 팀으로 참여</option>
	                      </select>
	                       <button class="btn btn-primary" id="match_wanna">참가 신청</button>

	                     

                      <button class="btn btn-warning" onclick="history.back()">목록으로</button>
                      <button class="btn btn-warning" id="finish">참가 마감</button>
               </div>
            </div>
         </div>
      </div>
      <!-- main contents end -->
   </div>
</body>
</html>